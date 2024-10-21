<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Kehadiran extends Model
{
    use HasFactory;

    protected $table = 'm_kehadiran';
    protected $primaryKey = 'kehadiran_id';
    public $incrementing = false;

    protected $guarded = [];
}
