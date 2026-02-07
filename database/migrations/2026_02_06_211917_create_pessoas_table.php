<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pessoas', function (Blueprint $table) {
            $table->id();

            $table->string('cpf', 11)->unique();
            $table->string('nome');
            $table->tinyInteger('situacao');

            $table->foreignId('endereco_id')
                  ->constrained('enderecos')
                  ->cascadeOnDelete();

            $table->foreignId('contatos_id')
                  ->constrained('contatos')
                  ->cascadeOnDelete();

            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pessoas');
    }
};
