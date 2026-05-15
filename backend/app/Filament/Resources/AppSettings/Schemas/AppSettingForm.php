<?php

namespace App\Filament\Resources\AppSettings\Schemas;

use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class AppSettingForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('total_slots')
                    ->required()
                    ->numeric(),
                TextInput::make('remaining_slots')
                    ->required()
                    ->numeric(),
            ]);
    }
}
