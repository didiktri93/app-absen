<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Validation\Rules\Unique;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('m_jadwal', function (Blueprint $table) {
            $table->string('jadwal_id', 15)->primary();
            $table->string('user_id', 15)->unique()->references('id')->on('users')->onDelete('cascade');
            $table->string('kntr_id', 15)->references('kntr_id')->on('m_kantor')->onDelete('cascade');
            $table->string('shift_id', 15)->references('shift_id')->on('m_shift')->onDelete('cascade');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('m_jadwal');
    }
};
