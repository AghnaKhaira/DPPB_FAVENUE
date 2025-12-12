# 📱 PANDUAN SINGKAT: Cara Menjalankan Favenue Mobile

## 🎯 LANGKAH CEPAT (5 Menit)

### **1. Buka Terminal/PowerShell**
```powershell
cd c:\tubes_dppbfavenue
```

### **2. Instal Dependencies (jika belum)**
```powershell
flutter pub get
```

### **3. Jalankan Aplikasi**

**Opsi A: Jika punya Android Emulator/Device**
```powershell
flutter run
```

**Opsi B: Jika ingin di Chrome/Web**
```powershell
flutter run -d chrome
```

**Opsi C: Jika punya multiple devices**
```powershell
flutter devices  # Lihat daftar devices
flutter run -d <device-name>
```

---

## 📍 NAVIGASI APLIKASI

Setelah aplikasi berjalan, Anda bisa:

1. **Home Screen** (Halaman Utama)
   - Klik "Cari Developer" → Lihat daftar developer
   - Klik "Jelajahi UMKM" → Lihat daftar UMKM
   - Klik "Dashboard" → Lihat dashboard profil
   - Klik "Profil" → Lihat profil user

2. **Developer List**
   - Search developer dengan keyword
   - Filter berdasarkan kategori
   - Swipe horizontal untuk lihat lebih banyak

3. **UMKM List**
   - Search UMKM dengan keyword
   - Filter berdasarkan kategori
   - Lihat rating dan lokasi

4. **Dashboard**
   - Melihat statistik proyek
   - Melihat aktivitas terbaru

5. **Profile**
   - Edit informasi profil
   - Logout dari aplikasi

---

## 🛠️ TROUBLESHOOTING CEPAT

### Problem: "Unable to connect to emulator"
**Solution:**
```powershell
flutter emulators --launch <emulator-name>
flutter run
```

### Problem: "Dependency error"
**Solution:**
```powershell
flutter clean
flutter pub get
flutter run
```

### Problem: "Build failed"
**Solution:**
```powershell
flutter doctor -v  # Lihat masalah yang ada
flutter pub upgrade  # Update dependencies
flutter run -v  # Run dengan verbose
```

---

## 🔗 INTEGRASI BACKEND (PENTING!)

Untuk menghubungkan dengan backend/API Anda:

1. **Edit `lib/utils/constants.dart`:**
   ```dart
   static const String baseUrl = 'http://YOUR_API_URL:PORT/api';
   ```

2. **Buat API Service** (jika belum ada):
   Lihat detail di `PANDUAN_MOBILE_DEVELOPMENT.md`

3. **Update screens** untuk fetch data dari API

---

## 📸 SCREENSHOT FITUR

### Home Screen
- Welcome banner dengan carousel
- Quick access cards
- Featured developers & UMKM

### Developer List
- Search & filter
- Developer cards dengan rating
- Responsive grid layout

### UMKM List
- Search & filter
- UMKM cards dengan lokasi
- Rating system

### Dashboard
- Welcome message
- Statistics cards
- Activity list

### Profile
- User info
- Bio section
- Edit/Logout options

---

## 💡 TIPS & TRIK

1. **Hot Reload** - Tekan `r` di terminal untuk reload cepat
2. **Hot Restart** - Tekan `R` untuk restart total
3. **Stop** - Tekan `q` untuk stop aplikasi

---

## 📦 STRUKTUR PROJECT SEKARANG:

```
📁 lib/
  ├── 📄 main.dart (Entry point - sudah updated)
  ├── 📁 models/ (Data models)
  ├── 📁 screens/ (5 main screens)
  ├── 📁 widgets/ (Reusable components)
  └── 📁 utils/ (Theme & constants)
```

---

## ✨ FITUR YANG BISA DIKEMBANGKAN LEBIH LANJUT:

- [ ] Detail page untuk developer & UMKM
- [ ] Chat/Messaging system
- [ ] Payment gateway integration
- [ ] Push notifications
- [ ] Offline functionality
- [ ] User authentication
- [ ] Image upload
- [ ] Favorite/Wishlist

---

**Status: ✅ READY TO RUN!**

Semua file sudah siap, tinggal jalankan dengan `flutter run` 🚀
