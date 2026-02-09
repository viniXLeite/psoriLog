<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Notificacao extends Model
{
    use HasFactory;

    protected $fillable = [
        'usuario_id',
        'mensagem',
        'lida'
    ];
}