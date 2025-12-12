# 📊 SYSTEM ARCHITECTURE & FLOW DIAGRAM

## 🏗️ APPLICATION STRUCTURE

```
FAVENUE Booking System
│
├── Authentication Layer
│   ├── Landing Screen
│   ├── Login Screen
│   ├── Register Screen
│   └── Role Selection Screen
│
├── UMKM Module
│   ├── UMKM Home Screen
│   │   ├── Developer List
│   │   ├── My Projects
│   │   └── Booking Button
│   │
│   └── Booking Flow
│       ├── Booking Detail Screen
│       │   ├── Project Info
│       │   ├── Offer Form
│       │   └── Deadline Picker
│       │
│       └── Booking List Screen
│           ├── History View
│           ├── Status Filter
│           └── Detail Modal
│
└── Developer Module
    ├── Developer Home Screen
    │   ├── Project List
    │   ├── Active Projects
    │   └── Proposal Button
    │
    └── Booking Flow
        ├── Booking Detail Screen
        │   ├── Project Info
        │   ├── Proposal Form
        │   └── Deadline Picker
        │
        └── Booking List Screen
            ├── History View
            ├── Status Filter
            └── Detail Modal
```

---

## 🔄 USER FLOW DIAGRAM

### **UMKM Journey (Booking Developer)**

```
┌─────────────┐
│ UMKM Login  │
└──────┬──────┘
       │
       ▼
┌──────────────────────────┐
│ UMKM Home Screen         │
│ - Developer List         │
│ - My Projects            │
│ - "Booking Sekarang" Btn │
└──────┬───────────────────┘
       │
       ▼ (Click "Booking Sekarang")
┌────────────────────────────────┐
│ Booking Detail Screen          │
│ - Developer Info               │
│ - Offer Text Field             │
│ - Deadline Date Picker         │
│ - Form Validation              │
└──────┬────────────────────┬────┘
       │ (Valid)            │ (Cancel)
       ▼                    ▼
┌──────────────┐      ┌──────────┐
│ ✅ Success   │      │ Back     │
│ Notification │      └──────────┘
└──────┬───────┘
       │
       ▼
┌─────────────────────────────┐
│ Return to UMKM Home         │
│ Auto after 1 second         │
└──────┬──────────────────────┘
       │
       ▼ (Click "Riwayat Booking")
┌──────────────────────────────┐
│ Booking List Screen          │
│ - Filter by Status           │
│ - View All Bookings          │
│ - Click for Details          │
└──────────────────────────────┘
```

### **Developer Journey (Proposal Project)**

```
┌───────────────────┐
│ Developer Login   │
└────────┬──────────┘
         │
         ▼
┌──────────────────────────┐
│ Developer Home Screen    │
│ - Project List           │
│ - Active Projects        │
│ - "Ajukan" Button        │
└────────┬─────────────────┘
         │
         ▼ (Click "Ajukan")
┌─────────────────────────────┐
│ Booking Detail Screen       │
│ - Project Info              │
│ - Proposal Text Field       │
│ - Deadline Date Picker      │
│ - Form Validation           │
└────────┬──────────┬─────────┘
         │ (Valid)  │ (Cancel)
         ▼          ▼
┌─────────────┐  ┌──────────┐
│ ✅ Success  │  │ Back     │
│Notification │  └──────────┘
└────────┬────┘
         │
         ▼
┌─────────────────────────────┐
│ Return to Developer Home    │
│ Auto after 1 second         │
└────────┬────────────────────┘
         │
         ▼ (Click "Riwayat Booking")
┌──────────────────────────────┐
│ Booking List Screen          │
│ - Filter by Status           │
│ - View All Proposals         │
│ - Click for Details          │
└──────────────────────────────┘
```

---

## 📈 DATA FLOW

```
┌─────────────────────────────────┐
│   User Input (Form)             │
│   ├── Offer/Proposal Text       │
│   └── Deadline Date             │
└────────────┬────────────────────┘
             │
             ▼
┌─────────────────────────────────┐
│   Validation Layer              │
│   ├── Not Empty Check           │
│   ├── Date Picker Check         │
│   └── Error Messages            │
└────────────┬────────────────────┘
             │
      ┌──────┴──────┐
      │ (Valid)     │ (Invalid)
      ▼             ▼
   ┌──┐        ┌─────────────┐
   │✓│         │ Error Alert │
   └──┘        └─────────────┘
      │
      ▼
┌─────────────────────────────────┐
│   Booking Model Created         │
│   ├── ID (timestamp)            │
│   ├── Project/Developer Info    │
│   ├── Offer/Proposal Text       │
│   ├── Deadline                  │
│   └── Status: "pending"         │
└────────────┬────────────────────┘
             │
             ▼
┌─────────────────────────────────┐
│   Success Notification (2s)     │
│   "Penawaran berhasil dikirim!" │
└────────────┬────────────────────┘
             │
             ▼ (Auto after 1s)
┌─────────────────────────────────┐
│   Navigate Back to Home          │
└─────────────────────────────────┘
```

---

## 🎨 STATUS WORKFLOW

```
Created Booking
     │
     ▼
┌─────────────┐
│   PENDING   │ 🟡 Menunggu (Orange)
│ (Menunggu)  │
└──────┬──────┘
       │
       ├─────────────────┐
       │                 │
       ▼                 ▼
  ┌────────────┐   ┌────────────┐
  │  ACCEPTED  │   │  REJECTED  │
  │ (Diterima) │   │  (Ditolak) │
  │ 🟢 Green   │   │  🔴 Red    │
  └─────┬──────┘   └────────────┘
        │
        ▼
  ┌────────────┐
  │ COMPLETED  │
  │ (Selesai)  │
  │ 🔵 Blue    │
  └────────────┘
```

---

## 🗂️ FILE STRUCTURE

```
lib/
├── models/
│   ├── booking_model.dart          ← NEW (Booking data)
│   ├── developer_model.dart        (existing)
│   ├── umkm_model.dart            (existing)
│   └── user_model.dart            (existing)
│
├── screens/
│   ├── booking_detail_screen.dart  ← NEW (Form screen)
│   ├── booking_list_screen.dart    ← NEW (History screen)
│   ├── umkm_home_screen.dart       ✏️ MODIFIED (Added booking)
│   ├── developer_home_screen.dart  ✏️ MODIFIED (Added proposal)
│   ├── landing_screen.dart        (existing)
│   ├── login_screen.dart          (existing)
│   ├── register_screen.dart       (existing)
│   ├── role_selection_screen.dart (existing)
│   ├── home_screen.dart           (existing)
│   ├── dashboard_screen.dart      (existing)
│   ├── profile_screen.dart        (existing)
│   ├── developer_list_screen.dart (existing)
│   ├── umkm_list_screen.dart      (existing)
│   ├── about_screen.dart          (existing)
│   ├── explore_screen.dart        (existing)
│   └── knowledge_screen.dart      (existing)
│
├── services/
│   └── api_service.dart           (existing)
│
├── utils/
│   ├── constants.dart             (existing)
│   └── theme.dart                 (existing)
│
├── widgets/
│   ├── custom_appbar.dart         (existing)
│   ├── developer_card.dart        (existing)
│   └── umkm_card.dart            (existing)
│
└── main.dart                       (existing - routing)
```

---

## 🔗 NAVIGATION ROUTES

```
Landing Screen
    │
    ├─→ /landing
    │
    ▼
Login Screen → Role Selection
    │
    ├─→ /login
    ├─→ /register
    └─→ /role-selection

Role Selection
    │
    ├─→ UMKM Role
    │   │
    │   ├─→ /umkm-role
    │   ├─→ /umkm-home
    │   ├─→ /developers    (via "Booking Sekarang")
    │   └─→ /profile
    │
    └─→ Developer Role
        │
        ├─→ /developer-role
        ├─→ /developer-home
        ├─→ /umkm          (via "Ajukan")
        └─→ /profile

Booking Screens (Dynamic - no static routes)
    ├─→ BookingDetailScreen (push)
    └─→ BookingListScreen (push)
```

---

## 🎯 INTERACTION PATTERNS

### **Button Interactions**

```
┌────────────────────┐
│ Booking Button     │ (UMKM Home)
│ "Booking Sekarang" │
└────────┬───────────┘
         │ (onPressed)
         ▼
    Navigator.push()
         │
         ▼
    BookingDetailScreen
```

```
┌────────────────────┐
│ History Button     │ (Home Screens)
│ "Riwayat Booking"  │
└────────┬───────────┘
         │ (onPressed)
         ▼
    Navigator.push()
         │
         ▼
    BookingListScreen
```

### **Form Interactions**

```
┌──────────────┐
│ Text Field   │
└──────┬───────┘
       │
       ▼
┌──────────────────────┐
│ _formKey.validate()  │
└──────┬───────────────┘
       │
   ┌───┴───┐
   │       │
Valid    Invalid
   │       │
   ▼       ▼
Success  Error
```

---

## 📱 RESPONSIVE DESIGN

```
Mobile (< 600px)          Tablet (≥ 600px)
┌──────────────┐         ┌────────────────────┐
│ Full Width   │         │ Two Column Layout  │
│ Stack        │         │ Side-by-side       │
│ Layout       │         │ Cards              │
└──────────────┘         └────────────────────┘
```

---

## ✨ COMPONENT HIERARCHY

```
Scaffold
 ├── AppBar
 │   ├── Title
 │   └── Actions
 │
 ├── Body
 │   └── SingleChildScrollView
 │       └── Column
 │           ├── Header/Info Cards
 │           ├── Lists/Forms
 │           │   └── ListView/Cards
 │           │       ├── Row (Layout)
 │           │       ├── Column (Info)
 │           │       └── Buttons
 │           │
 │           └── Action Buttons
 │               ├── Logout
 │               └── History
 │
 └── Floats (Modals, Dialogs)
     └── Date Picker / Alert Dialogs
```

---

## 🔐 VALIDATION FLOW

```
User Input
    │
    ▼
┌─────────────────────────────┐
│ Form State Validation       │
└─────┬───────────────────────┘
      │
      ├─→ Check: Offer not empty
      ├─→ Check: Deadline not empty
      ├─→ Check: Date is future
      │
      ▼
   Valid?
      │
      ├──→ NO → Show Error Message
      │
      └──→ YES → Create Booking Model
                    │
                    ▼
                Show SnackBar
                    │
                    ▼
                Navigate Back
```

---

## 📊 STATE MANAGEMENT

```
StatefulWidget
    │
    ├── _formKey (Form validation)
    ├── _descriptionController (Text input)
    ├── _deadlineController (Date input)
    │
    ├── _selectedStatus (List filtering)
    ├── bookings[] (Mock data)
    │
    └── setState() (UI update trigger)
```

---

**This architecture provides a clean, scalable, and maintainable booking system!** 🚀
