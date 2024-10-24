<?php

namespace App\Filament\Resources\KehadiranResource\Pages;

use App\Filament\Resources\KehadiranResource;
use Filament\Actions;
use Filament\Actions\Action;
use Filament\Resources\Pages\ListRecords;

class ListKehadirans extends ListRecords
{
    protected static string $resource = KehadiranResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Action::make('Export Excel')
                ->url(route('presensi-export'))
                ->color('danger'),
            Action::make('Presensi')
                ->url(route('presensi'))
                ->color('success'),
            Actions\CreateAction::make(),
        ];
    }
}
