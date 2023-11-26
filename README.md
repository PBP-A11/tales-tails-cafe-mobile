[![Staging](https://github.com/PBP-A11/tales-tails-cafe-mobile/actions/workflows/staging.yml/badge.svg)](https://github.com/PBP-A11/tales-tails-cafe-mobile/actions/workflows/staging.yml)
[![Pre-Release](https://github.com/PBP-A11/tales-tails-cafe-mobile/actions/workflows/pre-release.yml/badge.svg)](https://github.com/PBP-A11/tales-tails-cafe-mobile/actions/workflows/pre-release.yml)
[![Release](https://github.com/PBP-A11/tales-tails-cafe-mobile/actions/workflows/release.yml/badge.svg)](https://github.com/PBP-A11/tales-tails-cafe-mobile/actions/workflows/release.yml)
[![Build status](https://build.appcenter.ms/v0.1/apps/9e46b3a5-8542-46e1-8e9d-a0f841142acc/branches/main/badge)](https://appcenter.ms)

# Tales & Tails Cafe 🏰🐈

#### Kelompok: A-11
#### Anggota:
- [Andi Salsabila Ardian](https://github.com/stronovski) ()
- [Fariska Fedira Ardhanariswari](https://github.com/fariskafedira) (2206815705)
- [Febrian Irvansyah](https://github.com/febrian-irv) (2206083584)
- [Muhammad Madhani Putra](https://github.com/mhmmdmadhanip) (2206028503)
- [Shaquille Athar Adista](https://github.com/AtharAdista) (2206081875)

## Menambahkan tautan berita acara ke README.md
[Link Berita Acara A-11](https://docs.google.com/spreadsheets/d/1p8euC71zwOiWv7plgYurs9e5wq0bpHTVqu4wkirNlBw/edit?usp=sharing)

## Tautan APK
[Link app](https://appcenter.ms)


## Deskripsi aplikasi (nama dan fungsi aplikasi)
Tales and Tails Cafe adalah sebuah Cafe yang mengambil konsep Cat Cafe, tetapi memiliki sebuah perpustakaan untuk meminjam buku juga. Cafe ini memiliki tujuan untuk memadukan suasana santai kafe dengan kemudahan akses ke koleksi buku yang beragam, hal ini bertujuan untuk menciptakan ruang yang menggabungkan dua kegiatan yang menyenangkan dan mendidik.

Seiring dengan kesuksesan dan popularitas Tales and Tails Cafe, pemiliknya telah merespons kebutuhan pelanggan yang terus berkembang. Memahami bahwa beberapa pelanggan mengalami kesulitan mengakses aplikasi web Tales and Tails Cafe di perangkat mobile, pemilik cafe memutuskan untuk memberikan pengalaman yang lebih baik melalui pengembangan aplikasi mobile resmi.
	
## Pembagian kerja per anggota

| Nama | Modul yang Dikerjakan |
|------|-----------------------|
| Andi Salsabila Ardian | Review |
| Fariska Fedira Ardhanariswari | Authentication |
| Febrian Irvansyah | List member dan profile member |
| Muhammad Madhani Putra | Hapus & tambah buku dan list user |
| Shaquille Athar Adista | Catalog, homapage, dan profile admin |

## Daftar modul yang diimplementasiklan
###  1. Authentication
Authentication adalah tempat dimana user dan admin dapat login. Nantinya, akses akan diberikan sesuai dengan role pengguna.

<b>Login :</b>
- Field username/email 
- Field password 

<b>Register : </b>
- Field firstname 
- Field lastname 
- Field username 
- Field e-mail 
- Field no. telp 
- Field tanggal lahir 

### 2. Homepage
Tempat halaman muka dari mobile app ini.

### 3. Katalog
Menampilkan koleksi buku yang disediakan dan Member dapat melihat detail buku, mencari buku, dan meminjam buku. Sedangkan guest hanya dapat melihat buku dan mencari data buku saja.

<b>Atribut:</b>
- Search buku dan bisa search filter sesuai data buku
- Menampilkan Ketersediaan buku
- Detail buku
- Menampilkan metadata dari buku
- Tempat user meminjam buku


### 4. List dan pengembalian buku yang dipinjam
Tempat Member dapat melihat buku-buku yang sedang ia pinjam, serta  member juga dapat mengembalikan buku yang ia pinjam.

### 5. Review
Member dapat melihat dan menulis review terhadap buku-buku yang ada di web ini. Sedangkan guest, hanya dapat melihat review buku saja.

### 6. Profile
Menampilkan data pribadi dari member.

### 7. Hapus/Tambah Buku
Admin dapat menambah dan menghapus data buku.

### 8. List Member dan update role
Menampilkan data member dan buku yang dipinjam. Admin juga dapat mengubah role dari suatu akun.

### Peran atau aktor pengguna aplikasi
1. Admin:
   - Hapus/tambah buku
   - Melihat list peminjam dan buku yang dipinjam
   - Dapat bernavigasi dalam mobile app ini
     
2. Member (pengguna yang login):
   - Meminjam buku
   - Mengembalikan buku
   - Dapat bernavigasi dalam mobile app ini
     
3. Guest (pengguna yang tidak login):
   - Dapat bernavigasi dalam mobile app ini
   - Tidak mempunyai hak dalam meminjam atau menambah buku

## Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web yang sudah dibuat saat Proyek Tengah Semester

<b>Authentication</b>

- Install package yang sudah disediakan oleh tim asdos.
- Tambahkan `CookieRequest` pada setiap child widgets.
- Buat `login.dart` pada `screens`.
- Install `django-cors-headers` pada proyek Django.
- Buat django-app bernama `authentication` pada Django.
- Tambahkan `authentication` ke pada `setting.py`.
- Tambahkan `corsheades` dan hal lain yang dibutuhkan ke `setting.py`.
- Buat metode login di `authentication/views.py` dan tambahkan ke `urls.py`
  
<b>Model kustom</b>

- Buka endpoint JSON pada proyek django, kemudian salin data yang didapatkan dan buka situs Quicktype
- Pada situs Quicktype ubah <i>setup name</i> menjadi `product`,<i>source type menjadi `JSON`</i>, dan <i>language</i> menjadi `Dart`.
- Tempel data JSON dan klik copy code.
- Buat folder models pada libary dan buat file baru untuk menyimpan salinan yang sudah didapatkan dari Quicktype tadi.

<b>Fetch data</b>

- Tambahkan Dependensi HTTP
- Buat fungsi pada setiap modul yang dapat terintegrasi dengan database Django dan melakukan fect dengan menggunakan konsep async HTTP.
- Lakukan Fetch data dari Django dan tampilkan ke flutter dengan memanfaatkan `FutureBuilder`



