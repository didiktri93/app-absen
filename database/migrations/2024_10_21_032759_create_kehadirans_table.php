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
        Schema::create('m_kehadiran', function (Blueprint $table) {
            $table->string('kehadiran_id', 15)->primary();
            $table->string('user_id', 15)->references('id')->on('users')->onDelete('cascade');
            $table->double('jadwal_latitude');
            $table->double('jadwal_longitude');
            $table->time('jadwal_jam_mulai');
            $table->time('jadwal_jam_selesai');
            $table->double('start_latitude');
            $table->double('start_longitude');
            $table->double('end_latitude');
            $table->double('end_longitude');
            $table->time('jam_mulai');
            $table->time('jam_selesai');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('m_kehadiran');
    }
};
