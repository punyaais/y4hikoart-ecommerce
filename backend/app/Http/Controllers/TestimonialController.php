<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Testimonial;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class TestimonialController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'order_id' => 'required|exists:orders,order_id',
            'rating' => 'required|integer|min:1|max:5',
            'comment' => 'required|string',
            'show_username' => 'required|boolean',
        ]);

        $order = Order::where('order_id', $request->order_id)
            ->where('user_id', $request->user()->id)
            ->firstOrFail();

        if ($order->progress_stage !== 'Complete' && $order->status !== 'done') {
            throw ValidationException::withMessages([
                'order_id' => 'Review can only be submitted after the order is completed.'
            ]);
        }

        if ($order->testimonial) {
            throw ValidationException::withMessages([
                'order_id' => 'Review already submitted.'
            ]);
        }

        $testimonial = Testimonial::create([
            'order_id' => $order->order_id,
            'user_id' => $request->user()->id,
            'rating' => $request->rating,
            'comment' => $request->comment,
            'show_username' => $request->show_username
        ]);

        return response()->json([
            'success' => true,
            'data' => $testimonial->load('user')
        ]);
    }

    public function index()
    {
        $testimonials = Testimonial::with('user')
            ->latest()
            ->get();

        return response()->json([
            'success' => true,
            'data' => $testimonials
        ]);
    }
}