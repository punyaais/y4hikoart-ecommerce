<?php

namespace App\Filament\Resources\Products\Schemas;

use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Schema;

class ProductForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([

                TextInput::make('name')
                    ->required()
                    ->maxLength(255),

                Textarea::make('description')
                    ->rows(5),

                TextInput::make('price')
                    ->numeric()
                    ->required(),

                Select::make('category_id')
                    ->relationship('category', 'name')
                    ->required(),

                FileUpload::make('image_url')
                    ->label('Image')
                    ->image()
                    ->disk('public')
                    ->directory('products')
                    ->visibility('public')

                    ->formatStateUsing(function ($state) {

                        if (!$state) {
                            return null;
                        }

                        return str_replace('/storage/', '', $state);
                    })

                    ->saveUploadedFileUsing(function ($file) {

                        $path = $file->store('products', 'public');

                        return '/storage/' . $path;
                    }),

                Toggle::make('is_active')
                    ->default(true),

                TextInput::make('character_required')
                    ->numeric()
                    ->default(1)
                    ->required(),

            ]);
    }
}