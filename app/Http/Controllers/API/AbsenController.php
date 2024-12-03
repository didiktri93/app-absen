<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Cuti;
use App\Models\Jadwal;
use App\Models\Karyawan;
use App\Models\Kehadiran;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

use function Laravel\Prompts\select;

class AbsenController extends Controller
{
    public function getAbsenToday(Request $request)
    {
        $validation = Validator::make($request->all(), [
            'id' => 'required'
        ]);

        if ($validation->fails()) {
            return response()->json([
                'success' => false,
                'data' => $validation->errors(),
                'message' => 'Gagal validasi',
            ], 422);
        };

        $userId = $request->id;
        $today = now()->toDateString();

        $kehadiranToday = Kehadiran::select('jam_mulai', 'jam_selesai')
            // ->where('user_id', $userId)
            ->whereDate('created_at', $today)
            ->first();

        return response()->json([
            'success' => true,
            'data' => [
                'today' => $kehadiranToday,
            ],
            'message' => 'kehadiran hari ini',
        ]);
    }

    public function getKaryawan()
    {
        // $karyawan = Karyawan::where('status', '0');
        $karyawan = Karyawan::all();

        return response()->json([
            'success' => true,
            'data' => [
                'karyawan' => $karyawan,
            ],
            'message' => 'data karyawan aktif',
        ]);
    }

    public function storeAbsen(Request $request)
    {
        $validation = Validator::make($request->all(), [
            'latitude' => 'required|numeric',
            'longitude' => 'required|numeric',
            'id' => 'required'
        ]);

        if ($validation->fails()) {
            return response()->json([
                'success' => false,
                'data' => $validation->errors(),
                'message' => 'Gagal validasi',
            ], 422);
        };

        $userId = $request->id;
        $jadwal = Jadwal::where('user_id',  $userId)->first();

        $today = Carbon::today()->format('Y-m-d');
        $approveCuti = Cuti::where('user_id',  $userId)
            ->whereDate('tanggal_mulai', '<=', $today)
            ->whereDate('tanggal_selesai', '>=', $today)
            ->exists();

        if ($approveCuti) {
            return response()->json([
                'success' => false,
                'data' => null,
                'message' => 'Anda sedang melakukan cuti.',
            ]);
        }

        if ($jadwal) {
            $kehadiran = Kehadiran::where('user_id', $userId)
                ->whereDate('created_at', date('Y-m-d'))->first();

            if (!$kehadiran) {
                $kehadiran = Kehadiran::create([
                    'kehadiran_id' => uniqid(),
                    'user_id' => $userId,
                    'jadwal_latitude' => $jadwal->kantor->latitude,
                    'jadwal_longitude' => $jadwal->kantor->longitude,
                    'jadwal_jam_mulai' => $jadwal->shift->jam_mulai,
                    'jadwal_jam_selesai' => $jadwal->shift->jam_selesai,
                    'start_latitude' => $request->latitude,
                    'start_longitude' => $request->longitude,
                    'jam_mulai' => Carbon::now()->toTimeString(),
                    'jam_selesai' => Carbon::now()->toTimeString(),
                ]);
            } else {
                $kehadiran->update([
                    'end_latitude' => $request->latitude,
                    'end_longitude' => $request->longitude,
                    'jam_selesai' => Carbon::now()->toTimeString(),
                ]);
            }
            return response()->json([
                'success' => true,
                'data' => $kehadiran,
                'message' => 'Berhasil presensi',
            ]);
        } else {
            return response()->json([
                'success' => false,
                'data' => null,
                'message' => 'Jadwal tidak ditemukan',
            ], 422);
        }
    }
}
