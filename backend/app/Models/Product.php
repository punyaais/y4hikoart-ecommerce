<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Attributes\Fillable;
// use App\Http\Controllers\Api\ProductController;


#[Fillable([
    'name',
    'description',
    'price',
    'category_id',
    'image_url',
    'is_active',
    'character_required'
])]
class Product extends Model
{
    protected $primaryKey = 'product_id';
    protected $table = 'products';

    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id', 'id');
    }
}

