# Setup Supabase Baru - Teknik Kimia PolSRI

Panduan ini untuk kondisi database lama tidak bisa diakses dan project dibuat ulang dari nol.

## 1. Buat Project Supabase Baru

1. Login ke Supabase.
2. Klik **New project**.
3. Pilih organization.
4. Isi nama project, contoh: 	eknik-kimia-polsri-new.
5. Simpan password database.
6. Pilih region terdekat, contoh Singapore.
7. Tunggu project aktif.

## 2. Ambil API Keys

Buka Supabase project baru:

1. Masuk ke **Project Settings**.
2. Buka **API**.
3. Copy:
   - **Project URL**
   - **anon public key**
   - **service_role key**

## 3. Jalankan Schema Database

1. Buka **SQL Editor** di Supabase baru.
2. Copy isi file supabase-schema-minimal.sql.
3. Paste ke SQL Editor.
4. Klik **Run**.

Jika ada error, kirim screenshot/pesan error-nya. Kemungkinan hanya perlu penyesuaian kecil.

## 4. Buat Storage Buckets

Buka **Storage** lalu buat bucket berikut:

| Bucket | Public? | Fungsi |
| --- | --- | --- |
| oto | Yes | Foto mahasiswa/dosen |
| easiswa | Yes | Logo/file beasiswa |
| lumni-photos | Yes | Foto alumni |
| kegiatan | Yes | Gambar kegiatan |
| lab | Yes | Gambar laboratorium |
| ukti | No | Bukti/file private |
| student-files | No | File mahasiswa |

Untuk bucket public, aktifkan opsi **Public bucket** saat membuat bucket.

## 5. Buat File .env.local

Di root project, buat file .env.local:

`env
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=isi_anon_public_key_baru
SUPABASE_SERVICE_ROLE_KEY=isi_service_role_key_baru
`

Catatan penting:
- SUPABASE_SERVICE_ROLE_KEY jangan dibagikan ke publik.
- Jangan commit .env.local ke GitHub.

## 6. Jalankan Project Lokal

`ash
npm install
npm run dev
`

Buka:

`	ext
http://localhost:3000
`

## 7. Buat Akun Baru

Karena data lama tidak diselamatkan, akun lama tidak akan ada.

Yang perlu dibuat ulang:
- Admin/dosen dari halaman admin atau Supabase Auth.
- Mahasiswa lewat register.
- Alumni lewat admin/register sesuai flow aplikasi.

## 8. Update Hosting Production

Jika deploy di Vercel:

1. Buka project di Vercel.
2. Masuk **Settings > Environment Variables**.
3. Update:
   - NEXT_PUBLIC_SUPABASE_URL
   - NEXT_PUBLIC_SUPABASE_ANON_KEY
   - SUPABASE_SERVICE_ROLE_KEY
4. Redeploy project.

## 9. Jika Muncul Error Missing Column

Karena schema dibuat ulang dari kode dan bukan backup database lama, mungkin ada kolom yang belum lengkap.

Contoh solusi:

`sql
ALTER TABLE nama_table ADD COLUMN nama_kolom TEXT;
`

Kirim error-nya, nanti bisa saya bantu tambahkan kolom yang kurang.
