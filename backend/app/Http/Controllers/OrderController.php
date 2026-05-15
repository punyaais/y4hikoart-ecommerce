<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\OrderCharacter;
use App\Models\OrderCharacterImages;
use App\Models\Product;
use App\Models\BackgroundOption;
use App\Models\Payment;
use Illuminate\Support\Facades\DB;
use App\Models\AppSetting;
use App\Models\CartItem;

class OrderController extends Controller
{
    public function store(Request $request)
    {
        if (!$request->user()) {
            return response()->json([
                'error' => 'Unauthorized'
            ], 401);
        }

        

        DB::beginTransaction();

        try {
            // 1. ambil product (pakai product_id)
            $product = Product::where('product_id', $request->product_id)->first();

            if (!$product) {
                return response()->json([
                    'error' => 'Product tidak ditemukan'
                ], 404);
            }

            // 2. VALIDASI CHARACTER
            $requiredCharacter = $product->character_required;
            $quantity = $request->quantity ?? 1;
            $totalCharacter = $requiredCharacter * $quantity;

            // cek jumlah character
            if (count($request->characters) !== $totalCharacter) {
                return response()->json([
                    'error' => 'Jumlah character tidak sesuai'
                ], 400);
            }

            // ================== SLOT VALIDATION ==================
            $setting = AppSetting::lockForUpdate()->first();

            if (!$setting) {
                throw new \Exception('Slot belum diatur');
            }

            if ($setting->remaining_slots < $totalCharacter) {
                throw new \Exception('Slot habis');
            }
            

            // 3. HITUNG TOTAL
            $total = 0;

            // base price
            $total += $product->price * $quantity;

            // 4. SIMPAN ORDER
            $order = Order::create([
                'user_id' => $request->user()->id,
                'customer_name' => $request->name,
                'customer_email' => $request->email,
                'product_id' => $request->product_id,
                'total_price' => 0,
                'quantity' => $quantity,
                'status' => 'wip'
            ]);

            // 🔥 4.5 BUAT PAYMENT
            $payment = Payment::create([
                'order_id' => $order->order_id,
                'payment_method' => $request->payment_method, // dari frontend
                'amount' => 0, // nanti update
                'payment_status' => 'pending'
            ]);
            $order->update([
                'payment_id' => $payment->id
            ]);

            // 5. LOOP CHARACTER
            foreach ($request->characters as $index => $char) {

                // 🔥 ambil background dari DB
                $bg = null;
                $bgPrice = 0;

                if (!empty($char['background_id'])) {
                    $bg = BackgroundOption::find($char['background_id']);
                    $bgPrice = $bg ? $bg->price : 0;
                }

                // 🔥 tambah ke total
                $total += $bgPrice;
                $total += $char['extra_price'] ?? 0;

                // 6. SIMPAN CHARACTER
                $character = OrderCharacter::create([
                    'order_id' => $order->order_id,
                    'character_category' => $char['category'],
                    'character_detail' => $char['detail'],
                    'background_id' => $char['background_id'] ?? null,
                    'background_detail' => $char['background_detail'] ?? '',
                    'background_category' => $char['background_category'] ?? 'none',
                    'extra_price' => $char['extra_price'] ?? 0,
                ]);

                // 7. SIMPAN IMAGE
                if ($request->hasFile("characters.$index.images")) {

                    foreach ($request->file("characters.$index.images") as $file) {

                        $path = $file->store('characters', 'public');

                        OrderCharacterImages::create([
                            'character_id' => $character->character_id,
                            'image_url' => '/storage/' . $path
                        ]);
                    }
                }
            }

            // 8. UPDATE TOTAL
            $order->update([
                'total_price' => $total
            ]);
            $payment->update([
                'amount' => $total
            ]);

            // 9. KURANGI SLOT
            $setting->decrement('remaining_slots', $totalCharacter);

            if ($request->filled('cart_item_id')) {
                CartItem::where('id', $request->cart_item_id)->delete();
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Order created',
                'order_id' => $order->order_id,
                'payment_id' => $payment->id,
                'total_price' => $total
            ]);
            

        } catch (\Exception $e) {

            DB::rollBack();

            return response()->json([
                'error' => 'Order gagal',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function index()
    {
        return Order::with('characters.images')->get();
    }

    public function show($id)
    {
        $order = Order::with([
            'product',
            'testimonial.user',
            'characters' => function ($q) {
                $q->with('background', 'images');
            },
            'payment'
        ])->where('order_id', $id)->first();

        if (!$order) {
            return response()->json([
                'error' => 'Order tidak ditemukan'
            ], 404);
        }

        return response()->json($order);
    }
    public function myOrders(Request $request)
    {
        return Order::with([
            'product',
            'testimonial.user',
            'characters' => function ($q) {
                $q->with('background', 'images');
            },
            'payment'
        ])
        ->where('user_id', $request->user()->id)
        ->orderByDesc('order_id')
        ->get();
    }

    public function markDone($id)
    {
        $order = Order::find($id);

        if (!$order) {
            return response()->json([
                'error' => 'Order tidak ditemukan'
            ], 404);
        }

        $order->update([
            'status' => 'done'
        ]);

        return response()->json([
            'success' => true
        ]);
    }

    public function updateProgress(Request $request, $id)
    {
    $request->validate([
        'progress_stage' => [
            'required',
            'in:Sketch Phase,Sketch Approve,Payment Pending,Payment Receive,Lineart Phase,Coloring/Detailing,Background and Finishing,Complete'
        ]
    ]);

    $order = Order::find($id);

    if (!$order) {
        return response()->json([
            'error' => 'Order tidak ditemukan'
        ], 404);
    }

    $order->update([
        'progress_stage' => $request->progress_stage
    ]);

    // otomatis selesai
    if ($request->progress_stage === 'Complete') {
        $order->update([
            'status' => 'done'
        ]);
    }

    return response()->json([
        'success' => true,
        'message' => 'Progress updated',
        'data' => $order
    ]);
}
public function getProgress($id)
{
    $order = Order::find($id);

    if (!$order) {
        return response()->json([
            'error' => 'Order tidak ditemukan'
        ], 404);
    }

    return response()->json([
        'order_id' => $order->order_id,
        'progress_stage' => $order->progress_stage,
        'status' => $order->status
    ]);
}
public function cancel($id)
{
    $order = Order::findOrFail($id);

    if ($order->progress_stage !== 'Sketch Phase') {
        return response()->json([
            'message' => 'Order cannot be cancelled anymore.'
        ], 400);
    }

    $order->status = 'canceled';
    $order->save();

    return response()->json([
        'message' => 'Order cancelled successfully.'
    ]);
}
}