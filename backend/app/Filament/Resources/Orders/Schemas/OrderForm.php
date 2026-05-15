<?php

namespace App\Filament\Resources\Orders\Schemas;

use Filament\Schemas\Schema;
use Filament\Schemas\Components\Section;

use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Repeater;
use Filament\Forms\Components\ViewField;


class OrderForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([

                Section::make('Order Information')
                    ->schema([

                        TextInput::make('customer_name')
                            ->disabled(),

                        TextInput::make('customer_email')
                            ->disabled(),

                        TextInput::make('product_name')
                            ->label('Product')
                            ->formatStateUsing(
                                fn ($record) => $record?->product?->name
                            )
                            ->disabled(),

                        TextInput::make('quantity')
                            ->disabled(),

                        TextInput::make('total_price')
                            ->numeric()
                            ->disabled(),

                        TextInput::make('payment_status')
                            ->label('Payment Status')
                            ->formatStateUsing(
                                fn ($record) => $record?->payment?->payment_status
                            )
                            ->disabled(),

                        TextInput::make('payment_method')
                            ->label('Payment Method')
                            ->formatStateUsing(
                                fn ($record) => $record?->payment?->payment_method
                            )
                            ->disabled(),

                        Select::make('status')
                            ->options([
                                'wip' => 'WIP',
                                'done' => 'Done',
                                'canceled' => 'Canceled',
                            ]),

                        Select::make('progress_stage')
                            ->options([
                                'Sketch Phase' => 'Sketch Phase',
                                'Sketch Approve' => 'Sketch Approve',
                                'Payment Pending' => 'Payment Pending',
                                'Payment Receive' => 'Payment Receive',
                                'Lineart Phase' => 'Lineart Phase',
                                'Coloring/Detailing' => 'Coloring/Detailing',
                                'Background and Finishing' => 'Background and Finishing',
                                'Complete' => 'Complete',
                            ])
                            ->required(),

                    ])
                    ->columns(2),

                Section::make('Characters')
                    ->schema([

                        Repeater::make('characters')
                            ->schema([

                                TextInput::make('character_category')
                                    ->label('Character Category')
                                    ->disabled(),

                                Textarea::make('character_detail')
                                    ->label('Character Detail')
                                    ->disabled()
                                    ->rows(4),

                                Textarea::make('background_detail')
                                    ->label('Background Detail')
                                    ->disabled()
                                    ->rows(4),

                                TextInput::make('background_category')
                                    ->label('Background Category')
                                    ->disabled(),

                                TextInput::make('extra_price')
                                    ->numeric()
                                    ->disabled(),

                                ViewField::make('images')
                                    ->view('filament.forms.components.order-image-preview'),

                            ])
                            ->columns(2)
                            ->disabled(),

                    ])

            ]);
    }
}