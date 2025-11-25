# Minimal Flutter App Template

A minimal, clean Flutter application template designed for cross-platform development. This template provides a simple starting point with support for Android, iOS, Web, Linux, macOS, and Windows.

## Features

- 🚀 **Cross-platform**: Build for Android, iOS, Web, Linux, macOS, and Windows
- 📦 **Simple Dependencies**: Manage packages with `pubspec.yaml`
- 🎨 **Material Design 3**: Beautiful UI components out of the box
- 🔥 **Hot Reload**: See your changes instantly
- ⚡ **Fast Development**: No more waiting for builds
- 🧪 **Testing Built-in**: Widget, integration, and unit testing support
- 🤖 **AI-Ready**: Optimized for AI-assisted development

## Quick Start

### Prerequisites

- Flutter SDK 3.10.1 or higher
- Dart 3.10.1 or higher

### Installation

```bash
# Clone this repository
git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name

# Get dependencies
flutter pub get

# Run on your preferred platform
flutter run
```

### Build

```bash
flutter build apk         # Android APK
flutter build appbundle   # Android App Bundle (Play Store)
flutter build ios         # iOS
flutter build web         # Web
```

## 🎯 AI Customization Points

This template is designed to be easily customizable with AI assistants. Key areas to modify:

### 1. App Identity
Edit `pubspec.yaml`:
```yaml
name: your_app_name
description: "Your app description"
version: 1.0.0+1
```

### 2. App Entry Point
Edit `lib/main.dart`:
- Change `title` to your app name
- Modify `colorScheme` seedColor for theming
- Replace `MyHomePage` with your own screens

### 3. Android Configuration
Edit `android/app/build.gradle.kts`:
- Change `applicationId` to your package name (e.g., `com.yourcompany.yourapp`)

### 4. iOS Configuration
Update `ios/Runner.xcodeproj` bundle identifier

### 5. Website (GitHub Pages)
Edit `astro/astro.config.mjs`:
```js
const GITHUB_USERNAME = 'your-username';
const REPO_NAME = 'your-repo-name';
```
This will deploy to: `https://your-username.github.io/your-repo-name/`

## CI/CD

### GitHub Actions Workflows

- **build.yml**: Builds and tests on every push/PR
- **release.yml**: Creates signed releases on version tags
- **deploy-website.yml**: Deploys documentation to GitHub Pages

### Signed Releases

To enable signed Android releases, add these secrets to your GitHub repository:

| Secret | Description |
|--------|-------------|
| `ANDROID_KEYSTORE_BASE64` | Base64-encoded keystore file |
| `ANDROID_KEYSTORE_PASSWORD` | Keystore password |
| `ANDROID_KEY_ALIAS` | Key alias |
| `ANDROID_KEY_PASSWORD` | Key password |

Generate base64 keystore:
```bash
base64 -i your-keystore.jks | pbcopy  # macOS
```

## Project Structure

```
├── lib/main.dart         # App entry point
├── test/                 # Tests
├── android/              # Android configuration
├── ios/                  # iOS configuration
├── web/                  # Web configuration
├── astro/                # Documentation website
├── docs/                 # AI prompting guides
└── pubspec.yaml          # Dependencies
```

## Documentation

- [AI Prompting Guide](AI_PROMPTING_GUIDE.md) - How to use AI to customize this template
- [Contributing](CONTRIBUTING.md) - How to contribute
- [Testing](TESTING.md) - Testing guide

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language](https://dart.dev/)
- [Flutter Packages](https://pub.dev/)

## License

MIT License - see [LICENSE](LICENSE)
