<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Convite extends Model
{
    use HasFactory;

    protected $fillable = [
        'paciente_id',
        'medico_id',
        'codigo',
        'status'
    ];
}
