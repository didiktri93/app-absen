<?php

use App\Http\Controllers\API\AbsenController;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\KehadiranController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::post('/login', [AuthController::class, 'login'])->name('login');
Route::group(['middleware' => 'auth:sanctum'], function () {
    Route::get('get-kehadiran-today', [KehadiranController::class, 'getKehadiranToday']);
    Route::get('get-jadwal', [KehadiranController::class, 'getJadwal']);
    Route::post('store-kehadiran', [KehadiranController::class, 'store']);
    Route::get('get-kehadiran-month-year/{month}/{year}', [KehadiranController::class, 'getKehadiranMonthAndYear']);
    Route::post('banned', [KehadiranController::class, 'banned']);
    Route::get('get-image', [KehadiranController::class, 'getImage']);
});

Route::post('store-absen', [AbsenController::class, 'storeAbsen']);
Route::post('get-absen-today', [AbsenController::class, 'getAbsenToday']);
Route::post('get-karyawan', [AbsenController::class, 'getKaryawan']);

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
