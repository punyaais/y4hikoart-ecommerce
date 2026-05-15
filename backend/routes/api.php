<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\AppSettingController;
use App\Http\Controllers\TestimonialController;


Route::get('/products/popular', [ProductController::class, 'popular']);
Route::apiResource('products', ProductController::class);
Route::middleware('auth:sanctum')->apiResource(
    'testimonials',
    TestimonialController::class
);

Route::get('/categories', [CategoryController::class, 'index']);

Route::get('/orders', [OrderController::class, 'index']);
Route::middleware('auth:sanctum')->post('/orders', [OrderController::class, 'store']);
Route::middleware('auth:sanctum')->get(
    '/orders/{id}',
    [OrderController::class, 'show']
);

Route::middleware('auth:sanctum')->group(function () {

    Route::get('/cart', [CartController::class, 'index']);
    Route::post('/cart/add', [CartController::class, 'add']);
    Route::post('/cart/update/{id}', [CartController::class, 'update']);
    Route::delete('/cart/{id}', [CartController::class, 'delete']);

});

Route::post('/payment/xendit', [PaymentController::class, 'createInvoice']);
Route::post('/xendit/webhook', [PaymentController::class, 'webhook']);

Route::get('/test-ssl', function () {
    return Http::get('https://api.xendit.co');
});

Route::get('/test-ssl', function () {
    return Http::withoutVerifying()->get('https://api.xendit.co');
});

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->post('/logout', [AuthController::class, 'logout']);

Route::post('/slots', [AppSettingController::class, 'updateSlot']);
Route::get('/slots', [AppSettingController::class, 'getSlot']);

Route::middleware('auth:sanctum')->get('/me', [AuthController::class, 'me']);
Route::middleware('auth:sanctum')->put('/profile', [AuthController::class, 'updateProfile']);
Route::middleware('auth:sanctum')->get('/me/orders', [OrderController::class, 'myOrders']);
Route::middleware('auth:sanctum')->put(
    '/orders/{id}/done',
    [OrderController::class, 'markDone']
);
Route::middleware('auth:sanctum')->put(
    '/orders/{id}/cancel',
    [OrderController::class, 'cancel']
);

Route::put(
    '/orders/{id}/progress',
    [OrderController::class, 'updateProgress']
);

Route::get(
    '/orders/{id}/progress',
    [OrderController::class, 'getProgress']
);

