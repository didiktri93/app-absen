<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Kontrak extends Model
{
    use HasFactory;

    protected $table = 'm_kontrak';
    // protected $primaryKey = 'no_id';
    // public $incrementing = false;

    protected $guarded = [];

    public function karyawan(): BelongsTo
    {
        return $this->belongsTo(Karyawan::class, 'id_karyawan', 'no_id');
    }

    public function jab(): BelongsTo
    {
        return $this->belongsTo(Jabatan::class, 'id_jabatan', 'id');
    }
}
