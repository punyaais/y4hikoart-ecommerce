<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Attributes\Fillable;



class OrderCharacter extends Model
{
    protected $primaryKey = 'character_id';
    protected $fillable = [
        'order_id',
        'character_category',
        'character_detail',
        'background_id',
        'background_detail',
        'background_category',
        'extra_price',
        'extra_duration',
    ];
    public $timestamps = false;

    public function images()
    {
        return $this->hasMany(OrderCharacterImages::class, 'character_id', 'character_id');
    }

    public function order()
    {
        return $this->belongsTo(order::class, 'order_id', 'order_id');
    }

    public function background()
    {
        return $this->belongsTo(BackgroundOption::class, 'background_id', 'id');
    }
}