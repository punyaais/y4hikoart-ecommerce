<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Attributes\Fillable;

    #[Fillable([
        'total_slots',
        'remaining_slots'
    ])]

class AppSetting extends Model {

    public function getSlot()
    {
        $setting = AppSetting::first();

        if (!$setting) {
            return response()->json([
                'message' => 'Slot belum diatur'
            ], 404);
        }

        return response()->json([
            'total_slots' => $setting->total_slots,
            'remaining_slots' => $setting->remaining_slots
        ]);
    }
}
