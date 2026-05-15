<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Attributes\Fillable;

#[Fillable([
    'user_id'
])]

class Cart extends Model
{
    public function items()
    {
        return $this->hasMany(CartItem::class, 'cart_id');
    }
}