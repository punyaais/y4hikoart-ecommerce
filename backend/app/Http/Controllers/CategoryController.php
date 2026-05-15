<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

class CategoryController extends Controller
{
    public function index()
    {
        $categories = DB::table('categories')
            ->select('id', 'name')
            ->get();

        return response()->json($categories);
    }
}
