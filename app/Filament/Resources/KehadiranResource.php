<?php

namespace App\Filament\Resources;

use App\Filament\Resources\KehadiranResource\Pages;
use App\Filament\Resources\KehadiranResource\RelationManagers;
use App\Models\Kehadiran;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class KehadiranResource extends Resource
{
    protected static ?string $model = Kehadiran::class;

    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-check';
    protected static ?string $navigationGroup = 'Absensi Management';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('user')
                    ->relationship('user', 'name')
                    ->disabled(),
                Forms\Components\TextInput::make('jadwal_latitude')
                    ->required()
                    ->numeric(),
                Forms\Components\TextInput::make('jadwal_longitude')
                    ->required()
                    ->numeric(),
                Forms\Components\TextInput::make('jadwal_jam_mulai')
                    ->required(),
                Forms\Components\TextInput::make('jadwal_jam_selesai')
                    ->required(),
                Forms\Components\TextInput::make('start_latitude')
                    ->required()
                    ->numeric(),
                Forms\Components\TextInput::make('start_longitude')
                    ->required()
                    ->numeric(),
                Forms\Components\TextInput::make('end_latitude')
                    ->numeric(),
                Forms\Components\TextInput::make('end_longitude')
                    ->numeric(),
                Forms\Components\TextInput::make('jam_mulai')
                    ->required(),
                Forms\Components\TextInput::make('jam_selesai')
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->modifyQueryUsing(function (Builder $query) {
                $superadmin = auth()->user()->hasRole('super_admin');

                if (!$superadmin) {
                    $query->where('user_id', auth()->user()->id);
                    return $query;
                }
            })
            ->columns([
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Tanggal')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('user.name')
                    ->label('Pegawai')
                    ->searchable(),
                Tables\Columns\TextColumn::make('terlambat')
                    ->label('Status')
                    ->badge()
                    ->getStateUsing(function ($record) {
                        return $record->terlambat() ? 'Terlambat' : 'Tepat Waktu';
                    })
                    ->color(fn(string $state): string => match ($state) {
                        'Terlambat' => 'danger',
                        'Tepat Waktu' => 'success',
                    })
                    ->description(fn(Kehadiran $record): string => 'Durasi: ' . $record->durasi_terlambat()),
                Tables\Columns\TextColumn::make('jam_mulai'),
                Tables\Columns\TextColumn::make('jam_selesai'),
                Tables\Columns\TextColumn::make('durasi_kerja')
                    ->getStateUsing(function ($record) {
                        return $record->durasi_kerja();
                    }),
                Tables\Columns\TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('deleted_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->defaultSort('created_at', 'desc')
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
            'index' => Pages\ListKehadirans::route('/'),
            'create' => Pages\CreateKehadiran::route('/create'),
            'edit' => Pages\EditKehadiran::route('/{record}/edit'),
        ];
    }
}
