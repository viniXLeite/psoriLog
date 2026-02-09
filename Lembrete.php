<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Lembrete extends Model
{
    use HasFactory;

    protected $fillable = [
        'paciente_id',
        'descricao',
        'horario'
    ];
}
