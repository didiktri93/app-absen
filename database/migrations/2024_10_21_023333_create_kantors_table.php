<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('m_kantor', function (Blueprint $table) {
            $table->string('kntr_id', 15)->primary();
            $table->string('nama_kntr');
            $table->double('latitude');
            $table->double('longitude');
            $table->double('longitude');
            $table->integer('radius');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('m_kantor');
    }
};
