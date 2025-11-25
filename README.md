# Stash It 📚

> Your personal content library that works everywhere, respects your privacy, and puts you in control of your data.

**Stash It** is a local-first, offline-capable "save it later" app inspired by Pocket. Save articles, read them offline, and never worry about losing access to your content.

## ✨ Features

### Core (MVP)
- 📥 **Save from Anywhere** - Share URLs from any app
- 📖 **Clean Reader** - Distraction-free reading experience
- 📴 **Fully Offline** - Works without internet
- 🔒 **Privacy-First** - No accounts, no tracking, no cloud

### Coming Soon
- 🏷️ Tags and organization
- 🔍 Full-text search
- 📤 Export your data
- 🔄 P2P device sync (no cloud needed!)

## 🎯 Why Stash It?

| Feature | Pocket | Instapaper | **Stash It** |
|---------|--------|------------|--------------|
| Offline Reading | ✅ | ✅ | ✅ |
| No Account Required | ❌ | ❌ | ✅ |
| Local-First | ❌ | ❌ | ✅ |
| P2P Sync | ❌ | ❌ | 🔮 Coming |
| Free & Open | ❌ | ❌ | ✅ |

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.10.1+
- Dart 3.10.1+

### Installation

```bash
# Clone the repository
git clone https://github.com/cmwen/stash-it-app.git
cd stash-it-app

# Get dependencies
flutter pub get

# Generate code (Drift / codegen)
# Drift and Riverpod rely on code generation - run this before the first `flutter run`.
# Use the included helper script or run build_runner manually.

```bash
# helper (from repo root)
scripts/dev/generate_code.sh

# or run manually
flutter pub run build_runner build --delete-conflicting-outputs
```

# Run the app
flutter run
```

### Build

```bash
flutter build apk         # Android APK
flutter build appbundle   # Android App Bundle
flutter build ios         # iOS
flutter build web         # Web
```

## 📱 Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🏗️ Architecture

Stash It uses **Clean Architecture** with a local-first approach:

```
lib/
├── app/              # App configuration, routing
├── core/             # Shared utilities, theme
├── features/
│   ├── articles/     # Save, read, manage articles
│   ├── settings/     # App preferences
│   └── sync/         # Future P2P sync
└── shared/           # Reusable widgets
```

### Tech Stack
- **Framework:** Flutter
- **State:** Riverpod
- **Database:** Isar (local-first)
- **HTTP:** Dio
- **Navigation:** go_router

## 📖 Documentation

| Document | Description |
|----------|-------------|
| [Product Vision](docs/PRODUCT_VISION.md) | Why we're building this |
| [User Stories](docs/USER_STORIES.md) | Feature requirements |
| [Technical Requirements](docs/REQUIREMENTS_TECHNICAL.md) | Implementation details |
| [MVP Roadmap](docs/ROADMAP_MVP.md) | Development plan |

## 🛣️ Roadmap

### v1.0 - MVP (In Progress)
- [x] Project setup
- [ ] Save articles via share
- [ ] Content extraction
- [ ] Offline storage
- [ ] Reader view
- [ ] Basic theming

### v1.5 - Organization
- [ ] Tags
- [ ] Full-text search
- [ ] Archive
- [ ] Export

### v2.0 - Enhanced
- [ ] Import from Pocket
- [ ] Favorites
- [ ] Reader customization

### v3.0 - Sync
- [ ] P2P device discovery
- [ ] Conflict-free sync
- [ ] Multi-device support

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) first.

## 📄 License

MIT License - see [LICENSE](LICENSE)

---

**Made with ❤️ for offline readers everywhere**
