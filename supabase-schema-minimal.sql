-- Teknik Kimia PolSRI - Minimal Schema untuk Fresh Supabase
-- Copy-paste semua query ini ke SQL Editor Supabase baru

-- ============================================
-- 1. CORE TABLES
-- ============================================

-- Mahasiswa
CREATE TABLE mahasiswa (
  id_mhs UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  nim VARCHAR(20) UNIQUE NOT NULL,
  nama VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  kelas VARCHAR(50),
  jabatan_kelas VARCHAR(100),
  angkatan INTEGER,
  prodi VARCHAR(100),
  foto_profil TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Dosen
CREATE TABLE dosen (
  id_dsn UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  nip VARCHAR(50),
  nidn VARCHAR(50),
  nuptk VARCHAR(50),
  nama VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  prodi VARCHAR(100),
  status_dosen VARCHAR(100),
  role VARCHAR(50),
  foto TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Alumni
CREATE TABLE alumni (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  nama VARCHAR(255) NOT NULL,
  prodi VARCHAR(100),
  angkatan INTEGER,
  pekerjaan VARCHAR(255),
  testimoni TEXT,
  foto TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Program Studi
CREATE TABLE prodi (
  id SERIAL PRIMARY KEY,
  nama VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE,
  deskripsi TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 2. CMS TABLES
-- ============================================

-- CMS Beasiswa
CREATE TABLE cms_beasiswa (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE,
  short_name VARCHAR(100),
  provider VARCHAR(255),
  logo_url TEXT,
  description TEXT,
  general_eligibility TEXT,
  benefits TEXT,
  website_url TEXT,
  contact_info TEXT,
  storage_path_logo TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CMS Kegiatan
CREATE TABLE kegiatan (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE,
  deskripsi TEXT,
  main_images TEXT,
  equipments TEXT,
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CMS Berita
CREATE TABLE berita (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE,
  content TEXT,
  image TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CMS Laboratorium
CREATE TABLE cms_laboratorium (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  deskripsi TEXT,
  main_images TEXT,
  equipments TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CMS Prodi
CREATE TABLE cms_prodi (
  id SERIAL PRIMARY KEY,
  nama VARCHAR(255),
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CMS Sejarah
CREATE TABLE cms_sejarah (
  id SERIAL PRIMARY KEY,
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CMS Visi Misi
CREATE TABLE cms_visi_misi (
  id SERIAL PRIMARY KEY,
  visi TEXT,
  misi TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 3. KOMPENSASI TABLES
-- ============================================

-- Kompensasi Info
CREATE TABLE kompen_info (
  id SERIAL PRIMARY KEY,
  is_kompensasi_active BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Kompensasi Class Assignment
CREATE TABLE kompensasi (
  id SERIAL PRIMARY KEY,
  kelas VARCHAR(50),
  id_dosen_pa UUID REFERENCES dosen(id_dsn),
  kompen_info_id INTEGER REFERENCES kompen_info(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Rekap Kehadiran
CREATE TABLE rekap_kehadiran (
  id SERIAL PRIMARY KEY,
  id_mhs UUID REFERENCES mahasiswa(id_mhs),
  id_sekretaris UUID,
  kelas VARCHAR(50),
  menit_tidak_hadir INTEGER DEFAULT 0,
  is_published BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 4. KUESIONER TABLES
-- ============================================

CREATE TABLE kuesioner (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  deskripsi TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE kuesioner_pertanyaan (
  id SERIAL PRIMARY KEY,
  kuesioner_id INTEGER REFERENCES kuesioner(id),
  pertanyaan TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE kuesioner_opsi (
  id SERIAL PRIMARY KEY,
  pertanyaan_id INTEGER REFERENCES kuesioner_pertanyaan(id),
  opsi TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE kuesioner_jawaban (
  id SERIAL PRIMARY KEY,
  kuesioner_id INTEGER REFERENCES kuesioner(id),
  pertanyaan_id INTEGER REFERENCES kuesioner_pertanyaan(id),
  opsi_id INTEGER REFERENCES kuesioner_opsi(id),
  user_id UUID REFERENCES auth.users(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 5. STRUCTURAL TABLES
-- ============================================

CREATE TABLE struktural_jabatan (
  id SERIAL PRIMARY KEY,
  nama VARCHAR(255),
  deskripsi TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE jurusan_stats (
  id SERIAL PRIMARY KEY,
  jurusan VARCHAR(100),
  stats_data JSONB,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 6. OTHER TABLES
-- ============================================

CREATE TABLE kalender (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE kalender_akademik (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  start_date DATE,
  end_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE testimoni_alumni (
  id SERIAL PRIMARY KEY,
  alumni_id INTEGER REFERENCES alumni(id),
  testimoni TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE layanan (
  id SERIAL PRIMARY KEY,
  nama VARCHAR(255),
  deskripsi TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  nama VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sections (
  id SERIAL PRIMARY KEY,
  nama VARCHAR(255),
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE notes (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  title VARCHAR(255),
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE lab (
  id SERIAL PRIMARY KEY,
  nama VARCHAR(255),
  deskripsi TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 7. CREATE INDEXES
-- ============================================

CREATE INDEX idx_mahasiswa_nim ON mahasiswa(nim);
CREATE INDEX idx_mahasiswa_kelas ON mahasiswa(kelas);
CREATE INDEX idx_dosen_nip ON dosen(nip);
CREATE INDEX idx_alumni_user_id ON alumni(user_id);
CREATE INDEX idx_berita_slug ON berita(slug);
CREATE INDEX idx_kegiatan_slug ON kegiatan(slug);
CREATE INDEX idx_rekap_kehadiran_id_mhs ON rekap_kehadiran(id_mhs);

-- ============================================
-- 8. ENABLE RLS (Row Level Security)
-- ============================================

ALTER TABLE mahasiswa ENABLE ROW LEVEL SECURITY;
ALTER TABLE dosen ENABLE ROW LEVEL SECURITY;
ALTER TABLE alumni ENABLE ROW LEVEL SECURITY;
ALTER TABLE rekap_kehadiran ENABLE ROW LEVEL SECURITY;
ALTER TABLE kuesioner_jawaban ENABLE ROW LEVEL SECURITY;

-- ============================================
-- 9. RLS POLICIES (Basic - boleh disesuaikan)
-- ============================================

-- Mahasiswa bisa read own data
CREATE POLICY "Mahasiswa can read own data" ON mahasiswa
  FOR SELECT USING (auth.uid() = id_mhs);

-- Dosen bisa read own data
CREATE POLICY "Dosen can read own data" ON dosen
  FOR SELECT USING (auth.uid() = id_dsn);

-- Alumni bisa read/update own data
CREATE POLICY "Alumni can read own data" ON alumni
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Alumni can update own data" ON alumni
  FOR UPDATE USING (auth.uid() = user_id);

-- Public read untuk CMS tables
ALTER TABLE cms_beasiswa ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read beasiswa" ON cms_beasiswa FOR SELECT USING (true);

ALTER TABLE kegiatan ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read kegiatan" ON kegiatan FOR SELECT USING (true);

ALTER TABLE berita ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read berita" ON berita FOR SELECT USING (true);

ALTER TABLE cms_laboratorium ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read lab" ON cms_laboratorium FOR SELECT USING (true);

-- ============================================
-- 10. NOTES
-- ============================================
-- Setelah run schema ini:
-- 1. Buat storage buckets via Dashboard > Storage:
--    - foto (public)
--    - beasiswa (public)
--    - alumni-photos (public)
--    - kegiatan (public)
--    - lab (public)
--    - bukti (authenticated)
--    - student-files (authenticated)
-- 
-- 2. Set bucket policies ke public untuk yang perlu public access
-- 
-- 3. Jika ada error missing column, tambahkan manual:
--    ALTER TABLE table_name ADD COLUMN column_name TYPE;

