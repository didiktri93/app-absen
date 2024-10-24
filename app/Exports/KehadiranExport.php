<?php

namespace App\Exports;

use App\Models\Kehadiran;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\WithHeadings;

class KehadiranExport implements FromQuery, WithHeadings
{
    public function query()
    {
        return Kehadiran::query()
            ->join('users', 'tr_kehadiran.user_id', '=', 'users.id')
            ->select([
                'users.name as nama',
                'tr_kehadiran.created_at as tanggal',
                'tr_kehadiran.jam_mulai as masuk',
                'tr_kehadiran.jam_selesai as keluar',

            ]);
    }

    public function headings(): array
    {
        return [
            'Nama',
            'Waktu',
            'Masuk',
            'Keluar',
        ];
    }
}
