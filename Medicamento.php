<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Medicamento extends Model
{
    use HasFactory;

    protected $fillable = [
        'paciente_id',
        'nome',
        'tipo',
        'frequencia'
    ];
}
