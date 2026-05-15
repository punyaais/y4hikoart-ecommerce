<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProductResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->product_id,
            'name' => $this->name,
            'description' => $this->description,
            'price' => (int) $this->price,
            'category' => $this->category->name ?? null,
            'image_url' => $this->image_url,
            'is_active' => (bool) $this->is_active,
            'character_required' => (int) $this->character_required,
            'created_at' => $this->created_at?->toDateTimeString(),
        ];
    }

}
