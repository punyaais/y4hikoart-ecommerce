<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cart;
use App\Models\CartItem;

class CartController extends Controller
{
    // ambil cart user login
    public function index(Request $request)
    {
        $user = $request->user();

        $cart = Cart::firstOrCreate([
            'user_id' => $user->id
        ]);

        return Cart::with('items.product')
            ->where('user_id', $user->id)
            ->first();
    }

    // tambah item
    public function add(Request $request)
    {
        $user = $request->user();

        $cart = Cart::firstOrCreate([
            'user_id' => $user->id
        ]);

        $qty = (int) ($request->quantity ?? 1);

        $item = CartItem::where('cart_id', $cart->id)
            ->where('product_id', $request->product_id)
            ->first();

        if ($item) {

            $item->increment('quantity', $qty);

        } else {

            CartItem::create([
                'cart_id' => $cart->id,
                'product_id' => $request->product_id,
                'quantity' => $qty
            ]);
        }

        return response()->json([
            'success' => true,
            'message' => 'Product added to cart'
        ]);
    }
    // update qty
    public function update(Request $request, $id)
    {
        $user = $request->user();

        $item = CartItem::where('id', $id)
            ->whereHas('cart', function ($query) use ($user) {
                $query->where('user_id', $user->id);
            })
            ->first();

        if (!$item) {
            return response()->json([
                'error' => 'Item not found'
            ], 404);
        }

        $item->update([
            'quantity' => $request->quantity
        ]);

        return response()->json([
            'message' => 'updated'
        ]);
    }

    // hapus item
    public function delete(Request $request, $id)
    {
        $user = $request->user();

        $item = CartItem::where('id', $id)
            ->whereHas('cart', function ($query) use ($user) {
                $query->where('user_id', $user->id);
            })
            ->first();

        if (!$item) {
            return response()->json([
                'error' => 'Item not found'
            ], 404);
        }

        $item->delete();

        return response()->json([
            'message' => 'deleted'
        ]);
    }
}