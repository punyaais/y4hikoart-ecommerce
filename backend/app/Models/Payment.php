<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Attributes\Fillable;

#[Fillable([
    'order_id',
    'payment_method',
    'payment_status',
    'transaction_id',
    'external_id',
    'amount',
    'paid_at',
    'snap_token',
    'payment_url'
])]

class Payment extends Model
{
    // public function payment()
    // {
    //     return $this->belongsTo(Payment::class, 'payment_id');
    // }
    public function order()
    {
        return $this->belongsTo(Order::class, 'order_id', 'order_id');
    }
}