<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\AppSetting;

class AppSettingController extends Controller
{
    public function updateSlot(Request $request)
    {
        $request->validate([
            'total_slots' => 'required|integer|min:0'
        ]);

        $setting = AppSetting::first();

        if (!$setting) {
            $setting = AppSetting::create([
                'total_slots' => $request->total_slots,
                'remaining_slots' => $request->total_slots
            ]);
        } else {
            $setting->update([
                'total_slots' => $request->total_slots,
                'remaining_slots' => $request->total_slots
            ]);
        }

        return response()->json([
            'message' => 'Slot berhasil diupdate',
            'data' => $setting
        ]);
    }

    public function getSlot()
    {
        $setting = AppSetting::first();

        if (!$setting) {
            return response()->json([
                'message' => 'Slot belum diatur'
            ], 404);
        }

        return response()->json($setting);
    }
}