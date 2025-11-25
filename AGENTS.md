# Agent Configuration and Instructions

This document provides guidance for AI agents and automated tools working with this Flutter template repository.

## Repository Overview

This is a minimal Flutter application template designed to serve as a starting point for cross-platform projects. It follows modern Flutter development practices and includes comprehensive CI/CD setup.

## Key Technologies

- **Framework**: Flutter 3.10.1+
- **Language**: Dart 3.10.1+
- **Platforms**: Android, iOS, Web, Linux, macOS, Windows
- **Package Manager**: pub (pubspec.yaml)
- **Testing**: flutter_test, Widget testing
- **Linting**: flutter_lints 6.0.0

## Project Structure

```
├── lib/                    # Dart source code
│   └── main.dart           # App entry point
├── test/                   # Unit and widget tests
├── android/                # Android platform files
├── ios/                    # iOS platform files
├── web/                    # Web platform files
├── macos/                  # macOS platform files
├── linux/                  # Linux platform files
├── windows/                # Windows platform files
├── astro/                  # Documentation website (Astro)
├── docs/                   # AI prompting guides
├── .github/                # CI/CD workflows and agents
│   ├── workflows/          # GitHub Actions
│   ├── agents/             # Copilot Chat agents
│   └── prompts/            # Copilot custom prompts
└── pubspec.yaml            # Dependencies and project config
```

## AI Customization Points

When using this template, AI agents should focus on these key customization areas:

### 1. App Identity (pubspec.yaml)
```yaml
name: your_app_name           # Change app name
description: "Your app description"
version: 1.0.0+1              # Update version
```

### 2. App Entry Point (lib/main.dart)
- Change `title` in MaterialApp
- Modify `colorScheme` seedColor for theming
- Replace `MyHomePage` with your own screens

### 3. Android Configuration
- `android/app/build.gradle.kts`: Change `applicationId`
- `android/app/build.gradle.kts`: Configure signing (see release workflow)

### 4. iOS Configuration
- `ios/Runner.xcodeproj`: Update bundle identifier

### 5. GitHub Pages (astro/astro.config.mjs)
- Update `GITHUB_USERNAME` and `REPO_NAME` for deployment URL

## Flutter Commands

### Basic Commands
```bash
# Get dependencies
flutter pub get

# Run app
flutter run

# Build release
flutter build apk           # Android APK
flutter build appbundle     # Android App Bundle
flutter build ios           # iOS
flutter build web           # Web

# Run tests
flutter test

# Analyze code
flutter analyze
```

## CI/CD Workflows

### build.yml
- Runs on push to main/develop and PRs
- Builds APK, App Bundle, and Web
- Runs tests and uploads coverage

### release.yml
- Triggered by version tags (v*)
- Builds signed release artifacts
- Creates GitHub Release with assets

**Required Secrets for Signed Releases:**
- `ANDROID_KEYSTORE_BASE64`: Base64-encoded keystore file
- `ANDROID_KEYSTORE_PASSWORD`: Keystore password
- `ANDROID_KEY_ALIAS`: Key alias
- `ANDROID_KEY_PASSWORD`: Key password

### deploy-website.yml
- Deploys Astro site to GitHub Pages
- Triggered on GitHub Release publish

## Documentation Resources

- `docs/AI_BEGINNER_GUIDE.md` - For complete beginners
- `docs/AI_INTERMEDIATE_GUIDE.md` - For developers new to Flutter
- `docs/AI_ADVANCED_GUIDE.md` - For experienced developers
- `docs/AI_PROMPT_TEMPLATES.md` - Ready-to-use prompts
- `AI_PROMPTING_GUIDE.md` - Overview of all guides
