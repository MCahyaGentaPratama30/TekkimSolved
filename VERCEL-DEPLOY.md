# Deploy Production ke Vercel

Panduan ini untuk deploy project Teknik Kimia PolSRI ke Vercel dengan Supabase.

## URL Lama

Production sebelumnya/yang dituju:

```text
https://teknik-kimia-polsri.vercel.app/
```

Jika project Vercel lama masih ada, gunakan project itu supaya URL tetap sama. Jika membuat project Vercel baru, URL default biasanya berubah dan perlu diatur domain/alias secara manual.

## Environment Variables Wajib

Tambahkan di Vercel lewat **Project > Settings > Environment Variables** untuk environment **Production**, **Preview**, dan **Development** jika diperlukan:

```env
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=isi_anon_public_key
SUPABASE_SERVICE_ROLE_KEY=isi_service_role_key
```

Catatan:

- `NEXT_PUBLIC_SUPABASE_URL` dan `NEXT_PUBLIC_SUPABASE_ANON_KEY` boleh terbaca browser.
- `SUPABASE_SERVICE_ROLE_KEY` rahasia dan hanya boleh dipakai server-side.
- Jangan commit `.env.local` atau key asli ke GitHub.

## Supabase Settings

Di Supabase dashboard, buka **Authentication > URL Configuration** lalu set:

```text
Site URL: https://teknik-kimia-polsri.vercel.app
```

Tambahkan **Redirect URLs** berikut:

```text
https://teknik-kimia-polsri.vercel.app/auth/callback
http://localhost:3000/auth/callback
```

Jika memakai custom domain, tambahkan juga:

```text
https://domain-kamu/auth/callback
```

## Storage Buckets

Pastikan bucket dari `SUPABASE-NEW-SETUP.md` sudah dibuat:

| Bucket | Public |
| --- | --- |
| foto | Yes |
| beasiswa | Yes |
| alumni-photos | Yes |
| kegiatan | Yes |
| lab | Yes |
| bukti | No |
| student-files | No |

## Deploy dari Vercel Dashboard

1. Push project ini ke GitHub/GitLab/Bitbucket.
2. Buka Vercel lalu pilih **Add New > Project**.
3. Import repository project.
4. Framework akan terdeteksi sebagai **Next.js**.
5. Pastikan Build Command: `npm run build`.
6. Tambahkan semua environment variables wajib.
7. Klik **Deploy**.

## Redeploy URL Lama

Jika menggunakan project Vercel lama:

1. Buka project `teknik-kimia-polsri` di Vercel.
2. Update environment variables Supabase.
3. Buka tab **Deployments**.
4. Klik menu deployment terbaru lalu **Redeploy**.
5. Pastikan production domain tetap `teknik-kimia-polsri.vercel.app`.

## Deploy via Vercel CLI

Login dan link project:

```bash
npx vercel login
npx vercel link
```

Set environment variables production:

```bash
npx vercel env add NEXT_PUBLIC_SUPABASE_URL production
npx vercel env add NEXT_PUBLIC_SUPABASE_ANON_KEY production
npx vercel env add SUPABASE_SERVICE_ROLE_KEY production
```

Deploy production:

```bash
npx vercel --prod
```

## Cek Setelah Deploy

- Buka halaman utama.
- Test login/sign-in.
- Test halaman admin/dosen/mahasiswa sesuai akun.
- Test upload gambar/file ke Supabase Storage.
- Cek gambar dari Supabase tampil normal.
- Cek Vercel **Runtime Logs** jika ada error.
