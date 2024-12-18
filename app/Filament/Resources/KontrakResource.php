<?php

namespace App\Filament\Resources;

use App\Filament\Resources\KontrakResource\Pages;
use App\Filament\Resources\KontrakResource\RelationManagers;
use App\Models\Kontrak;
use Carbon\Carbon;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class KontrakResource extends Resource
{
    protected static ?string $pluralLabel = 'Kontrak';

    protected static ?string $model = Kontrak::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('no_kontrak')
                    ->label('No. Kontrak')
                    ->maxLength(255),
                Forms\Components\Select::make('id_karyawan')
                    ->label('Karyawan')
                    ->relationship('karyawan', 'nama_lengkap')
                    ->searchable(),
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

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('no_kontrak')
                    ->label('No. Kontrak')
                    ->searchable(),
                Tables\Columns\TextColumn::make('id_karyawan')
                    ->label('NIK')
                    ->searchable(),
                Tables\Columns\TextColumn::make('karyawan.nama_lengkap')
                    ->label('Nama')
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
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListKontraks::route('/'),
            'create' => Pages\CreateKontrak::route('/create'),
            'edit' => Pages\EditKontrak::route('/{record}/edit'),
        ];
    }
}
