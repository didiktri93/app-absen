<?php

namespace App\Filament\Resources;

use App\Filament\Resources\KaryawanResource\Pages;
use App\Filament\Resources\KaryawanResource\RelationManagers;
use App\Models\Departemen;
use App\Models\Divisi;
use App\Models\Karyawan;
use Filament\Forms;
use Filament\Forms\Components\Select;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Support\Enums\FontWeight;
use Filament\Tables;
use Filament\Tables\Columns\TextColumn\TextColumnSize;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Illuminate\Support\Carbon;

class KaryawanResource extends Resource
{
    protected static ?string $pluralLabel = 'Karyawan';

    protected static ?string $model = Karyawan::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        $all_option = ['all' => 'ALL'];

        return $form
            ->schema([
                Forms\Components\DatePicker::make('doj')
                    ->label('Tanggal Bergabung')
                    ->live()
                    ->required()
                    ->default(Carbon::now()->toDateString())
                    ->afterStateUpdated(function ($state, $get, $set) {
                        if ($state) {
                            $date = Carbon::parse($state);
                            $year = $date->format('y'); // Ambil dua digit tahun
                            $month = $date->format('m'); // Ambil dua digit bulan
                            // Hitung jumlah pegawai yang sudah ada pada bulan dan tahun ini
                            $sequence = Karyawan::countByMonth($year, $month) + 1; // Tambahkan 1 untuk pegawai baru
                            // Ubah nilai no_id secara otomatis ketika tgl bergabung berubah
                            $set('no_id', "{$year}{$month}" . str_pad($sequence, 2, '0', STR_PAD_LEFT));
                        } else {
                            $set('no_id', ''); // Jika tgl bergabung kosong, hapus ID
                        }
                    }),
                Forms\Components\TextInput::make('no_id')
                    ->label('ID Pegawai')
                    ->required()
                    ->maxLength(255)
                    ->default(function ($get) {
                        // Ambil tanggal dari DatePicker
                        $doj = $get('doj'); // Mengambil nilai dari input tanggal bergabung
                        if ($doj) {
                            $date = Carbon::parse($doj);
                            $year = $date->format('y'); // Ambil dua digit tahun
                            $month = $date->format('m'); // Ambil dua digit bulan
                            $sequence = Karyawan::countByMonth($year, $month) + 1;

                            // Format: YYMM01
                            return "{$year}{$month}" . str_pad($sequence, 2, '0', STR_PAD_LEFT);
                        }
                        return '';
                    }),
                Forms\Components\TextInput::make('nama_lengkap')
                    ->label('Nama Lengkap')
                    ->required()
                    ->maxLength(255),
                Forms\Components\Select::make('departement')
                    ->label('Departemen')
                    ->reactive()
                    ->preload()
                    ->searchable()
                    ->options(fn() => array_merge(
                        $all_option,
                        \App\Models\Departemen::pluck('dept', 'dept_id')->toArray(),
                    )),
                Forms\Components\Select::make('divisi')
                    ->label('Divisi')
                    ->reactive()
                    ->preload()
                    ->searchable()
                    // ->disabled(fn($get) => !$get('departement')) // Only enable if a departemen is selected
                    ->options(
                        fn($get) =>
                        array_merge(
                            $all_option,
                            \App\Models\Divisi::where('dept_id', $get('departement'))
                                ->pluck('divisi_nama', 'divisi_id')->toArray()
                        )
                    ),
                Forms\Components\Select::make('unit_bisnis')
                    ->label('Unit Bisnis')
                    ->reactive()
                    ->preload()
                    ->searchable()
                    // ->disabled(fn($get) => !$get('divisi')) // Only enable if a divisi is selected
                    ->options(
                        fn($get) =>
                        array_merge(
                            $all_option,
                            \App\Models\Unit_Bisnis::where('div_id', $get('divisi'))
                                ->pluck('unit_nama', 'unit_id')->toArray()
                        )
                    ),
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
                Forms\Components\Select::make('jenis_kelamin')
                    ->label('Jenis Kelamin')
                    ->required()
                    ->options([
                        'L' => 'Laki-laki',
                        'P' => 'Perempuan',
                    ]),
                Forms\Components\Textarea::make('alamat')
                    ->required()
                    ->maxLength(65535),
                Forms\Components\TextInput::make('domisili')
                    ->maxLength(255),
                Forms\Components\TextInput::make('kode_pos')
                    ->label('Kode Pos')
                    ->maxLength(255),
                Forms\Components\Select::make('agama')
                    ->required()
                    ->options([
                        'ISLAM' => 'Islam',
                        'KRISTEN' => 'Kristen',
                        'KATHOLIK' => 'Katholik',
                        'HINDU' => 'Hindu',
                        'BUDDHA' => 'Buddha',
                        'KHONGHUCU' => 'Khonghucu',
                    ]),
                Forms\Components\TextInput::make('no_telepon')
                    ->label('No. Tlp')
                    ->tel()
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('email')
                    ->email()
                    ->required()
                    ->maxLength(255),
                Forms\Components\Select::make('pendidikan_terakhir')
                    ->label('Pendidikan Terakhir')
                    ->required()
                    ->options([
                        'SD' => 'SD',
                        'SMP' => 'SMP',
                        'SMA' => 'SMA',
                        'SMK' => 'SMK',
                        'S1' => 'S1',
                        'S2' => 'S2',
                        'S3' => 'S3',
                    ]),
                Forms\Components\TextInput::make('nama_sekolah')
                    ->label('Nama Sekolah')
                    ->maxLength(255),
                Forms\Components\TextInput::make('jurusan')
                    ->maxLength(255),
                Forms\Components\Select::make('status')
                    ->required()
                    ->options([
                        '1' => 'PKWT',
                        '2' => 'PKWTT',
                    ]),
                Forms\Components\Select::make('status_pernikahan')
                    ->label('Status Pernikahan')
                    ->required()
                    ->options([
                        'KAWIN' => 'KAWIN',
                        'BELUM KAWIN' => 'BELUM KAWIN',
                    ]),
                Forms\Components\TextInput::make('rekening')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('bpjs_kes')
                    ->label('BPJS Kesehatan')
                    ->maxLength(255),
                Forms\Components\TextInput::make('bpjs_tk')
                    ->label('BPJS Tenaga Kerja')
                    ->maxLength(255),
                Forms\Components\FileUpload::make('cv')
                    ->label('CV')
                    ->imagePreviewHeight(150)  // Menampilkan preview gambar (untuk file yang memiliki thumbnail)
                    ->acceptedFileTypes(['application/pdf'])  // Hanya menerima file PDF
                    ->maxSize(3072)  // Maksimal ukuran file dalam KB (misal 1MB = 1024 KB)
                    ->maxFiles(1)  // Maksimal jumlah file yang diunggah
                    ->directory(function ($get) {
                        $folder = $get('no_id') . ' - ' . str_replace(' ', '_', $get('nama_lengkap'));   // Assuming you've set up relationships with eloquent
                        return 'dokumen/' . $folder;
                    })
                    ->downloadable(),
                Forms\Components\FileUpload::make('foto')
                    ->imagePreviewHeight(250)  // Menampilkan preview gambar (untuk file yang memiliki thumbnail)
                    ->acceptedFileTypes(['image/jpeg'])  // Hanya menerima file PDF
                    ->maxSize(3072)  // Maksimal ukuran file dalam KB (misal 1MB = 1024 KB)
                    ->maxFiles(1)  // Maksimal jumlah file yang diunggah
                    ->image()
                    ->directory(function ($get) {
                        $folder = $get('no_id') . ' - ' . str_replace(' ', '_', $get('nama_lengkap'));   // Assuming you've set up relationships with eloquent
                        return 'dokumen/' . $folder;
                    })
                    ->downloadable(),
                Forms\Components\FileUpload::make('ktp')
                    ->label('KTP')
                    // ->imagePreviewHeight(150)  // Menampilkan preview gambar (untuk file yang memiliki thumbnail)
                    ->previewable(true)
                    ->acceptedFileTypes(['application/pdf', 'image/jpeg'])  // Hanya menerima file PDF
                    ->maxSize(3072)  // Maksimal ukuran file dalam KB (misal 1MB = 1024 KB)
                    ->maxFiles(1)  // Maksimal jumlah file yang diunggah
                    ->directory(function ($get) {
                        $folder = $get('no_id') . ' - ' . str_replace(' ', '_', $get('nama_lengkap'));   // Assuming you've set up relationships with eloquent
                        return 'dokumen/' . $folder;
                    })
                    ->downloadable(),
                Forms\Components\FileUpload::make('skck')
                    ->label('SKCK')
                    ->previewable(true)
                    ->acceptedFileTypes(['application/pdf', 'image/jpeg'])  // Hanya menerima file PDF
                    ->maxSize(3072)  // Maksimal ukuran file dalam KB (misal 1MB = 1024 KB)
                    ->maxFiles(1)  // Maksimal jumlah file yang diunggah
                    ->directory(function ($get) {
                        $folder = $get('no_id') . ' - ' . str_replace(' ', '_', $get('nama_lengkap'));   // Assuming you've set up relationships with eloquent
                        return 'dokumen/' . $folder;
                    })
                    ->downloadable(),
                Forms\Components\FileUpload::make('npwp')
                    ->label('NPWP')
                    ->imagePreviewHeight(150)  // Menampilkan preview gambar (untuk file yang memiliki thumbnail)
                    ->acceptedFileTypes(['application/pdf', 'image/jpeg'])  // Hanya menerima file PDF
                    ->maxSize(3072)  // Maksimal ukuran file dalam KB (misal 1MB = 1024 KB)
                    ->maxFiles(1)  // Maksimal jumlah file yang diunggah
                    ->directory(function ($get) {
                        $folder = $get('no_id') . ' - ' . str_replace(' ', '_', $get('nama_lengkap'));   // Assuming you've set up relationships with eloquent
                        return 'dokumen/' . $folder;
                    })
                    ->downloadable(),
                Forms\Components\FileUpload::make('ptkp')
                    ->label('PTKP')
                    ->previewable(true)
                    ->imagePreviewHeight(150)  // Menampilkan preview gambar (untuk file yang memiliki thumbnail)
                    ->acceptedFileTypes(['application/pdf', 'image/jpeg'])  // Hanya menerima file PDF
                    ->maxSize(3072)  // Maksimal ukuran file dalam KB (misal 1MB = 1024 KB)
                    ->maxFiles(1)  // Maksimal jumlah file yang diunggah
                    ->directory(function ($get) {
                        $folder = $get('no_id') . ' - ' . str_replace(' ', '_', $get('nama_lengkap'));   // Assuming you've set up relationships with eloquent
                        return 'dokumen/' . $folder;
                    })
                    ->downloadable(),
                Forms\Components\TextInput::make('nama_kontak_darurat')
                    ->label('Nama Kontak Darurat')
                    ->maxLength(255),
                Forms\Components\TextInput::make('no_telepon_kontak_darurat')
                    ->label('No. Tlp Kontak Darurat')
                    ->tel()
                    ->maxLength(255),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->modifyQueryUsing(function (Builder $query) {
                $superadmin = auth()->user()->hasRole('super_admin');

                if (!$superadmin) {
                    $query->where('no_id', auth()->user()->id_karyawan);
                    return $query;
                }
            })
            ->columns([
                Tables\Columns\Layout\Stack::make([
                    Tables\Columns\ImageColumn::make('foto')
                        ->defaultImageUrl(url('/storage/user.png'))
                        ->height(130)
                        ->width(100),
                    Tables\Columns\Layout\Stack::make([
                        Tables\Columns\TextColumn::make('no_id')
                            ->weight(FontWeight::Bold)
                            ->size(TextColumnSize::ExtraSmall)
                            ->searchable(),
                        Tables\Columns\TextColumn::make('nama_lengkap')
                            ->weight(FontWeight::Bold)
                            ->limit(14)
                            ->searchable(),
                        Tables\Columns\TextColumn::make('no_telepon')
                            ->icon('heroicon-m-phone')
                            ->size(TextColumnSize::ExtraSmall)
                            ->color('gray'),
                        Tables\Columns\TextColumn::make('email')
                            ->icon('heroicon-m-envelope')
                            ->size(TextColumnSize::ExtraSmall)
                            ->color('gray'),
                    ]),
                ])->space(3),
            ])
            ->filters([
                //
            ])
            ->contentGrid([
                'md' => 3,
                'xl' => 5,
            ])
            ->actions([
                // Tables\Actions\EditAction::make(),
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
            RelationManagers\KontrakRelationManager::class,
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
