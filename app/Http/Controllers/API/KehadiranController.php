<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Cuti;
use App\Models\Jadwal;
use App\Models\Kehadiran;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

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

        $today = Carbon::today()->format('Y-m-d');
        $approveCuti = Cuti::where('user_id', auth()->user()->id)
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
        if ($jadwal->banned) {
            return response()->json([
                'success' => false,
                'data' => null,
                'message' => 'Jadwal anda dibanned',
            ]);
        }
        return response()->json([
            'success' => true,
            'data' => $jadwal,
            'message' => 'Berhasil dapatkan jadwal',
        ]);
    }

    public function store(Request $request)
    {
        $validation = Validator::make($request->all(), [
            'latitude' => 'required|numeric',
            'longitude' => 'required|numeric',
        ]);

        if ($validation->fails()) {
            return response()->json([
                'success' => false,
                'data' => $validation->errors(),
                'message' => 'Gagal validasi',
            ], 422);
        };

        $jadwal = Jadwal::where('user_id', auth()->user()->id)->first();

        $today = Carbon::today()->format('Y-m-d');
        $approveCuti = Cuti::where('user_id', auth()->user()->id)
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
            $kehadiran = Kehadiran::where('user_id', auth()->user()->id)
                ->whereDate('created_at', date('Y-m-d'))->first();

            if (!$kehadiran) {
                $kehadiran = Kehadiran::create([
                    'kehadiran_id' => uniqid(),
                    'user_id' => auth()->user()->id,
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

    public function getKehadiranMonthAndYear($month, $year)
    {
        $validation = Validator::make(['month' => $month, 'year' => $year], [
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer|min:2023|max:' . date('Y'),
        ]);

        if ($validation->fails()) {
            return response()->json([
                'success' => false,
                'data' => $validation->errors(),
                'message' => 'Gagal validasi',
            ], 422);
        };

        $userId = auth()->user()->id;
        $kehadiranList = Kehadiran::select('jam_mulai', 'jam_selesai', 'created_at')
            ->where('user_id', $userId)
            ->whereMonth('created_at', $month)
            ->whereYear('created_at', $year)
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
            'data' => $kehadiranList,
            'message' => 'Berhasil kehadiran bulan dan tahun',
        ]);
    }

    public function banned()
    {
        $jadwal = Jadwal::where('user_id', auth()->user()->id)->first();

        if ($jadwal) {
            $jadwal->update([
                'banned' => true,
            ]);
        }

        return response()->json([
            'success' => true,
            'data' => $jadwal,
            'message' => 'Berhasil bannded jadwal',
        ]);
    }

    public function getImage()
    {
        $image = auth()->user()->image_url;
        return response()->json([
            'success' => true,
            'data' => $image,
            'message' => 'Berhasil image',
        ]);
    }
}
