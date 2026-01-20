# คู่มือการตั้งค่า App Icon สำหรับ RU Connext

## 📋 สารบัญ
1. [ข้อกำหนดเบื้องต้น](#ข้อกำหนดเบื้องต้น)
2. [โครงสร้างไฟล์ Icon](#โครงสร้างไฟล์-icon)
3. [การติดตั้งและตั้งค่า](#การติดตั้งและตั้งค่า)
4. [การสร้าง App Icons](#การสร้าง-app-icons)
5. [การตรวจสอบผลลัพธ์](#การตรวจสอบผลลัพธ์)
6. [การแก้ไขปัญหา](#การแก้ไขปัญหา)

---

## ข้อกำหนดเบื้องต้น

### ซอฟต์แวร์ที่ต้องมี:
- Flutter SDK (3.0.0 หรือสูงกว่า)
- Dart SDK
- Android Studio (สำหรับ Android development)
- Xcode (สำหรับ iOS development - เฉพาะ macOS)

### ขนาดไฟล์ Icon ที่แนะนำ:
- **icon.png**: ขนาดอย่างน้อย **1024x1024 pixels** (แนะนำ)
- รูปแบบ: PNG
- Background: โปร่งใส (transparent) หรือสีทึบก็ได้

---

## โครงสร้างไฟล์ Icon

โปรเจกต์นี้มีไฟล์ icon อยู่ในโฟลเดอร์ `icon/`:

```
icon/
├── icon.png                    # Icon หลัก (ใช้สำหรับสร้าง icons ทุกขนาด)
├── icon-20@2x.png             # iOS icon 20pt @2x
├── icon-20@3x.png             # iOS icon 20pt @3x
├── icon-29.png                # iOS icon 29pt @1x
├── icon-29@2x.png             # iOS icon 29pt @2x
├── icon-29@3x.png             # iOS icon 29pt @3x
├── icon-40.png                # iOS icon 40pt @1x
├── icon-40@2x.png             # iOS icon 40pt @2x
├── icon-40@3x.png             # iOS icon 40pt @3x
├── icon-60@2x.png             # iOS icon 60pt @2x
├── icon-60@3x.png             # iOS icon 60pt @3x
├── icon-76.png                # iOS iPad icon 76pt @1x
├── icon-76@2x.png             # iOS iPad icon 76pt @2x
└── icon-83.5@2x.png           # iOS iPad Pro icon 83.5pt @2x
```

**หมายเหตุ:** เราจะใช้เฉพาะ `icon/icon.png` ในการสร้าง icons อัตโนมัติ

---

## การติดตั้งและตั้งค่า

### ขั้นตอนที่ 1: เพิ่ม Package

ไฟล์ `pubspec.yaml` ได้ถูกตั้งค่าไว้แล้ว:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_launcher_icons: ^0.14.1

# Flutter Launcher Icons Configuration
flutter_launcher_icons:
  android: true
  ios: false  # iOS project structure is incomplete, disable for now
  image_path: "icon/icon.png"
  min_sdk_android: 21 # Android minimum SDK

  # Adaptive icons for Android
  adaptive_icon_background: "#003d7a" # ru_dark_blue color
  adaptive_icon_foreground: "icon/icon.png"
```

### ขั้นตอนที่ 2: คำอธิบาย Configuration

| คีย์ | ค่า | คำอธิบาย |
|------|-----|----------|
| `android` | `true` | เปิดใช้งานการสร้าง icon สำหรับ Android |
| `ios` | `false` | ปิดใช้งาน iOS (โครงสร้าง iOS ไม่สมบูรณ์) |
| `image_path` | `"icon/icon.png"` | ที่อยู่ของไฟล์ icon หลัก |
| `min_sdk_android` | `21` | Android SDK ต่ำสุดที่รองรับ (Android 5.0+) |
| `adaptive_icon_background` | `"#003d7a"` | สีพื้นหลังสำหรับ adaptive icon (สีน้ำเงินมหาวิทยาลัย) |
| `adaptive_icon_foreground` | `"icon/icon.png"` | ไฟล์ icon สำหรับ foreground ของ adaptive icon |

---

## การสร้าง App Icons

### วิธีที่ 1: คำสั่งทีละขั้นตอน

1. **ติดตั้ง package:**
   ```bash
   flutter pub get
   ```

2. **สร้าง icons:**
   ```bash
   flutter pub run flutter_launcher_icons
   ```

3. **รอให้กระบวนการเสร็จสิ้น:**
   ```
   ════════════════════════════════════════════
        FLUTTER LAUNCHER ICONS (v0.14.4)
   ════════════════════════════════════════════

   • Creating default icons Android
   • Creating adaptive icons Android
   • Overwriting the default Android launcher icon with a new icon
   • Updating colors.xml with color for adaptive icon background
   • Creating mipmap xml file Android

   ✓ Successfully generated launcher icons
   ```

### วิธีที่ 2: สคริปต์รวมเดียว

สร้างไฟล์ `generate_icons.bat` (Windows) หรือ `generate_icons.sh` (macOS/Linux):

**Windows (`generate_icons.bat`):**
```batch
@echo off
echo ========================================
echo  RU Connext Icon Generator
echo ========================================
echo.
echo Step 1: Installing dependencies...
call flutter pub get
echo.
echo Step 2: Generating app icons...
call flutter pub run flutter_launcher_icons
echo.
echo ========================================
echo  Icon generation completed!
echo ========================================
pause
```

**macOS/Linux (`generate_icons.sh`):**
```bash
#!/bin/bash
echo "========================================"
echo " RU Connext Icon Generator"
echo "========================================"
echo ""
echo "Step 1: Installing dependencies..."
flutter pub get
echo ""
echo "Step 2: Generating app icons..."
flutter pub run flutter_launcher_icons
echo ""
echo "========================================"
echo " Icon generation completed!"
echo "========================================"
```

**ใช้งาน:**
- Windows: Double-click `generate_icons.bat`
- macOS/Linux: `chmod +x generate_icons.sh && ./generate_icons.sh`

---

## การตรวจสอบผลลัพธ์

### ตรวจสอบไฟล์ที่ถูกสร้าง

#### Android Icons:

```
android/app/src/main/res/
├── mipmap-mdpi/
│   └── ic_launcher.png          (48x48 px)
├── mipmap-hdpi/
│   └── ic_launcher.png          (72x72 px)
├── mipmap-xhdpi/
│   └── ic_launcher.png          (96x96 px)
├── mipmap-xxhdpi/
│   └── ic_launcher.png          (144x144 px)
├── mipmap-xxxhdpi/
│   └── ic_launcher.png          (192x192 px)
├── mipmap-anydpi-v26/
│   └── ic_launcher.xml          (Adaptive icon config)
└── values/
    └── colors.xml               (Background color: #003d7a)
```

### ตรวจสอบด้วยคำสั่ง:

```bash
# ตรวจสอบว่าไฟล์ถูกสร้างครบหรือไม่
ls android/app/src/main/res/mipmap-*/ic_launcher.*

# ตรวจสอบ adaptive icon config
cat android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml

# ตรวจสอบสีพื้นหลัง
cat android/app/src/main/res/values/colors.xml
```

### ตรวจสอบบนอุปกรณ์:

1. **Build และติดตั้งแอพ:**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

2. **ตรวจสอบ icon:**
   - ดู icon บน Home Screen
   - ดู icon ใน App Drawer
   - ตรวจสอบ Adaptive Icon (Android 8.0+) โดยกดค้างที่ icon

---

## การแก้ไขปัญหา

### ❌ ปัญหา: Icons ไม่ถูกสร้าง

**สาเหตุ:** ไฟล์ `icon/icon.png` ไม่มีหรือเส้นทางผิด

**วิธีแก้:**
```bash
# ตรวจสอบว่าไฟล์มีอยู่จริง
ls icon/icon.png

# ถ้าไม่มี ให้คัดลอกไฟล์ icon เข้าไปในโฟลเดอร์ icon/
# และตั้งชื่อว่า icon.png
```

---

### ❌ ปัญหา: iOS icons ไม่ถูกสร้าง

**สาเหตุ:** โครงสร้าง iOS project ไม่สมบูรณ์

**วิธีแก้:**
- ตั้งค่า `ios: false` ใน `pubspec.yaml` (ทำแล้ว)
- สร้างเฉพาะ Android icons ก่อน
- ถ้าต้องการ iOS icons ให้สร้างโครงสร้าง iOS project ใหม่:
  ```bash
  flutter create --platforms=ios .
  ```

---

### ❌ ปัญหา: Icon ไม่เปลี่ยนหลัง build

**วิธีแก้:**
```bash
# 1. Clean project
flutter clean

# 2. ลบ build folder
rm -rf build/

# 3. ติดตั้ง dependencies ใหม่
flutter pub get

# 4. Build ใหม่
flutter run
# หรือ
flutter build apk --release
```

---

### ❌ ปัญหา: Adaptive Icon ไม่แสดงถูกต้อง

**สาเหตุ:** สีพื้นหลังไม่ตรงกับโทนสีของ icon

**วิธีแก้:**
1. แก้ไขสีพื้นหลังใน `pubspec.yaml`:
   ```yaml
   adaptive_icon_background: "#YOUR_COLOR_CODE"
   ```

2. สร้าง icons ใหม่:
   ```bash
   flutter pub run flutter_launcher_icons
   ```

---

### ❌ ปัญหา: Icon มีพื้นหลังสีขาว (Android 8.0+)

**สาเหตุ:** Icon เดิมมี alpha channel (โปร่งใส)

**วิธีแก้:**
1. ใช้ไฟล์ icon ที่มีพื้นหลังสีทึบ
2. หรือตั้งค่าสีพื้นหลังใน adaptive_icon_background

---

## 📝 เพิ่มเติม

### เปลี่ยนชื่อ Application

แก้ไขไฟล์ `android/app/src/main/AndroidManifest.xml`:

```xml
<application
    android:label="RU Connext"  <!-- เปลี่ยนชื่อตรงนี้ -->
    ...>
```

### เปลี่ยน Package Name

1. **Android:** แก้ไขใน `android/app/build.gradle`:
   ```gradle
   defaultConfig {
       applicationId "th.ac.ru.uSmart"  // Package name
       ...
   }
   ```

2. **iOS:** แก้ไขใน `ios/Runner/Info.plist`:
   ```xml
   <key>CFBundleIdentifier</key>
   <string>th.ac.ru.uSmart</string>
   ```

---

## 🎯 Checklist การตั้งค่า Icon

- [ ] ตรวจสอบว่ามีไฟล์ `icon/icon.png` (ขนาด 1024x1024 px)
- [ ] เพิ่ม `flutter_launcher_icons` ใน `pubspec.yaml`
- [ ] ตั้งค่า configuration ใน `pubspec.yaml`
- [ ] รัน `flutter pub get`
- [ ] รัน `flutter pub run flutter_launcher_icons`
- [ ] ตรวจสอบไฟล์ที่ถูกสร้างใน `android/app/src/main/res/mipmap-*/`
- [ ] ตรวจสอบ `colors.xml` มีสีพื้นหลัง `#003d7a`
- [ ] ทดสอบ build แอพ: `flutter run`
- [ ] ตรวจสอบ icon บนอุปกรณ์จริง

---

## 📞 การติดต่อ

หากพบปัญหาหรือต้องการความช่วยเหลือ:
- สร้าง Issue ในโปรเจกต์
- ติดต่อทีมพัฒนา

---

## 📚 อ้างอิง

- [Flutter Launcher Icons Package](https://pub.dev/packages/flutter_launcher_icons)
- [Android App Icon Guidelines](https://developer.android.com/guide/practices/ui_guidelines/icon_design_launcher)
- [iOS App Icon Guidelines](https://developer.apple.com/design/human-interface-guidelines/app-icons)
- [Material Design - Product Icons](https://material.io/design/iconography/product-icons.html)

---

**สร้างเมื่อ:** 2026-01-06
**เวอร์ชัน:** 1.0
**ผู้จัดทำ:** RU Connext Development Team
