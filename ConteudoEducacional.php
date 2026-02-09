<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ConteudoEducacional extends Model
{
    use HasFactory;

    protected $fillable = [
        'titulo',
        'descricao',
        'tipo'
    ];
}