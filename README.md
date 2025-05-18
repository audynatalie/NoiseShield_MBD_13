# Final Project Embedded System - Group 13 
## NoiseShield

### Anggota Kelompok:
- **Audy Natalie Cecilia R.** (2306266962)
- **M. Avicenna Raffaiz A.** (2206062844)
- **Muhammad Hilmy Mahardika** (2306267006)
- **Muhammad Pavel** (2306243363)

## Introduction To The Problem and The Solution

Kebisingan di ruang perawatan bayi baru lahir, khususnya di NICU (Neonatal Intensive Care Unit), merupakan masalah serius yang dapat mengganggu kenyamanan, kestabilan fisiologis, dan perkembangan bayi. Bayi yang masih sangat rentan terhadap gangguan suara dapat mengalami gangguan tidur, stres fisiologis, peningkatan detak jantung, serta gangguan pada perkembangan kognitif jangka panjang jika terpapar suara berlebih. Selain itu, tangisan bayi yang tidak terdeteksi secara cepat bisa menandakan kebutuhan mendesak seperti rasa lapar, ketidaknyamanan, atau masalah medis yang memerlukan respons cepat dari tenaga kesehatan. Namun, pemantauan kebisingan dan suara tangisan di rumah sakit selama ini masih sangat bergantung pada pengawasan manual oleh perawat, yang tidak selalu optimal terutama saat tenaga medis terbatas dan tingkat kewaspadaan menurun di luar jam sibuk.

Untuk mengatasi masalah ini, dikembangkan NoiseShield, sebuah sistem pendeteksi kebisingan otomatis berbasis mikrokontroler Arduino Uno dan sensor suara KY-037. Sistem ini mampu mengukur intensitas suara secara real-time dan memberikan peringatan visual melalui tiga buah LED indikator yang mengklasifikasikan kondisi kebisingan menjadi tiga kategori: hening, kondusif, dan gaduh. Dengan fitur pengaturan *threshold* yang fleksibel, sistem ini dapat diadaptasi untuk berbagai kondisi ruang rawat, termasuk ruang NICU yang memerlukan sensitivitas lebih tinggi untuk mendeteksi tangisan bayi secara cepat dan akurat. Dengan NoiseShield, respons terhadap kebutuhan bayi dapat dilakukan secara lebih efisien dan tepat waktu tanpa ketergantungan penuh pada pengawasan manual oleh tenaga medis.

## Hardware Design and Implementation Details

Komponen utama yang digunakan dalam pengembangan NoiseShield adalah sebagai berikut:

- **Arduino Uno**: Mikrokontroler berbasis ATmega328p yang berfungsi sebagai otak dari sistem loudness detector. Mikrokontroler ini bertugas memproses data dari sensor suara, mengatur logika pendeteksian tingkat kebisingan, dan mengendalikan output berdasarkan pembacaan sensor.

- **Sensor Suara KY-037**: Sensor dengan sensitivitas tinggi yang mengubah gelombang suara menjadi sinyal listrik yang dapat dibaca oleh Arduino melalui pin analog. Sensor ini dilengkapi dengan penguat operasional untuk memperkuat sinyal suara yang diterima, sehingga pembacaan menjadi lebih akurat.

- **LED Indikator (3 buah)**: Digunakan sebagai indikator visual tingkat kebisingan dengan tiga warna berbeda:
  - LED Hijau: Menyala ketika tingkat kebisingan rendah (hening, <30 dB)
  - LED Kuning: Menyala ketika tingkat kebisingan sedang (kondusif, 31-80 dB)
  - LED Merah: Menyala ketika tingkat kebisingan tinggi (gaduh, >80 dB)

- **Resistor**: Resistor dengan nilai 220Ω digunakan untuk membatasi arus yang mengalir ke LED, melindunginya dari kerusakan akibat arus berlebihan.

- **Potensiometer**: Digunakan untuk mengatur tingkat sensitivitas sensor suara atau untuk menetapkan ambang batas kebisingan yang dapat diatur secara manual oleh pengguna.

- **Kabel Jumper dan Breadboard**: Digunakan untuk merangkai komponen-komponen sistem secara non-permanen, memudahkan modifikasi dan pengujian.

- **USB Cable**: Untuk menghubungkan Arduino dengan komputer untuk pemrograman dan komunikasi serial.

Desain rangkaian NoiseShield diawali dengan pembuatan skema rangkaian menggunakan software Proteus, yang memudahkan dalam visualisasi dan pengujian awal sebelum implementasi fisik. Skema rangkaian menghubungkan sensor suara KY-037 ke pin analog Arduino (A0), sementara ketiga LED indikator terhubung ke pin digital yang sudah ditentukan melalui resistor. Konfigurasi ini memungkinkan sistem untuk membaca intensitas suara lingkungan dan memberikan respons visual yang sesuai melalui LED.

Implementasi fisik rangkaian mengacu pada skema yang telah dibuat di Proteus. Komponen-komponen dirakit pada breadboard dengan Arduino Uno sebagai unit pemrosesan utama. Sensor suara KY-037 ditempatkan pada posisi yang memungkinkan pembacaan optimal terhadap suara lingkungan, sementara LED indikator ditempatkan pada posisi yang jelas terlihat oleh pengguna. 

## Software Implementation Details

Software Impementation NoiseShield terdiri dari beberapa komponen utama:

1. **Inisialisasi**: Proses inisialisasi memastikan semua komponen beroperasi dengan benar, termasuk pengaturan stack pointer untuk manajemen memori, konfigurasi UART pada 9600 baud untuk komunikasi serial, menyiapkan pin GPIO untuk LED indikator, dan menyiapkan ADC untuk membaca sensor mikrofon.

2. **Pembacaan ADC**: Konversi sinyal analog dari sensor mikrofon menjadi nilai digital yang dapat diproses oleh mikroprosesor. Sistem memulai konversi ADC, menunggu hingga proses selesai, kemudian membaca hasil 10-bit dan mengkonversinya ke skala desibel 0-100 dB.

3. **Pemrosesan Level Suara**: Sistem mengklasifikasikan tingkat kebisingan ke dalam tiga kategori berdasarkan nilai desibel yang terukur, menggunakan dua nilai ambang batas: HENING_THRESHOLD (30 dB) dan GADUH_THRESHOLD (80 dB). Pembacaan di bawah 30 dB dikategorikan sebagai HENING, pembacaan di atas 80 dB dianggap GADUH, dan nilai di antaranya diklasifikasikan sebagai KONDUSIF.

4. **Kontrol Output LED**: Mengelola tampilan visual dengan mengaktifkan LED yang sesuai berdasarkan kategori level suara yang terdeteksi. Sistem terlebih dahulu mematikan semua LED untuk menghindari keadaan ambigu, kemudian menyalakan LED yang sesuai dengan kategori saat ini.

5. **Komunikasi Serial**: Menyediakan umpan balik ke pengguna melalui terminal serial, mengirimkan informasi dalam format terstruktur, termasuk nilai desibel numerik dan kategori kebisingan dalam bentuk teks (HENING, KONDUSIF, atau GADUH).

Kode program ditulis dengan pendekatan modular, memungkinkan pemeliharaan yang mudah dan pengembangan lebih lanjut di masa depan. Threshold kebisingan dapat disesuaikan melalui konstanta dalam kode atau melalui potensiometer pada implementasi fisik, memberikan fleksibilitas untuk berbagai lingkungan penggunaan.

## Test Results and Performance Evaluation

Pengujian NoiseShield dilakukan melalui dua pendekatan: simulasi menggunakan Proteus dan pengujian langsung pada rangkaian fisik. Pada pengujian Proteus, karena keterbatasan simulasi sensor suara, potensiometer digunakan untuk mensimulasikan input ke Arduino pada pin A0. Untuk rangkaian fisik, Serial Monitor pada Arduino IDE digunakan untuk memantau output sistem.

Hasil pengujian menunjukkan:

1. **Pengujian Simulasi Proteus**:
   - Berhasil mengklasifikasikan tingkat kebisingan sesuai threshold:
     - Level 0-30 dB: Output "HENING" dengan LED D1 (hijau) menyala
     - Level 31-79 dB: Output "KONDUSIF" dengan LED D2 (kuning) menyala
     - Level >80 dB: Output "GADUH" dengan LED D3 (merah) menyala
   - Respons sistem stabil dan konsisten pada berbagai level input

2. **Pengujian Rangkaian Fisik**:
   - Kategori HENING dan KONDUSIF terdeteksi dengan baik
   - Pada kategori GADUH ditemukan tantangan dalam mencapai level tersebut karena keterbatasan sensitivitas sensor KY-037
   - LED indikator berfungsi sesuai dengan kategori kebisingan yang terdeteksi
   - Serial Monitor menampilkan informasi yang sesuai dengan keadaan terdeteksi


## Evaluation

Evaluasi proyek NoiseShield mencakup aspek kinerja tim dan hasil implementasi sistem. Tim menunjukkan kolaborasi efektif dengan pembagian tugas yang terstruktur, memastikan proyek berjalan sesuai timeline. Hasil pengujian menunjukkan sistem berhasil mengklasifikasikan tingkat kebisingan ke dalam tiga kategori dengan indikator LED yang responsif pada simulasi Proteus, meskipun implementasi fisik menghadapi keterbatasan pada sensitivitas sensor KY-037 dalam mendeteksi kategori gaduh. Komunikasi serial berfungsi dengan baik menampilkan data tingkat kebisingan secara real-time. Untuk pengembangan ke depan, disarankan menggunakan sensor dengan sensitivitas lebih tinggi dan mengintegrasikan sistem dengan perangkat notifikasi nirkabel untuk meningkatkan efektivitas pemantauan kebisingan di lingkungan rumah sakit.

## Conclusion and Future Work

Proyek NoiseShield telah berhasil menciptakan sistem pemantauan kebisingan yang efektif menggunakan Arduino Uno dan sensor suara, dengan kemampuan mengklasifikasikan kondisi akustik lingkungan ke dalam tiga kategori yang ditampilkan melalui indikator LED. Sistem ini memenuhi seluruh kriteria penerimaan yang ditetapkan, yaitu mampu memantau tingkat kebisingan secara otomatis, mengklasifikasikan kondisi suara menjadi tiga kategori, memberikan peringatan visual melalui LED saat kebisingan melebihi ambang batas, dan memiliki threshold yang dapat disesuaikan.

Untuk pengembangan masa depan, beberapa area yang dapat ditingkatkan meliputi:

1. Penggunaan sensor suara dengan sensitivitas lebih tinggi untuk mendeteksi berbagai tingkat kebisingan dengan lebih akurat
2. Pengembangan sistem notifikasi nirkabel ke perangkat mobile perawat untuk respons yang lebih cepat
3. Integrasi dengan sistem manajemen rumah sakit yang ada untuk pemantauan dan analisis data yang lebih komprehensif
4. Pengembangan algoritma pemrosesan suara yang lebih canggih untuk membedakan jenis suara (misalnya tangisan bayi vs. kebisingan lingkungan)
5. Miniaturisasi perangkat untuk kemudahan pemasangan di berbagai lokasi dalam ruang perawatan

Dengan penyempurnaan lebih lanjut, NoiseShield berpotensi menjadi alat yang sangat berguna dalam meningkatkan kualitas perawatan dan keselamatan pasien di lingkungan rumah sakit, khususnya di ruang perawatan bayi baru lahir.