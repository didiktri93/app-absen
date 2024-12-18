<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sqlite_Wajah extends Model
{
    use HasFactory;

    protected $table = 'sqlite_wajah';
    // protected $primaryKey = 'no_id';
    // public $incrementing = false;

    protected $guarded = [];
}
