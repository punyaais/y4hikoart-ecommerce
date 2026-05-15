<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProductRequest;
use App\Http\Resources\ProductCollection;
use App\Http\Resources\ProductResource;
use App\Models\Product;
use App\Models\BackgroundOption;
use Illuminate\Support\Facades\DB;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    // public function index()
    // {
    //     $products = Product::latest()
    //         ->paginate(10)
    //         ->withQueryString();

    //     return new ProductCollection($products);
    // }
    public function index()
    {
        $products = Product::with('category') // 🔥 ini penting
            ->latest()
            ->paginate(10)
            ->withQueryString();

        return new ProductCollection($products);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ProductRequest $request)
    {
        
        $data = $request->validated();

        // upload image
        if ($request->hasFile('image_url')) {

            $path = $request
                ->file('image_url')
                ->store('products', 'public');

            $data['image_url'] = '/storage/' . $path;
        }

        $product = Product::create($data);

        return (new ProductResource($product))
            ->response()
            ->setStatusCode(201);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $product = Product::where('product_id', $id)->firstOrFail();
        $backgrounds = BackgroundOption::all();

            return response()->json([
                'status' => true,
                'message' => 'Product retrieved successfully',
                'product' => new ProductResource($product),
                'backgrounds' => $backgrounds
            ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ProductRequest $request, Product $product)
    {
        $data = $request->validated();

        // upload new image
        if ($request->hasFile('image_url')) {

            $path = $request
                ->file('image_url')
                ->store('products', 'public');

            $data['image_url'] = '/storage/' . $path;
        }

        $product->update($data);

        return (new ProductResource($product))
            ->additional([
                'status' => true,
                'message' => 'Product updated successfully',
            ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Product $product)
    {
        $product->delete();

        return response()->json([
            'status' => true,
            'message' => 'Product deleted successfully',
        ]);
    }

    public function getRouteKeyName()
    {
        return 'product_id';
    }

    public function popular()
    {
        $products = DB::table('orders')
            ->join('products', 'orders.product_id', '=', 'products.product_id')

            // hanya produk aktif
            ->where('products.is_active', 1)

            ->select(
                'orders.product_id',
                DB::raw('COUNT(*) as total_orders')
            )

            ->groupBy('orders.product_id')

            ->orderByDesc('total_orders')

            ->limit(4)

            ->get();

        $productIds = $products->pluck('product_id');

        $result = Product::whereIn('product_id', $productIds)
            ->get()
            ->map(function ($product) use ($products) {

                $orderData = $products->firstWhere(
                    'product_id',
                    $product->product_id
                );

                return [
                    'id' => $product->product_id,
                    'name' => $product->name,
                    'price' => $product->price,
                    'image_url' => $product->image_url,
                    'is_active' => (bool) $product->is_active,
                    'total_orders' => $orderData->total_orders ?? 0
                ];
            })

            ->sortByDesc('total_orders')

            ->values();

        return response()->json($result);
    }
}