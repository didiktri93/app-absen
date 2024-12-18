<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Kehadiran extends Model
{
    use HasFactory;

    protected $table = 'tr_kehadiran';
    protected $primaryKey = 'kehadiran_id';
    public $incrementing = false;

    protected $guarded = [];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function karyawan()
    {
        return $this->belongsTo(Karyawan::class, 'user_id', 'no_id');
    }

    public function terlambat()
    {
        $jadwal_jam_mulai = Carbon::parse($this->jadwal_jam_mulai);
        $jam_mulai = Carbon::parse($this->jam_mulai);

        return $jam_mulai->greaterThan($jadwal_jam_mulai);
    }

    public function durasi_terlambat()
    {
        $jadwal_jam_mulai = Carbon::parse($this->jadwal_jam_mulai);
        $jam_mulai = Carbon::parse($this->jam_mulai);

        $terlambat = $jadwal_jam_mulai->diff($jam_mulai);

        $jam = $terlambat->h;
        $menit = $terlambat->i;

        return "{$jam} jam {$menit} menit";
    }

    public function durasi_kerja()
    {
        $jam_mulai = Carbon::parse($this->jam_mulai);
        $jam_selesai = Carbon::parse($this->jam_selesai);

        $durasi = $jam_mulai->diff($jam_selesai);

        $jam = $durasi->h;
        $menit = $durasi->i;

        return "{$jam} jam {$menit} menit";
    }
}
