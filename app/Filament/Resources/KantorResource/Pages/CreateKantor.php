<?php

namespace App\Filament\Resources\KantorResource\Pages;

use App\Filament\Resources\KantorResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateKantor extends CreateRecord
{
    protected static string $resource = KantorResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        $data['kntr_id'] = uniqid();

        return $data;
    }
}
