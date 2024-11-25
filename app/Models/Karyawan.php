<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Karyawan extends Model
{
    use HasFactory;

    protected $table = 'm_karyawan';
    // protected $primaryKey = 'no_id';
    // public $incrementing = false;

    protected $guarded = [];
}
