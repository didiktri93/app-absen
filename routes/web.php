<?php

use App\Exports\KehadiranExport;
use App\Livewire\Presensi;
use Illuminate\Support\Facades\Route;
use Maatwebsite\Excel\Facades\Excel;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/login', function () {
    return redirect('admin/login');
})->name('login');

Route::group(['middleware' => 'auth'], function () {
    Route::get('presensi', Presensi::class)->name('presensi');

    Route::get('kehadiran/export', function () {
        return Excel::download(new KehadiranExport, 'kehadiran.xlsx');
    })->name('presensi-export');
});
