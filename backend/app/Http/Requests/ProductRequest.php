<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Foundation\Http\Attributes\RedirectTo;
use Illuminate\Foundation\Http\Attributes\StopOnFirstFailure;

#[RedirectTo('/products')]  //redirect jika gagal validasi 
#[StopOnFirstFailure]       //stop validasi saat error pertama

class ProductRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|integer|min:0',

            // tambahan sesuai tabel kamu
            'category_id' => 'required|integer',
            'image_url' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:200000',
            'is_active' => 'nullable|boolean',

            'character_required' => 'required|integer|min:1',
        ];
    }
}
