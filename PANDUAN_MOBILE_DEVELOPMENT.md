# PANDUAN LANGKAH-LANGKAH MEMBUAT MOBILE FAVENUE DENGAN FLUTTER

## 📋 PERSIAPAN AWAL

### 1. **Install Flutter & Dependencies**
```bash
# Pastikan Flutter sudah terinstall
flutter --version

# Update Flutter
flutter upgrade

# Jalankan pub get untuk menginstal semua dependencies
flutter pub get
```

---

## 📁 STRUKTUR FOLDER YANG TELAH DIBUAT

```
lib/
├── main.dart                 # Entry point aplikasi
├── models/                   # Model data
│   ├── user_model.dart
│   ├── developer_model.dart
│   └── umkm_model.dart
├── screens/                  # Halaman-halaman aplikasi
│   ├── home_screen.dart
│   ├── developer_list_screen.dart
│   ├── umkm_list_screen.dart
│   ├── dashboard_screen.dart
│   └── profile_screen.dart
├── widgets/                  # Komponen reusable
│   ├── developer_card.dart
│   ├── umkm_card.dart
│   └── custom_appbar.dart
└── utils/                    # Utility dan konstanta
    ├── theme.dart
    └── constants.dart
```

---

## 🎨 FITUR-FITUR YANG TERSEDIA

### **1. Home Screen**
- Carousel banner dengan animasi otomatis
- Quick access menu (Cari Developer, Jelajahi UMKM, Dashboard, Profil)
- List developer terbaik
- List UMKM populer

### **2. Developer List Screen**
- Search functionality
- Filter berdasarkan kategori (Web, Mobile, UI/UX, Backend, Full Stack)
- Grid view untuk menampilkan developer
- Rating dan jumlah review setiap developer

### **3. UMKM List Screen**
- Search functionality
- Filter berdasarkan kategori (Fashion, F&B, Handcraft, Electronics, Services)
- Grid view untuk menampilkan UMKM
- Lokasi dan rating setiap UMKM

### **4. Dashboard Screen**
- Welcome card dengan gradient
- Statistics cards (Proyek Aktif, Pesan Baru, Rating, Profil)
- Recent activity list

### **5. Profile Screen**
- Profile header dengan avatar
- Informasi pribadi (Email, Telepon, Lokasi, Spesialisasi)
- Bio section
- Edit Profil & Logout buttons

---

## 🚀 CARA MENJALANKAN APLIKASI

### **Option 1: Menggunakan Android/iOS Device**
```bash
# Jalankan aplikasi di device terhubung
flutter run

# Atau spesifik device
flutter run -d <device-id>
```

### **Option 2: Menggunakan Emulator**
```bash
# Jalankan Android emulator terlebih dahulu
emulator -avd <emulator-name>

# Kemudian jalankan Flutter
flutter run
```

### **Option 3: Menggunakan Web**
```bash
# Jalankan di browser
flutter run -d chrome
```

---

## 🔧 CUSTOMIZATION & PENGEMBANGAN LANJUTAN

### **1. Mengubah Warna Theme**
Edit file `lib/utils/theme.dart`:
```dart
class AppTheme {
  static const Color primaryColor = Color(0xFFFFD700); // Ganti dengan warna Anda
  static const Color secondaryColor = Color(0xFF1E3A8A);
  // ... warna lainnya
}
```

### **2. Mengintegrasikan dengan Backend API**
Buat file baru `lib/services/api_service.dart`:
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://YOUR_API_URL/api';

  // Fetch developers
  static Future<List<Developer>> getDevelopers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/developers'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Developer.fromJson(item)).toList();
      }
      throw Exception('Failed to load developers');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch UMKM
  static Future<List<UMKM>> getUMKM() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/umkm'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => UMKM.fromJson(item)).toList();
      }
      throw Exception('Failed to load UMKM');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
```

Kemudian gunakan di screen:
```dart
FutureBuilder<List<Developer>>(
  future: ApiService.getDevelopers(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    return GridView.builder(
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (context, index) {
        final developer = snapshot.data![index];
        return DeveloperCard(...);
      },
    );
  },
)
```

### **3. Menambah Authentication**
```dart
// lib/services/auth_service.dart
class AuthService {
  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/login'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Simpan token
        // Redirect ke home
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
```

### **4. Menggunakan State Management (Provider)**
```bash
# Sudah ditambahkan di pubspec.yaml
# Gunakan seperti ini:
```

```dart
// lib/providers/developer_provider.dart
import 'package:provider/provider.dart';

class DeveloperProvider with ChangeNotifier {
  List<Developer> _developers = [];
  
  List<Developer> get developers => _developers;

  Future<void> fetchDevelopers() async {
    try {
      _developers = await ApiService.getDevelopers();
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
```

Kemudian di main.dart:
```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeveloperProvider()),
        ChangeNotifierProvider(create: (_) => UMKMProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
```

---

## 📱 BUILD & RELEASE

### **Untuk Android APK:**
```bash
flutter build apk --release
# File akan tersedia di: build/app/outputs/flutter-apk/app-release.apk
```

### **Untuk iOS:**
```bash
flutter build ios --release
# Kemudian upload ke App Store
```

### **Untuk Web:**
```bash
flutter build web --release
# Host di server web Anda
```

---

## 🐛 TROUBLESHOOTING

### **Error: "Plugin not found"**
```bash
flutter pub get
flutter pub upgrade
```

### **Error: "Android version mismatch"**
Cek dan update di `android/app/build.gradle`

### **Hot Reload tidak berfungsi**
```bash
flutter clean
flutter pub get
flutter run
```

### **Build gagal di Windows**
```bash
flutter clean
flutter pub get
flutter run -v
```

---

## 📝 NEXT STEPS (Pengembangan Lebih Lanjut)

1. **Tambahkan Detail Screen**
   - Developer Detail Screen
   - UMKM Detail Screen

2. **Implementasi Fitur Chat/Messaging**
   - Integrasi Firebase Realtime Database
   - Notifikasi push

3. **Payment Integration**
   - Midtrans, GCash, atau payment gateway lokal lainnya

4. **Offline Functionality**
   - SQLite local database
   - Sync ketika online

5. **Fitur Lanjutan**
   - Rating & Review
   - Booking/Order system
   - Portfolio/Project showcase
   - Real-time notifications

---

## 📞 KONTAK & SUPPORT

Jika ada pertanyaan atau error, pastikan untuk:
- Cek error message di console
- Jalankan `flutter doctor` untuk diagnosa
- Update semua dependencies dengan `flutter pub upgrade`

---

## ✅ CHECKLIST DEVELOPMENT

- [ ] Main.dart sudah di-update
- [ ] Semua screens sudah dibuat
- [ ] Models sudah dibuat
- [ ] Widgets/Components sudah dibuat
- [ ] Theme sudah dikustomisasi
- [ ] Dependencies sudah terinstall (`flutter pub get`)
- [ ] Aplikasi bisa di-run tanpa error
- [ ] Semua routing berfungsi dengan baik
- [ ] Backend API sudah siap
- [ ] API Service sudah diintegrasikan

---

**Selamat! Aplikasi Favenue mobile sudah siap untuk dikembangkan lebih lanjut!** 🎉
