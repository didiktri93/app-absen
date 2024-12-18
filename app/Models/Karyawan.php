<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\MorphToMany;

class Karyawan extends Model
{
    use HasFactory;

    protected $table = 'm_karyawan';
    // protected $primaryKey = 'no_id';
    // public $incrementing = false;

    protected $guarded = [];

    public function departemen(): BelongsTo
    {
        return $this->belongsTo(Departemen::class, 'departement', 'dept_id');
    }
    public function div(): BelongsTo
    {
        return $this->belongsTo(Divisi::class, 'divisi', 'divisi_id');
    }
    public function unit(): BelongsTo
    {
        return $this->belongsTo(Unit_Bisnis::class, 'unit_bisnis', 'unit_id');
    }

    public function kontrak(): HasMany
    {
        return $this->hasMany(Kontrak::class, 'id_karyawan', 'no_id');
    }

    public static function countByMonth($year, $month)
    {
        $urut = $year . $month;
        return self::where('no_id', 'like', "$urut%")->count();
    }

    public function getImageUrlAttribute()
    {
        return $this->foto ? asset('storage/' . $this->foto) : null;
    }
}
