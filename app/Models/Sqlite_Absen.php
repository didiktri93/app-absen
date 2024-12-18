<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sqlite_Absen extends Model
{
    use HasFactory;

    protected $table = 'sqlite_absen';
    // protected $primaryKey = 'no_id';
    // public $incrementing = false;

    protected $guarded = [];
}
