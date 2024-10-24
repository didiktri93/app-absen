<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Jadwal;
use App\Models\Kehadiran;
use Illuminate\Http\Request;

class KehadiranController extends Controller
{
    public function getKehadiranToday()
    {
        $userId = auth()->user()->id;
        $today = now()->toDateString();
        $currentMonth = now()->month;

        $kehadiranToday = Kehadiran::select('jam_mulai', 'jam_selesai')
            ->where('user_id', $userId)
            ->whereDate('created_at', $today)
            ->first();

        $kehadiranMonth = Kehadiran::select('jam_mulai', 'jam_selesai', 'created_at')
            ->where('user_id', $userId)
            ->whereMonth('created_at', $currentMonth)
            ->get()
            ->map(function ($kehadiran) {
                return [
                    'jam_mulai' => $kehadiran->jam_mulai,
                    'jam_selesai' => $kehadiran->jam_selesai,
                    'tgl' => $kehadiran->created_at->toDateString(),
                ];
            });


        return response()->json([
            'success' => true,
            'data' => [
                'today' => $kehadiranToday,
                'this_month' => $kehadiranMonth,
            ],
            'message' => 'kehadiran hari ini',
        ]);
    }

    public function getJadwal()
    {
        $jadwal = Jadwal::with(['kantor', 'shift'])
            ->where('user_id', auth()->user()->id)
            ->first();

        return response()->json([
            'success' => true,
            'data' => $jadwal,
            'message' => 'Berhasil dapatkan jadwal',
        ]);
    }
}
