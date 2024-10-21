<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Kantor extends Model
{
    use HasFactory;

    protected $table = 'm_kantor';
    protected $primaryKey = 'kntr_id';
    public $incrementing = false;

    protected $guarded = [];
}
