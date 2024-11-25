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
        Schema::create('m_karyawan', function (Blueprint $table) {
            $table->id();
            $table->string('no_id', 8);  // Kolom no_id (misal: 2 angka tahun, 2 angka bulan, 2 angka urutan)
            $table->string('departement');  // Departemen
            $table->string('nama_lengkap');  // Nama lengkap
            $table->string('divisi');  // Divisi
            $table->string('nik_ktp');  // NIK KTP
            $table->string('no_kk');  // No. Kartu Keluarga
            $table->string('tempat_lahir');  // Tempat Lahir
            $table->date('tanggal_lahir');  // Tanggal Lahir
            $table->integer('usia');  // Usia, bisa dihitung otomatis menggunakan query atau event
            $table->enum('jenis_kelamin', ['L', 'P']);  // Jenis kelamin (L/P)
            $table->text('alamat');  // Alamat
            $table->string('domisili');  // Domisili
            $table->string('kode_pos');  // Kode Pos
            $table->string('agama');  // Agama
            $table->string('no_telepon');  // No. Telepon
            $table->string('email')->unique();  // E-mail
            $table->string('pendidikan_terakhir');  // Pendidikan Terakhir
            $table->string('nama_sekolah');  // Nama Sekolah
            $table->string('jurusan');  // Jurusan
            $table->date('doj');  // Tanggal Bergabung (DOJ)
            $table->integer('masa_kerja');  // Masa kerja, bisa dihitung otomatis
            $table->string('posisi');  // Posisi
            $table->date('start_pkwt');  // Start PKWT/TT
            $table->date('end');  // End PKWT/TT
            $table->string('status');  // Status karyawan PKWT/TT
            $table->enum('status_pernikahan', ['Belum Menikah', 'Menikah', 'Janda/Duda']);  // Status Pernikahan
            $table->string('rekening');  // Nomor Rekening
            $table->string('bpjs_kes');  // BPJS Kesehatan
            $table->string('bpjs_tk');  // BPJS Tenaga Kerja
            $table->string('cv')->nullable();  // Link CV
            $table->string('foto')->nullable();  // Link Foto
            $table->string('ktp')->nullable();  // Link KTP
            $table->string('skck')->nullable();  // Link SKCK
            $table->string('npwp')->nullable();  // Link NPWP
            $table->string('ptkp')->nullable();  // Link PTKP
            $table->string('nama_kontak_darurat');  // Nama Kontak Darurat
            $table->string('no_telepon_kontak_darurat');  // No. Telepon Kontak Darurat
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('m_karyawan');
    }
};
