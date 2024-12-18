<?php

namespace App\Filament\Resources\KaryawanResource\RelationManagers;

use Filament\Forms;
use App\Models\Kontrak;
use Carbon\Carbon;
use Filament\Forms\Form;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class KontrakRelationManager extends RelationManager
{
    protected static string $relationship = 'kontrak';
    // protected static ?string $model = Kontrak::class;

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('no_kontrak')
                    ->label('No. Kontrak')
                    ->maxLength(255),
                Forms\Components\DatePicker::make('start_pkwt')
                    ->label('Mulai')
                    ->default(Carbon::now()->toDateString())
                    ->reactive()
                    ->afterStateUpdated(function ($state, $set) {
                        $set('end_pkwt', Carbon::parse($state)->addYear()->toDateString());
                    }),
                Forms\Components\DatePicker::make('end_pkwt')
                    ->label('Selesai')
                    ->default(Carbon::now()->addYear()->toDateString()),
                Forms\Components\Select::make('id_jabatan')
                    ->label('Jabatan')
                    ->relationship('jab', 'jabatan')
                    ->searchable(),
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('kontrak')
            ->columns([
                Tables\Columns\TextColumn::make('no_kontrak')
                    ->label('No. Kontrak')
                    ->searchable(),
                Tables\Columns\TextColumn::make('start_pkwt')
                    ->label('Mulai')
                    ->searchable(),
                Tables\Columns\TextColumn::make('end_pkwt')
                    ->label('Selesai')
                    ->searchable(),
                Tables\Columns\TextColumn::make('jab.jabatan')
                    ->label('Jabatan')
                    ->searchable(),
                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->getStateUsing(function ($record) {
                        return $record->end_pkwt === null
                            ? 'Aktif'
                            : (now()->isAfter($record->end_pkwt) ? 'Selesai' : 'Aktif');
                    })
                    ->color(fn(string $state): string => match ($state) {
                        'Selesai' => 'danger',
                        'Aktif' => 'success',
                    })
            ])
            ->filters([
                //
            ])
            ->headerActions([
                Tables\Actions\CreateAction::make(),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }
}
