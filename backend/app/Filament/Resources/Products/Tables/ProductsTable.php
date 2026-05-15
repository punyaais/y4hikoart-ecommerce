<?php

namespace App\Filament\Resources\Products\Tables;

use Filament\Tables\Table;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Columns\ImageColumn;
use Filament\Tables\Columns\IconColumn;
use Filament\Actions\EditAction;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;

class ProductsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([

                ImageColumn::make('image_url')
                    ->label('Image')
                    ->circular(false)
                    ->square()
                    ->size(80)
                    ->getStateUsing(function ($record) {

                        if (!$record->image_url) {
                            return null;
                        }

                        return asset($record->image_url);
                    }),

                TextColumn::make('name')
                    ->searchable(),

                TextColumn::make('category.name')
                    ->label('Category'),

                TextColumn::make('price')
                    ->money('IDR'),

                TextColumn::make('character_required')
                    ->label('Character'),

                IconColumn::make('is_active')
                    ->label('Open')
                    ->boolean(),

                TextColumn::make('created_at')
                    ->date('d M Y'),

            ])

            ->filters([
                //
            ])

            ->recordActions([
                EditAction::make(),
            ])

            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}