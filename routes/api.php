<?php

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

Route::post('/login', [AuthController::class, 'login']);
Route::group(['middleware' => 'auth:sanctum'], function () {
    Route::get('get-kehadiran-today', [KehadiranController::class, 'getKehadiranToday']);
    Route::get('get-jadwal', [KehadiranController::class, 'getJadwal']);
});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
