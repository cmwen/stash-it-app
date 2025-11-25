# Stash It 📚

> Your personal content library that works everywhere, respects your privacy, and puts you in control of your data.

**Stash It** is a local-first, offline-capable "save it later" app inspired by Pocket. Save articles, read them offline, and never worry about losing access to your content.

![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

### Core (MVP) ✅
- 📥 **Save from Anywhere** - Add URLs manually or via share intent
- 📖 **Clean Reader** - Distraction-free reading with extracted content
- 📴 **Fully Offline** - All content stored locally with SQLite/Drift
- 🔒 **Privacy-First** - No accounts, no tracking, no cloud
- 🎨 **Beautiful UI** - Material 3 design with light/dark themes
- ⚡ **Fast & Responsive** - Optimized for smooth scrolling and quick loading

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

## 📸 Screenshots

| Home | Reader | Settings |
|------|--------|----------|
| Article list with thumbnails | Clean reading experience | Theme & preferences |

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

# Generate code (Drift database & Riverpod providers)
dart run build_runner build --delete-conflicting-outputs

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
├── main.dart             # App entry point
├── core/
│   ├── router/           # GoRouter navigation
│   └── theme/            # Material 3 theming (colors, spacing, durations)
├── features/
│   ├── articles/
│   │   ├── domain/       # Article entity, repository interface
│   │   ├── data/         # Drift database, services, repository impl
│   │   └── presentation/ # Pages (Home, Reader), widgets, providers
│   └── settings/
│       └── presentation/ # Settings page
└── shared/
    └── widgets/          # EmptyState, LoadingSkeleton, OfflineBanner
```

### Tech Stack
- **Framework:** Flutter 3.10+
- **State Management:** Riverpod with code generation
- **Database:** Drift (SQLite) - local-first persistence
- **HTTP:** Dio for fetching articles
- **Navigation:** go_router for declarative routing
- **Content Extraction:** Custom HTML parser with `html` package
- **UI Components:** flutter_html, shimmer, cached_network_image

## 📖 Documentation

| Document | Description |
|----------|-------------|
| [Product Vision](docs/PRODUCT_VISION.md) | Why we're building this |
| [User Stories](docs/USER_STORIES.md) | Feature requirements |
| [Technical Requirements](docs/REQUIREMENTS_TECHNICAL.md) | Implementation details |
| [MVP Roadmap](docs/ROADMAP_MVP.md) | Development plan |
| [UX Design](docs/UX_DESIGN.md) | User experience & wireframes |
| [Design System](docs/DESIGN_SYSTEM.md) | Colors, typography, spacing |
| [Personas](docs/PERSONAS.md) | Target user profiles |

## 🛣️ Roadmap

### v1.0 - MVP ✅
- [x] Project setup & architecture
- [x] Article entity & repository
- [x] Drift database with offline storage
- [x] Content extraction service
- [x] Home page with article list
- [x] Reader view with clean typography
- [x] Add URL functionality
- [x] Swipe to delete with undo
- [x] Material 3 theming (light/dark)
- [x] Settings page

### v1.5 - Organization
- [ ] Tags
- [ ] Full-text search
- [ ] Archive
- [ ] Export

### v2.0 - Enhanced
- [ ] Import from Pocket
- [ ] Favorites
- [ ] Reader customization (font size, themes)

### v3.0 - Sync
- [ ] P2P device discovery
- [ ] Conflict-free sync (CRDTs)
- [ ] Multi-device support

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Analyze code
flutter analyze
```

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) first.

## 📄 License

MIT License - see [LICENSE](LICENSE)

---

**Made with ❤️ for offline readers everywhere**
