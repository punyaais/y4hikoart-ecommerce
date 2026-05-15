<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Attributes\Fillable;

    #[Fillable([
        'character_id',
        'image_url'
    ])]

class OrderCharacterImages extends Model
{
    protected $primaryKey = 'image_id';
    public $timestamps = false;

    public function character()
    {
        return $this->belongsTo(OrderCharacter::class, 'character_id');
    }
}