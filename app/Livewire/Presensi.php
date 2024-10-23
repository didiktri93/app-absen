<?php

namespace App\Livewire;

use App\Models\Cuti;
use App\Models\Jadwal;
use App\Models\Kehadiran;
use Carbon\Carbon;
use Livewire\Component;

class Presensi extends Component
{
    public $latitude;
    public $longitude;
    public $dalamRadius = false;
    public function render()
    {
        $jadwal = Jadwal::where('user_id', auth()->user()->id)->first();
        $kehadiran = Kehadiran::where('user_id', auth()->user()->id)
            ->whereDate('created_at', Carbon::today()->format('Y-m-d'))->first();

        return view('livewire.presensi', ['dalamRadius' => $this->dalamRadius], compact('jadwal', 'kehadiran'));
    }

    public function store()
    {
        $this->validate([
            'latitude' => 'required',
            'longitude' => 'required',
        ]);

        $jadwal = Jadwal::where('user_id', auth()->user()->id)->first();

        $today = Carbon::today()->format('Y-m-d');
        $approveCuti = Cuti::where('user_id', auth()->user()->id)
            ->whereDate('tanggal_mulai', '<=', $today)
            ->whereDate('tanggal_selesai', '>=', $today)
            ->exists();

        if ($approveCuti) {
            session()->flash('error', 'Anda sedang melakukan cuti.');
            return;
        }
        if ($jadwal) {
            $kehadiran = Kehadiran::where('user_id', auth()->user()->id)
                ->whereDate('created_at', Carbon::today()->format('Y-m-d'))->first();

            if (!$kehadiran) {
                $kehadiran = Kehadiran::create([
                    'kehadiran_id' => uniqid(),
                    'user_id' => auth()->user()->id,
                    'jadwal_latitude' => $jadwal->kantor->latitude,
                    'jadwal_longitude' => $jadwal->kantor->longitude,
                    'jadwal_jam_mulai' => $jadwal->shift->jam_mulai,
                    'jadwal_jam_selesai' => $jadwal->shift->jam_selesai,
                    'start_latitude' => $this->latitude,
                    'start_longitude' => $this->longitude,
                    'jam_mulai' => Carbon::now()->toTimeString(),
                    'jam_selesai' => Carbon::now()->toTimeString(),
                ]);
            } else {
                $kehadiran->update([
                    'end_latitude' => $this->latitude,
                    'end_longitude' => $this->longitude,
                    'jam_selesai' => Carbon::now()->toTimeString(),
                ]);
            }
        }

        return redirect()->route('presensi', [
            'jadwal' => $jadwal,
            'dalamRadius' => false,
        ]);
    }
}
