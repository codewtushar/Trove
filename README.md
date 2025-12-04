# **Trove - Personal Asset Vault**

<div align="center">

![Trove Logo](https://via.placeholder.com/150x150/2D3748/FFFFFF?text=TROVE)

### **Your Digital Vault for Everything Valuable**

[![Flutter](https://img.shields.io/badge/Flutter-3.16-blue.svg)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Cloud-orange.svg)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey.svg)](https://flutter.dev)

**Organize • Track • Protect** your valuable possessions in one secure place

</div>

---

## **📱 Overview**

**Trove** is a modern, secure mobile application that helps you manage your valuable assets effortlessly. From electronics and appliances to important documents and receipts, Trove keeps everything organized, trackable, and protected in your personal digital vault.

### **Why Trove?**
- ✅ **Never lose receipts or warranty cards again**
- ✅ **Get automatic expiry reminders** for warranties and documents
- ✅ **Barcode scanning** for instant product information
- ✅ **Bank-level security** for your sensitive data
- ✅ **Cross-platform accessibility** on all your devices

---

## **✨ Features**

### **🎯 Core Features**
- **Smart Barcode Scanning** - Auto-fill product details by scanning barcodes
- **Digital Documentation** - Store receipts, warranties, and certificates securely
- **Warranty Management** - Get reminders before important dates
- **Multi-category Support** - Organize electronics, documents, furniture, appliances, and more
- **Secure Cloud Sync** - Access your data from any device

### **🔒 Security**
- End-to-end encryption for sensitive data
- Biometric authentication support
- Secure Firebase backend with user isolation
- Regular security audits and updates

### **📊 Organization**
- Categorized asset management
- Search and filter functionality
- Total value calculation
- Export data capability (PDF/CSV)

---

## **🛠️ Tech Stack**

| Technology | Purpose | Version |
|------------|---------|---------|
| **Flutter** | Cross-platform UI Framework | 3.16+ |
| **Dart** | Programming Language | 3.2+ |
| **Riverpod** | State Management | 2.4+ |
| **Firebase** | Backend & Authentication | 11.0+ |
| **Firestore** | Cloud Database | ✓ |
| **Firebase Auth** | User Authentication | ✓ |
| **Firebase Storage** | File Storage | ✓ |
| **Google Fonts** | Typography | ✓ |
| **Camera & Gallery** | Image Capture | ✓ |
| **Barcode Scanner** | Product Scanning | ✓ |

---

## **🚀 Installation**

### **Prerequisites**
- Flutter SDK (>= 3.16.0)
- Dart (>= 3.2.0)
- Android Studio / VS Code
- Firebase Account

### **Setup Instructions**

1. **Clone the Repository**
```bash
git clone https://github.com/yourusername/trove.git
cd trove
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Firebase Setup**
  - Create a new Firebase project
  - Add Android and iOS apps (if needed)
  - Download configuration files:
    - `google-services.json` → `android/app/`
    - `GoogleService-Info.plist` → `ios/Runner/`

4. **Run the App**
```bash
# For Android
flutter run

# For iOS
flutter run -d ios
```

## **📁 Project Structure**

```
lib/
├── main.dart                     # Application entry point
│
├── models/                       # Data models
│   └── AssetModel.dart           # Asset data structure
│
├── pages/                        # Screen widgets
│   ├── addAssetsPage.dart        # Add new asset screen
│   ├── homePage.dart             # Main dashboard
│   ├── loginPage.dart            # User login
│   ├── my_assets_page.dart       # Asset list view
│   ├── profilePage.dart          # User profile
│   ├── signUpPage.dart           # User registration
│   └── settings_section/         # Settings related pages
│       ├── faq_page.dart         # FAQ page
│       └── help_support_page.dart # Help & support
│
├── components/                   # Reusable UI components
│   ├── myAssetsCard.dart         # Asset display card
│   ├── noAssetsPage.dart         # Empty state component
│   └── textfields.dart           # Custom text fields
│
├── provider_services/            # State management & services
│   └── firebase_service.dart     # Firebase operations
│
└── assets/images/                # Image assets
```

---

## **🔧 Configuration**

### **Firebase Setup**
1. Enable Authentication (Email/Password)
2. Enable Firestore Database
3. Enable Firebase Storage
4. Set up security rules

### **Firestore Security Rules**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      match /assets/{assetId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

---

## **🎨 UI/UX Design Principles**

### **Typography**
- **Primary Font**: Martian Mono (Headers, UI elements)
- **Secondary Font**: Belleza (Display text, emphasis)
- **Base Font Size**: 14px with responsive scaling


## **📱 Building for Production**

### **Android**
```bash
# Generate release APK
flutter build apk --release

# Generate app bundle
flutter build appbundle --release
```

### **iOS**
```bash
# Build for iOS
flutter build ios --release

# Archive in Xcode
open ios/Runner.xcworkspace
```

---

## **📄 License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 Trove

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## **👤 Author**

**Tushar Baravkar**
- GitHub: codewtushar (https://github.com/codewtushar)
- Email: tusharbaravkar06@gmail.com


## **🌟 Show Your Support**

If you find this project helpful, please give it a ⭐️!

[![Star History Chart](https://api.star-history.com/svg?repos=yourusername/trove&type=Date)](https://star-history.com/#yourusername/trove&Date)

---

<div align="center">

**Built with ❤️ using Flutter & Firebase**

*"One scan. One place. All your valuables."*

[Report Bug](https://github.com/yourusername/trove/issues) · [Request Feature](https://github.com/yourusername/trove/issues) · [View Demo](#)

</div>

---
