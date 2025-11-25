# Agent Configuration and Instructions

This document provides guidance for AI agents and automated tools working with the Stash It application.

## Repository Overview

Stash It is a local-first, offline-capable "save it later" app inspired by Pocket. Built with Flutter for cross-platform support, it uses Clean Architecture with Riverpod for state management and Drift (SQLite) for local persistence.

## Key Technologies

- **Framework**: Flutter 3.10.1+
- **Language**: Dart 3.10.1+
- **State Management**: Riverpod with code generation
- **Database**: Drift (SQLite) - local-first persistence
- **Navigation**: go_router
- **HTTP**: Dio
- **Platforms**: Android, iOS, Web, Linux, macOS, Windows
- **Testing**: flutter_test, mocktail
- **Linting**: flutter_lints 6.0.0

## Project Structure

```
├── lib/
│   ├── main.dart               # App entry point with Riverpod & Router
│   ├── core/
│   │   ├── router/             # GoRouter configuration
│   │   └── theme/              # Material 3 theming (colors, spacing, durations)
│   ├── features/
│   │   ├── articles/
│   │   │   ├── domain/         # Article entity, repository interface
│   │   │   ├── data/           # Database, services, repository impl
│   │   │   └── presentation/   # Pages, widgets, providers
│   │   └── settings/
│   │       └── presentation/   # Settings page
│   └── shared/
│       └── widgets/            # EmptyState, LoadingSkeleton, OfflineBanner
├── test/                       # Unit and widget tests
├── android/                    # Android platform files
├── ios/                        # iOS platform files
├── web/                        # Web platform files
├── macos/                      # macOS platform files
├── linux/                      # Linux platform files
├── windows/                    # Windows platform files
├── astro/                      # Documentation website (Astro)
├── docs/                       # Product & design documentation
│   ├── PRODUCT_VISION.md       # Why we're building this
│   ├── USER_STORIES.md         # Feature requirements
│   ├── REQUIREMENTS_TECHNICAL.md # Technical specs
│   ├── ROADMAP_MVP.md          # Development plan
│   ├── UX_DESIGN.md            # Wireframes & user flows
│   ├── DESIGN_SYSTEM.md        # Colors, typography, spacing
│   └── PERSONAS.md             # Target user profiles
├── .github/                    # CI/CD workflows
└── pubspec.yaml                # Dependencies and project config
```

## Architecture Overview

### Clean Architecture Layers

1. **Domain Layer** (`features/*/domain/`)
   - Entities (Article)
   - Repository interfaces
   - Business logic

2. **Data Layer** (`features/*/data/`)
   - Drift database with code generation
   - Content extraction service
   - Web fetching service
   - Repository implementations

3. **Presentation Layer** (`features/*/presentation/`)
   - Pages (HomePage, ReaderPage, SettingsPage)
   - Widgets (ArticleCard, AddUrlSheet, etc.)
   - Riverpod providers

### Key Files

- `lib/main.dart` - App entry with ProviderScope and MaterialApp.router
- `lib/core/theme/app_theme.dart` - Light/dark Material 3 themes
- `lib/core/router/app_router.dart` - GoRouter with /, /article/:id, /settings
- `lib/features/articles/data/datasources/local/database.dart` - Drift database
- `lib/features/articles/presentation/providers/` - Riverpod state management

## Flutter Commands

### Development
```bash
# Get dependencies
flutter pub get

# Generate code (Drift database & Riverpod providers)
dart run build_runner build --delete-conflicting-outputs

# Run app
flutter run

# Run on specific device
flutter run -d chrome     # Web
flutter run -d macos      # macOS
flutter run -d android    # Android

# Watch for changes (continuous code generation)
dart run build_runner watch --delete-conflicting-outputs
```

### Build
```bash
flutter build apk           # Android APK
flutter build appbundle     # Android App Bundle
flutter build ios           # iOS
flutter build web           # Web
```

### Testing
```bash
flutter test                # Run all tests
flutter test --coverage     # With coverage
flutter analyze             # Static analysis
dart format .               # Format code
```

## Code Generation

This project uses code generation for:

1. **Drift Database** - Generates `*.g.dart` files for database tables and queries
2. **Riverpod Providers** - Generates provider code from annotations

Always run `dart run build_runner build --delete-conflicting-outputs` after:
- Cloning the repository
- Modifying database tables
- Adding/modifying Riverpod providers with annotations

## CI/CD Workflows

### build.yml
- Runs on push to main/develop and PRs
- Builds APK, App Bundle, and Web
- Runs tests and uploads coverage

### release.yml
- Triggered by version tags (v*)
- Builds signed release artifacts
- Creates GitHub Release with assets

### deploy-website.yml
- Deploys Astro site to GitHub Pages
- Triggered on GitHub Release publish

## Documentation Resources

### Product Documentation
- `docs/PRODUCT_VISION.md` - Product goals and philosophy
- `docs/USER_STORIES.md` - Feature requirements
- `docs/REQUIREMENTS_TECHNICAL.md` - Technical specifications
- `docs/ROADMAP_MVP.md` - Development roadmap

### Design Documentation
- `docs/UX_DESIGN.md` - User experience and wireframes
- `docs/DESIGN_SYSTEM.md` - Visual design language
- `docs/PERSONAS.md` - Target user profiles
- `docs/UX_QUICK_REFERENCE.md` - Quick reference for developers

### AI Prompting Guides
- `docs/AI_BEGINNER_GUIDE.md` - For complete beginners
- `docs/AI_INTERMEDIATE_GUIDE.md` - For developers new to Flutter
- `docs/AI_ADVANCED_GUIDE.md` - For experienced developers
- `docs/AI_PROMPT_TEMPLATES.md` - Ready-to-use prompts
