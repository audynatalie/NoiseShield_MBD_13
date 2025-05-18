# Final Project Embedded System - Group 13
## NoiseSheild

### Anggota Kelompok:
- **Audy Natalie Cecilia R.** (2306266962)  
- **M. Avicenna Raffaiz A.** (2206062844)  
- **Muhammad Hilmy** (2306267006)  
- **Muhammad Pavel** (2306243363)

## Introduction To The Problem and The Solution

Kebisingan di ruang perawatan bayi baru lahir, khususnya di NICU (Neonatal Intensive Care Unit), merupakan masalah serius yang dapat mengganggu kenyamanan, kestabilan fisiologis, dan perkembangan bayi. Bayi yang masih sangat rentan terhadap gangguan suara dapat mengalami gangguan tidur dan stres jika terpapar suara berlebih. Selain itu, tangisan bayi yang tidak terdeteksi secara cepat bisa menandakan kebutuhan mendesak yang harus segera ditangani oleh tenaga medis. Namun, pemantauan kebisingan dan suara tangisan di rumah sakit selama ini masih sangat bergantung pada pengawasan manual oleh perawat, yang tidak selalu optimal terutama saat tenaga medis terbatas.

Untuk mengatasi masalah ini, dikembangkan NoiseShield, sebuah sistem pendeteksi kebisingan otomatis berbasis mikrokontroler Arduino Uno dan sensor suara KY-037. Sistem ini mampu mengukur intensitas suara secara real-time dan memberikan peringatan visual melalui LCD dan LED, serta peringatan audio menggunakan buzzer saat kebisingan melebihi ambang batas yang telah ditentukan. Dengan fitur pengaturan *threshold* yang fleksibel, sistem ini dapat diadaptasi untuk berbagai kondisi ruang rawat, termasuk ruang NICU yang memerlukan sensitivitas lebih tinggi untuk mendeteksi tangisan bayi secara cepat dan akurat. Dengan NoiseShield, respons terhadap kebutuhan bayi dapat dilakukan secara lebih efisien dan tepat waktu tanpa ketergantungan penuh pada pengawasan manual.

## Hardware Design and Implementation Details

Komponen utama yang digunakan dalam pengembangan NoiseShield adalah sebagai berikut:

- **Arduino Uno**: Mikrokontroler utama yang memproses sinyal dari sensor suara dan mengendalikan output indikator.  
- **Sensor Suara KY-037**: Sensor dengan sensitivitas tinggi yang mampu menangkap intensitas suara lingkungan, khususnya suara 
- **LED Merah**: Sebagai indikator visual tambahan yang menyala saat kondisi kebisingan melebihi *threshold*.  
- **Buzzer**: Memberikan peringatan suara yang langsung terdengar oleh tenaga medis saat terdeteksi suara gaduh atau tangisan bayi.  
- **Breadboard dan Kabel Jumper**: Untuk merangkai prototipe rangkaian secara praktis dan fleksibel.  
- **Laptop dengan Arduino IDE**: Digunakan untuk pemrograman mikrokontroler.  
- **Proteus**: Software simulasi rangkaian untuk pengujian awal sebelum realisasi fisik.  
- **Kabel USB**: Untuk koneksi dan pemrograman Arduino.  

## Software implementation details
## Test results and performance evaluation
## Conclusion and future work







