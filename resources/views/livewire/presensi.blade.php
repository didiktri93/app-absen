<div>
    <div class="container mx-auto max-w-sm">
        <div class="bg-white p-6 rounded-lg mt-3 shadow-lg">
            <div class="grid grid-cols-1 gap-6 mb-6">
                <div>
                    <h2 class="text-2xl font-bold mb-2">Informasi Pegawai</h2>
                    <div class="bg-gray-100 rounded-lg">
                        <p><strong>Nama Pegawai : </strong> {{ Auth::user()->name }}</p>
                        <p><strong>Kantor : </strong> {{ $jadwal->kantor->nama_kntr }}</p>
                        <p><strong>Shift : </strong> {{ $jadwal->shift->nama_shift }} ({{ $jadwal->shift->jam_mulai }} -
                            {{ $jadwal->shift->jam_selesai }}) WIB</p>
                        @if ($jadwal->wfa)
                        <p><strong>Status : </strong> WFA</p>
                        @else
                        <p><strong>Status : </strong> WFO</p>
                        @endif
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-4">
                        <div class="bg-gray-100 p-4 rounded-lg">
                            <h4 class="text-l font-bold mb-2">Jam Masuk</h4>
                            <p><strong>{{ $kehadiran?$kehadiran->jam_mulai:'-' }}</strong></p>
                        </div>
                        <div class="bg-gray-100 p-4 rounded-lg">
                            <h4 class="text-l font-bold mb-2">Jam Pulang</h4>
                            <p><strong>{{ $kehadiran?$kehadiran->jam_selesai:'-' }}</strong></p>
                        </div>
                    </div>
                </div>
                <div>
                    <h2 class="text-2xl font-bold mb-2">Presensi</h2>
                    <div id="map" class="mb-4 rounded-lg border border-gray-300" wire:ignore></div>
                    @if (session()->has('error'))
                    <div style="color:red; padding: 10px; border: 1px solid red; background-color: #fdd">
                        {{ session('error') }}
                    </div>
                    @endif
                    <form class="row gap-3" wire:submit='store' enctype="multipart/form-data">
                        <button type="button" onclick="tagLocation()"
                            class="px-4 py-2 bg-blue-500 text-white rounded">Tag
                            Lokasi</button>
                        @if ($dalamRadius)
                        <button type="submit" class="px-4 py-2 bg-green-500 text-white rounded">Submit Presensi</button>
                        @endif
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script>
        let map;
        let lat;
        let lng;
        const center = [{{ $jadwal->kantor->latitude }}, {{ $jadwal->kantor->longitude }}];
        const radius = {{ $jadwal->kantor->radius }};
        let component;
        let maker;

        document.addEventListener('livewire:initialized', function() {
            component = @this;
            map = L.map('map').setView([{{ $jadwal->kantor->latitude }}, {{ $jadwal->kantor->longitude }}], 17);
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);

            const circle = L.circle(center, {
                color: 'red',
                fillColor: '#f03',
                fillOpacity: 0.5,
                radius: radius
            }).addTo(map);
        });

        function tagLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    lat = position.coords.latitude;
                    lng = position.coords.longitude;

                    if (maker) {
                        map.removeLayer(maker);
                    }

                    maker = L.marker([lat, lng]).addTo(map);
                    map.setView([lat, lng], 17);

                    if (cekRadius(lat, lng, center, radius)) {
                        component.set('dalamRadius', true);
                        component.set('latitude', lat);
                        component.set('longitude', lng);
                    } else {
                        alert("Anda tidak berada di lokasi kantor");
                    }

            })
        }else{
            alert("Geolocation is not supported by this browser.");
        }
    }

    function cekRadius( lat, lng, center, radius ) {
        const wfa = {{ $jadwal->wfa }};
        if( wfa ) {
            return true;
        }else{
            let distance = map.distance([lat, lng], center);
            return distance <= radius;
        }
    }
    </script>
</div>