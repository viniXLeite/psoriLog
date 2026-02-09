<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Relatorio extends Model
{
    use HasFactory;

    protected $fillable = [
        'paciente_id',
        'data_inicio',
        'data_fim',
        'arquivo'
    ];
}