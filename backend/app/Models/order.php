<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Attributes\Fillable;

#[Fillable([
        'user_id',
        'product_id',
        'payment_id',
        'total_price',
        'quantity',
        'admin_fee',
        'discount_amount',
        'customer_name',
        'customer_email',
        'progress_stage',
        'status'
    ])]

class Order extends Model
{
    protected $primaryKey = 'order_id';
    protected $table = 'orders';

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function characters()
    {
        return $this->hasMany(OrderCharacter::class, 'order_id', 'order_id');
    }

    public function payment()
    {
        return $this->belongsTo(Payment::class, 'payment_id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', 'product_id');
    }
    public function testimonial()
    {
        return $this->hasOne(Testimonial::class, 'order_id', 'order_id');
    }
    public function getKeyName()
    {
        return 'order_id';
    }
}