<?php

namespace App\Filament\Resources;

use App\Filament\Resources\KaryawanResource\Pages;
use App\Filament\Resources\KaryawanResource\RelationManagers;
use App\Models\Karyawan;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class KaryawanResource extends Resource
{
    protected static ?string $model = Karyawan::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('no_id')
                    ->label('ID Pegawai')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('departement')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('nama_lengkap')
                    ->label('Nama Lengkap')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('divisi')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('nik_ktp')
                    ->label('NIK KTP')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('no_kk')
                    ->label('NO. KK')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('tempat_lahir')
                    ->label('Tempat Lahir')
                    ->required()
                    ->maxLength(255),
                Forms\Components\DatePicker::make('tanggal_lahir')
                    ->label('Tanggal Lahir')
                    ->required(),
                Forms\Components\TextInput::make('usia')
                    ->label('Usia')
                    ->required()
                    ->numeric(),
                Forms\Components\TextInput::make('jenis_kelamin')
                    ->label('Jenis Kelamin')
                    ->required()
                    ->maxLength(255),
                Forms\Components\Textarea::make('alamat')
                    ->required()
                    ->maxLength(65535)
                    ->columnSpanFull(),
                Forms\Components\TextInput::make('domisili')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('kode_pos')
                    ->label('Kode Pos')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('agama')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('no_telepon')
                    ->label('No. Tlp')
                    ->tel()
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('email')
                    ->email()
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('pendidikan_terakhir')
                    ->label('Pendidikan Terakhir')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('nama_sekolah')
                    ->label('Nama Sekolah')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('jurusan')
                    ->required()
                    ->maxLength(255),
                Forms\Components\DatePicker::make('doj')
                    ->required(),
                Forms\Components\TextInput::make('masa_kerja')
                    ->label('Masa Kerja')
                    ->required()
                    ->numeric(),
                Forms\Components\TextInput::make('posisi')
                    ->required()
                    ->maxLength(255),
                Forms\Components\DatePicker::make('start_pkwt')
                    ->label('Tanggal Mulai PKWT')
                    ->required(),
                Forms\Components\DatePicker::make('end')
                    ->label('Tanggal Selesai PKWT')
                    ->required(),
                Forms\Components\TextInput::make('status')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('status_pernikahan')
                    ->label('Status Pernikahan')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('rekening')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('bpjs_kes')
                    ->label('BPJS Kesehatan')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('bpjs_tk')
                    ->label('BPJS Tenaga Kerja')
                    ->required()
                    ->maxLength(255),
                Forms\Components\FileUpload::make('cv')
                    ->imagePreviewHeight(150)  // Menampilkan preview gambar (untuk file yang memiliki thumbnail)
                    ->acceptedFileTypes(['application/pdf'])  // Hanya menerima file PDF
                    ->maxSize(10240)  // Maksimal ukuran file dalam KB (misal 10MB = 10240 KB)
                    ->maxFiles(1)  // Maksimal jumlah file yang diunggah
                    ->image(),
                Forms\Components\FileUpload::make('foto')
                    ->imagePreviewHeight(150)  // Menampilkan preview gambar (untuk file yang memiliki thumbnail)
                    ->acceptedFileTypes(['application/pdf'])  // Hanya menerima file PDF
                    ->maxSize(10240)  // Maksimal ukuran file dalam KB (misal 10MB = 10240 KB)
                    ->maxFiles(1)  // Maksimal jumlah file yang diunggah
                    ->image(),
                Forms\Components\FileUpload::make('ktp')
                    ->imagePreviewHeight(150)  // Menampilkan preview gambar (untuk file yang memiliki thumbnail)
                    ->acceptedFileTypes(['application/pdf'])  // Hanya menerima file PDF
                    ->maxSize(10240)  // Maksimal ukuran file dalam KB (misal 10MB = 10240 KB)
                    ->maxFiles(1)  // Maksimal jumlah file yang diunggah
                    ->image(),
                Forms\Components\FileUpload::make('skck')
                    ->imagePreviewHeight(150)  // Menampilkan preview gambar (untuk file yang memiliki thumbnail)
                    ->acceptedFileTypes(['application/pdf'])  // Hanya menerima file PDF
                    ->maxSize(10240)  // Maksimal ukuran file dalam KB (misal 10MB = 10240 KB)
                    ->maxFiles(1)  // Maksimal jumlah file yang diunggah
                    ->image(),
                Forms\Components\FileUpload::make('npwp')
                    ->imagePreviewHeight(150)  // Menampilkan preview gambar (untuk file yang memiliki thumbnail)
                    ->acceptedFileTypes(['application/pdf'])  // Hanya menerima file PDF
                    ->maxSize(10240)  // Maksimal ukuran file dalam KB (misal 10MB = 10240 KB)
                    ->maxFiles(1)  // Maksimal jumlah file yang diunggah
                    ->image(),
                Forms\Components\FileUpload::make('ptkp')
                    ->imagePreviewHeight(150)  // Menampilkan preview gambar (untuk file yang memiliki thumbnail)
                    ->acceptedFileTypes(['application/pdf'])  // Hanya menerima file PDF
                    ->maxSize(10240)  // Maksimal ukuran file dalam KB (misal 10MB = 10240 KB)
                    ->maxFiles(1)  // Maksimal jumlah file yang diunggah
                    ->image(),
                Forms\Components\TextInput::make('nama_kontak_darurat')
                    ->label('Nama Kontak Darurat')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('no_telepon_kontak_darurat')
                    ->label('No. Tlp Kontak Darurat')
                    ->tel()
                    ->required()
                    ->maxLength(255),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('no_id')
                    ->searchable(),
                Tables\Columns\TextColumn::make('departement')
                    ->searchable(),
                Tables\Columns\TextColumn::make('nama_lengkap')
                    ->searchable(),
                Tables\Columns\TextColumn::make('divisi')
                    ->searchable(),
                Tables\Columns\TextColumn::make('nik_ktp')
                    ->searchable(),
                Tables\Columns\TextColumn::make('no_kk')
                    ->searchable(),
                Tables\Columns\TextColumn::make('tempat_lahir')
                    ->searchable(),
                Tables\Columns\TextColumn::make('tanggal_lahir')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('usia')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('jenis_kelamin')
                    ->searchable(),
                Tables\Columns\TextColumn::make('domisili')
                    ->searchable(),
                Tables\Columns\TextColumn::make('kode_pos')
                    ->searchable(),
                Tables\Columns\TextColumn::make('agama')
                    ->searchable(),
                Tables\Columns\TextColumn::make('no_telepon')
                    ->searchable(),
                Tables\Columns\TextColumn::make('email')
                    ->searchable(),
                Tables\Columns\TextColumn::make('pendidikan_terakhir')
                    ->searchable(),
                Tables\Columns\TextColumn::make('nama_sekolah')
                    ->searchable(),
                Tables\Columns\TextColumn::make('jurusan')
                    ->searchable(),
                Tables\Columns\TextColumn::make('doj')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('masa_kerja')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('posisi')
                    ->searchable(),
                Tables\Columns\TextColumn::make('start_pkwt')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('end')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('status')
                    ->searchable(),
                Tables\Columns\TextColumn::make('status_pernikahan')
                    ->searchable(),
                Tables\Columns\TextColumn::make('rekening')
                    ->searchable(),
                Tables\Columns\TextColumn::make('bpjs_kes')
                    ->searchable(),
                Tables\Columns\TextColumn::make('bpjs_tk')
                    ->searchable(),
                Tables\Columns\TextColumn::make('cv')
                    ->searchable(),
                Tables\Columns\TextColumn::make('foto')
                    ->searchable(),
                Tables\Columns\TextColumn::make('ktp')
                    ->searchable(),
                Tables\Columns\TextColumn::make('skck')
                    ->searchable(),
                Tables\Columns\TextColumn::make('npwp')
                    ->searchable(),
                Tables\Columns\TextColumn::make('ptkp')
                    ->searchable(),
                Tables\Columns\TextColumn::make('nama_kontak_darurat')
                    ->searchable(),
                Tables\Columns\TextColumn::make('no_telepon_kontak_darurat')
                    ->searchable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('updated_at')
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
            'index' => Pages\ListKaryawans::route('/'),
            'create' => Pages\CreateKaryawan::route('/create'),
            'edit' => Pages\EditKaryawan::route('/{record}/edit'),
        ];
    }
}
