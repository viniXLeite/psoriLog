<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RegistroSintoma extends Model
{
    use HasFactory;

    protected $fillable = [
        'paciente_id',
        'coceira',
        'dor',
        'descamacao',
        'qualidade_vida',
        'observacao',
        'data_registro'
    ];
}
