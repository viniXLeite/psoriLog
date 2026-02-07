<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('prontuarios', function (Blueprint $table) {
            $table->id();

            $table->tinyInteger('nivel_estresse');
            $table->tinyInteger('nivel_coceira');
            $table->tinyInteger('nivel_branco');

            $table->foreignId('paciente_id')
                  ->constrained('pacientes')
                  ->cascadeOnDelete();

            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('prontuarios');
    }
};
