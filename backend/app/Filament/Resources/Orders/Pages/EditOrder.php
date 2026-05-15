<?php

namespace App\Filament\Resources\Orders\Pages;

use App\Filament\Resources\Orders\OrderResource;
use Filament\Resources\Pages\EditRecord;

class EditOrder extends EditRecord
{
    protected static string $resource = OrderResource::class;

    protected function mutateFormDataBeforeFill(array $data): array
    {
        $data['characters'] = $this->record
            ->characters()
            ->with('images')
            ->get()
            ->map(function ($character) {

                return [
                    'character_category' => $character->character_category,
                    'character_detail' => $character->character_detail,
                    'background_detail' => $character->background_detail,
                    'background_category' => $character->background_category,
                    'extra_price' => $character->extra_price,

                    'images' => $character->images->map(function ($image) {
                        return [
                            'image_url' => $image->image_url,
                        ];
                    })->toArray(),
                ];

            })
            ->toArray();

        return $data;
    }
}