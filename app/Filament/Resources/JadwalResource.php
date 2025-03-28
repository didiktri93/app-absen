<?php

namespace App\Filament\Resources;

use App\Filament\Resources\JadwalResource\Pages;
use App\Filament\Resources\JadwalResource\RelationManagers;
use App\Models\Jadwal;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class JadwalResource extends Resource
{
    protected static ?string $pluralLabel = 'Jadwal';
    protected static ?string $model = Jadwal::class;

    protected static ?string $navigationIcon = 'heroicon-o-calendar-days';
    protected static ?string $navigationGroup = 'Absensi Management';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Group::make()
                    ->schema([
                        Forms\Components\Section::make()
                            ->schema([
                                Forms\Components\Toggle::make('banned'),
                                Forms\Components\Select::make('user_id')
                                    ->relationship('karyawan', 'nama_lengkap')
                                    ->required(),
                                Forms\Components\Select::make('kntr_id')
                                    ->relationship('kantor', 'nama_kntr')
                                    ->required(),
                                Forms\Components\Select::make('shift_id')
                                    ->relationship('shift', 'nama_shift')
                                    ->required(),
                                Forms\Components\Toggle::make('wfa')
                            ])
                    ])
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->modifyQueryUsing(function (Builder $query) {
                $superadmin = auth()->user()->hasRole('super_admin');

                if (!$superadmin) {
                    $query->where('user_id', auth()->user()->id_karyawan);
                    return $query;
                }
            })
            ->columns([
                Tables\Columns\TextColumn::make('karyawan.nama_lengkap')
                    ->searchable(),
                Tables\Columns\ToggleColumn::make('banned')
                    ->label('Banned')
                    ->hidden(fn() => !auth()->user()->hasRole('super_admin')),
                Tables\Columns\BooleanColumn::make('wfa')
                    ->label('WFA'),
                Tables\Columns\TextColumn::make('shift.nama_shift')
                    ->description(fn(Jadwal $record): string => $record->shift->jam_mulai . ' - ' . $record->shift->jam_selesai)
                    ->searchable(),
                Tables\Columns\TextColumn::make('kantor.nama_kntr')
                    ->searchable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('deleted_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
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
            'index' => Pages\ListJadwals::route('/'),
            'create' => Pages\CreateJadwal::route('/create'),
            'edit' => Pages\EditJadwal::route('/{record}/edit'),
        ];
    }
}
