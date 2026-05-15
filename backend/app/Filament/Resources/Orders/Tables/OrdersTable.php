<?php

namespace App\Filament\Resources\Orders\Tables;

use Filament\Tables\Table;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Columns\BadgeColumn;
use Filament\Actions\EditAction;

class OrdersTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([

                TextColumn::make('order_id')
                    ->label('ID')
                    ->sortable(),

                TextColumn::make('customer_name')
                    ->searchable(),

                TextColumn::make('product.name')
                    ->label('Product'),

                TextColumn::make('quantity'),

                TextColumn::make('total_price')
                    ->money('IDR')
                    ->sortable(),

                BadgeColumn::make('status')
                    ->colors([
                        'warning' => 'wip',
                        'success' => 'done',
                        'danger' => 'canceled',
                    ]),

                BadgeColumn::make('payment.payment_status')
                    ->label('Payment')
                    ->colors([
                        'success' => 'paid',
                        'danger' => 'expired',
                        'warning' => 'pending',
                    ]),

                TextColumn::make('progress_stage')
                    ->label('Progress')
                    ->wrap(),

                TextColumn::make('created_at')
                    ->dateTime('d M Y H:i'),

            ])

            ->recordActions([
                EditAction::make(),
            ]);
    }
}