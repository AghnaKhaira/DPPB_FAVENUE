# 🎯 FAVENUE MOBILE - DOKUMENTASI LENGKAP

## 📋 Daftar Isi
1. [Pengenalan](#pengenalan)
2. [Persyaratan Sistem](#persyaratan-sistem)
3. [Instalasi](#instalasi)
4. [Struktur Project](#struktur-project)
5. [Fitur Aplikasi](#fitur-aplikasi)
6. [Cara Menggunakan](#cara-menggunakan)
7. [Integrasi API](#integrasi-api)
8. [Build & Deploy](#build--deploy)

---

## 📱 Pengenalan

**Favenue Mobile** adalah versi mobile dari platform Favenue yang menghubungkan UMKM (Usaha Mikro, Kecil, dan Menengah) dengan Developer profesional untuk transformasi digital.

### Fitur Utama:
- 🔍 Cari dan filter developer
- 🏪 Jelajahi UMKM dari berbagai kategori
- 📊 Dashboard untuk tracking proyek
- 👤 Manajemen profil user
- ⭐ Rating dan review system
- 💬 Messaging/Chat (siap diintegrasikan)

---

## 🔧 Persyaratan Sistem

### Windows
- Flutter SDK 3.9.2 atau lebih tinggi
- Dart SDK (included dengan Flutter)
- Android Studio atau VS Code
- Android Emulator atau device fisik

### Instalasi Flutter (jika belum ada)
1. Download dari [flutter.dev](https://flutter.dev/docs/get-started/install)
2. Extract ke folder (misal: `C:\flutter`)
3. Tambahkan ke PATH environment variable
4. Jalankan `flutter doctor` untuk verifikasi

---

## 📥 Instalasi

### 1. Clone/Buka Project
```bash
cd c:\tubes_dppbfavenue
```

### 2. Instal Dependencies
```bash
flutter pub get
```

### 3. Jalankan Aplikasi
```bash
flutter run
```

Jika ada error, coba:
```bash
flutter clean
flutter pub get
flutter run -v
```

---

## 📂 Struktur Project

```
tubes_dppbfavenue/
│
├── lib/
│   ├── main.dart                      # Entry point aplikasi
│   │
│   ├── models/                        # Data models
│   │   ├── developer_model.dart
│   │   ├── umkm_model.dart
│   │   └── user_model.dart
│   │
│   ├── screens/                       # Halaman-halaman aplikasi
│   │   ├── home_screen.dart          # Halaman utama
│   │   ├── developer_list_screen.dart # Daftar developer
│   │   ├── umkm_list_screen.dart      # Daftar UMKM
│   │   ├── dashboard_screen.dart      # Dashboard user
│   │   └── profile_screen.dart        # Profil user
│   │
│   ├── widgets/                       # Komponen reusable
│   │   ├── developer_card.dart
│   │   ├── umkm_card.dart
│   │   └── custom_appbar.dart
│   │
│   ├── services/
│   │   └── api_service.dart          # API communication
│   │
│   └── utils/                        # Utilities
│       ├── theme.dart                # Tema & styling
│       └── constants.dart            # Konstanta aplikasi
│
├── pubspec.yaml                      # Dependencies
├── QUICK_START.md                    # Panduan cepat
└── PANDUAN_MOBILE_DEVELOPMENT.md     # Panduan lengkap

```

---

## 🎨 Fitur Aplikasi

### 1️⃣ Home Screen (Halaman Utama)
**Path:** `lib/screens/home_screen.dart`

**Komponen:**
- Carousel banner dengan animasi otomatis
- Quick access menu (4 button: Developer, UMKM, Dashboard, Profil)
- Horizontal scrollable list developer terbaik
- Horizontal scrollable list UMKM populer

**Navigasi:**
- Klik tombol untuk go to specific screens
- Swipe carousel untuk lihat banner berikutnya

---

### 2️⃣ Developer List Screen
**Path:** `lib/screens/developer_list_screen.dart`

**Fitur:**
- Search bar untuk cari developer by name
- Filter category (Web Dev, Mobile Dev, UI/UX, Backend, Full Stack)
- Grid view (2 kolom) menampilkan developer cards
- Setiap card menampilkan: nama, spesialisasi, rating, review count

**Data yang ditampilkan:**
```
Nama Developer
Spesialisasi (misal: Web Developer)
Rating: ⭐ 4.5 (12 reviews)
```

---

### 3️⃣ UMKM List Screen
**Path:** `lib/screens/umkm_list_screen.dart`

**Fitur:**
- Search bar untuk cari UMKM by name
- Filter category (Fashion, Food, Handcraft, Electronics, Services)
- Grid view (2 kolom) menampilkan UMKM cards
- Setiap card menampilkan: nama, kategori, lokasi, rating

**Data yang ditampilkan:**
```
Nama UMKM
Kategori (misal: Fashion)
📍 Lokasi (misal: Jakarta)
Rating: ⭐ 4.8
```

---

### 4️⃣ Dashboard Screen
**Path:** `lib/screens/dashboard_screen.dart`

**Fitur:**
- Welcome card dengan gradient
- Statistics cards (4 buah):
  - Proyek Aktif (Jumlah)
  - Pesan Baru (Jumlah)
  - Rating (Score)
  - Status Profil
- Recent activity list dengan timeline

---

### 5️⃣ Profile Screen
**Path:** `lib/screens/profile_screen.dart`

**Fitur:**
- Profile header dengan avatar
- Informasi pribadi:
  - Email
  - Telepon
  - Lokasi
  - Spesialisasi
- Bio section (text area)
- Buttons:
  - Edit Profil
  - Logout

---

## 🚀 Cara Menggunakan

### Menjalankan Aplikasi

#### Di Android Emulator:
```bash
# Pastikan emulator sudah berjalan
flutter run
```

#### Di Device Fisik:
```bash
# Hubungkan device via USB
# Enable USB debugging di device
flutter run
```

#### Di Web Browser:
```bash
flutter run -d chrome
```

#### Di Multiple Devices:
```bash
flutter devices  # Lihat daftar device
flutter run -d <device-id>
```

### Navigasi dalam Aplikasi

```
Home Screen
├── Cari Developer → Developer List Screen
├── Jelajahi UMKM → UMKM List Screen
├── Dashboard → Dashboard Screen
└── Profil → Profile Screen
```

Setiap screen memiliki back button untuk kembali ke home.

---

## 🔗 Integrasi API

### 1️⃣ Setup API Base URL

Edit `lib/utils/constants.dart`:
```dart
class AppConstants {
  static const String baseUrl = 'http://YOUR_API_URL:PORT/api';
  // Contoh: 'http://192.168.1.100:8000/api'
  // atau: 'http://localhost:3000/api'
}
```

### 2️⃣ Menggunakan API Service

File: `lib/services/api_service.dart` sudah menyediakan method-method untuk:

#### Fetch Developers:
```dart
// Dengan filter
List<Developer> developers = await ApiService.getDevelopers(
  category: 'Web Development',
  search: 'john',
);

// Tanpa filter
List<Developer> allDevelopers = await ApiService.getDevelopers();
```

#### Fetch UMKM:
```dart
// Dengan filter
List<UMKM> umkm = await ApiService.getUMKM(
  category: 'Fashion',
  search: 'batik',
  location: 'Jakarta',
);

// Tanpa filter
List<UMKM> allUmkm = await ApiService.getUMKM();
```

#### Login/Register:
```dart
// Login
Map<String, dynamic> result = await ApiService.login(
  email: 'user@example.com',
  password: 'password123',
);

// Register
Map<String, dynamic> result = await ApiService.register(
  name: 'John Doe',
  email: 'john@example.com',
  password: 'password123',
  role: 'developer', // atau 'umkm'
  phone: '08123456789',
);
```

#### Get User Profile:
```dart
User user = await ApiService.getUserProfile(userId);
```

### 3️⃣ Update Screen untuk Menggunakan API

Contoh mengupdate `lib/screens/developer_list_screen.dart`:

```dart
// Tambahkan ini di _DeveloperListScreenState
Future<List<Developer>>? _developersFuture;

@override
void initState() {
  super.initState();
  _developersFuture = ApiService.getDevelopers();
}

// Di build method, replace GridView dengan:
FutureBuilder<List<Developer>>(
  future: _developersFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }
    
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }
    
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text('Tidak ada developer ditemukan'));
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final developer = snapshot.data![index];
        return DeveloperCard(
          name: developer.name,
          specialty: developer.specialty,
          imageUrl: developer.imageUrl,
          rating: developer.rating,
          reviews: developer.reviews,
          onTap: () {
            // Navigate to detail
          },
        );
      },
    );
  },
)
```

---

## 🏗️ Build & Deploy

### Build APK (Android)
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Hasilnya di: build/app/outputs/flutter-apk/app-release.apk
```

### Build iOS
```bash
flutter build ios --release
# Kemudian buka di Xcode untuk submit ke App Store
```

### Build Web
```bash
flutter build web --release
# Hasilnya di: build/web/
# Deploy ke hosting (Firebase Hosting, Netlify, etc)
```

---

## 🛠️ Troubleshooting

| Problem | Solution |
|---------|----------|
| `flutter: command not found` | Tambahkan Flutter ke PATH |
| `Gradle sync failed` | `flutter clean && flutter pub get` |
| `No device connected` | `flutter devices` atau jalankan emulator |
| `Hot reload tidak bekerja` | Press `R` untuk hot restart |
| `Build error` | `flutter pub upgrade && flutter clean` |

---

## 📚 Dependencies yang Digunakan

```yaml
dependencies:
  flutter: sdk: flutter
  cupertino_icons: ^1.0.8       # iOS Icons
  google_fonts: ^6.1.0          # Custom fonts
  carousel_slider: ^4.2.1       # Carousel/Slider
  http: ^1.1.0                  # HTTP requests
  provider: ^6.0.0              # State management
```

---

## 💡 Tips & Best Practices

1. **Gunakan FutureBuilder untuk async operations**
   ```dart
   FutureBuilder<Data>(
     future: apiCall(),
     builder: (context, snapshot) { ... }
   )
   ```

2. **Simpan token setelah login**
   ```dart
   // Gunakan shared_preferences untuk simpan token
   // import 'package:shared_preferences/shared_preferences.dart';
   ```

3. **Error handling yang baik**
   ```dart
   try {
     final data = await ApiService.getData();
   } catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Error: $e')),
     );
   }
   ```

4. **Use constants untuk URLs**
   - Jangan hard-code URL di screen
   - Gunakan `AppConstants.baseUrl`

5. **Naming convention**
   - Files: `snake_case` (home_screen.dart)
   - Classes: `PascalCase` (HomeScreen)
   - Variables: `camelCase` (homeScreen)

---

## 📞 Kontak & Support

Jika ada masalah:
1. Cek [Flutter Documentation](https://flutter.dev/docs)
2. Jalankan `flutter doctor -v`
3. Cek console output dengan `flutter run -v`
4. Cek API response dengan tools seperti Postman

---

## ✅ Checklist Sebelum Deploy

- [ ] Semua API endpoints sudah siap
- [ ] Base URL sudah di-update di constants.dart
- [ ] Test di emulator dan device fisik
- [ ] Test internet connection dengan API
- [ ] Handle error cases
- [ ] Update app version di pubspec.yaml
- [ ] Build APK/IPA berhasil
- [ ] Test build file di device

---

## 🎉 Selesai!

Aplikasi Favenue Mobile Anda sudah siap dikembangkan!

**Next Steps:**
1. Integrasikan dengan backend API Anda
2. Tambahkan fitur detail pages
3. Implementasikan authentication
4. Add messaging/chat features
5. Set up payment gateway

Happy Coding! 🚀
