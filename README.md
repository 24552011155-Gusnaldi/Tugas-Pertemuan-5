# Taskly — To-do List Harian

Taskly adalah aplikasi Flutter sederhana untuk membantu mencatat dan mengelola tugas harian. Antarmukanya dirancang bersih, responsif, dan nyaman digunakan di layar ponsel maupun desktop.

## Fitur utama

- Melihat daftar tugas harian beserta contoh tugas.
- Menambahkan tugas baru.
- Menandai tugas sebagai selesai atau belum selesai.
- Menghapus tugas.
- Memfilter daftar berdasarkan semua, belum selesai, atau selesai.
- Melihat jumlah tugas selesai dan progres harian.

> Data tugas hanya disimpan selama aplikasi berjalan. Tugas akan kembali ke data awal ketika aplikasi dimulai ulang.

## Struktur proyek

```text
tugas_pertemuan5/
├── assets/
│   └── screenshots/
│       ├── .gitkeep
│       └── app_preview.png       # Tambahkan screenshot aplikasi di sini
├── lib/
│   ├── main.dart                 # Entry point dan konfigurasi aplikasi
│   ├── models/
│   │   └── todo_item.dart        # Model data tugas
│   ├── screens/
│   │   └── todo_screen.dart      # Layar utama dan pengelolaan state
│   ├── theme/
│   │   └── app_theme.dart        # Tema dan warna aplikasi
│   └── widgets/
│       └── task_tile.dart        # Widget untuk satu tugas
├── test/
│   └── widget_test.dart          # Widget test
├── pubspec.yaml
└── README.md
```

## Persyaratan

- Flutter SDK yang sesuai dengan batas SDK di `pubspec.yaml`.
- Android Studio atau VS Code dengan ekstensi Flutter dan Dart.
- Emulator Android/iOS atau perangkat yang terhubung. Flutter juga mendukung target desktop dan web.

## How to Run

1. Buka terminal di folder yang berisi `pubspec.yaml`. Jika baru meng-clone repository, masuk ke folder proyek:

   ```bash
   cd Tugas-Pertemuan-5
   ```

2. Unduh dependency:

   ```bash
   flutter pub get
   ```

3. Pastikan emulator/perangkat tersedia, atau lihat perangkat yang bisa digunakan:

   ```bash
   flutter devices
   ```

4. Jalankan aplikasi:

   ```bash
   flutter run
   ```

5. Jalankan pemeriksaan kode dan widget test (opsional):

   ```bash
   flutter analyze
   flutter test
   ```

## Menambahkan screenshot ke README

1. Jalankan aplikasi di emulator atau perangkat, lalu tampilkan layar yang ingin didokumentasikan.
2. Ambil screenshot menggunakan fitur screenshot emulator/perangkat.
3. Simpan atau salin file gambar ke `assets/screenshots/` dengan nama `app_preview.png`. Buat folder tersebut bila belum ada.
4. Pertahankan atau tambahkan baris Markdown berikut di README:

   ```markdown
   ![Tampilan aplikasi Taskly](assets/screenshots/app_preview.png)
   ```

5. Buka README di GitHub untuk memastikan gambar muncul. Jika belum, pastikan nama dan lokasi file sama persis, lalu commit dan push file screenshot.

## Mengunggah proyek ke GitHub dan mendapatkan URL repository

### Push ke repository tugas

Repository tujuan: [24552011155-Gusnaldi/Tugas-Pertemuan-5](https://github.com/24552011155-Gusnaldi/Tugas-Pertemuan-5).

1. Pastikan sudah login ke GitHub melalui Git Credential Manager atau VS Code.
2. Dari folder proyek yang berisi `pubspec.yaml`, jalankan:

   ```bash
   git init
   git branch -M main
   git add .
   git commit -m "Initial commit: Taskly Flutter app"
   git remote add origin https://github.com/24552011155-Gusnaldi/Tugas-Pertemuan-5.git
   git push -u origin main
   ```

3. Jika Git belum mengenali identitas commit, atur nama dan email menggunakan identitas Anda:

   ```bash
   git config --global user.name "Nama Anda"
   git config --global user.email "email@example.com"
   ```

   Setelah itu, ulangi `git commit` dan `git push`. Jangan menyimpan token akses di source code.

4. Setelah push berhasil, URL repository adalah:

   ```text
   https://github.com/24552011155-Gusnaldi/Tugas-Pertemuan-5
   ```

5. Untuk mengunggah screenshot setelahnya, salin `app_preview.png` ke `assets/screenshots/`, lalu jalankan:

   ```bash
   git add README.md assets/screenshots/app_preview.png
   git commit -m "Add app screenshot to README"
   git push
   ```
