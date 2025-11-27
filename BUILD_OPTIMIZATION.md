# Build Optimization Summary

This document describes the build optimizations implemented for the Stash It Flutter app.

## Overview

The build system has been optimized for both local development and CI/CD environments with:
- Parallel build execution
- Aggressive caching strategies
- Configuration caching
- Optimized memory allocation
- Security validation

## Key Optimizations

### 1. **Java Version Compatibility**
- **Configuration**: Java 17 (LTS baseline)
- **Applied to**:
  - `android/gradle.properties`: `kotlin.jvm.target=17`
  - `android/build.gradle.kts`: JVM target VERSION_17
  - `android/app/build.gradle.kts`: compileOptions and kotlinOptions VERSION_17

### 2. **Gradle Build Performance**

#### Local Development (`android/gradle.properties`)
- **Parallel builds enabled**: `org.gradle.parallel=true`
- **Workers**: Up to 4 (`org.gradle.workers.max=4`)
- **Configuration caching**: `org.gradle.configuration-cache=true`
- **Incremental compilation**: Kotlin incremental compilation enabled
- **Memory allocation**: 4GB heap, 1GB metaspace (balanced for development)
- **Build daemon**: Enabled for faster subsequent builds

#### CI Environment (`android/gradle-ci.properties`)
- **Parallel builds enabled**: `org.gradle.parallel=true`
- **Workers**: 2 (optimal for CI runners)
- **Configuration caching**: Disabled (can be unstable in CI)
- **Incremental compilation**: Disabled (clean builds preferred)
- **Memory allocation**: 3GB heap, 768MB metaspace (CI-optimized)
- **Build daemon**: Disabled (not needed for single-use CI)

### 3. **GitHub Actions Workflows**

#### Build Workflow (`build.yml`)
- **Concurrency control**: Cancel in-progress runs for same branch
- **Timeout**: 30 minutes
- **Caching**: 
  - Gradle dependencies via `actions/setup-java`
  - Flutter SDK via `subosito/flutter-action`
  - Pub packages via `actions/cache`
- **Parallel test execution**: Uses all available CPU cores
- **Security**: Gradle wrapper validation
- **Code generation**: Automatically runs `build_runner`

#### Release Workflow (`release.yml`)
- **Timeout**: 45 minutes
- **Caching**: Same as build workflow
- **Artifact retention**: 90 days
- **Auto-generated release notes**
- **Parallel test execution**
- **Security**: Gradle wrapper validation

#### Website Deployment (`deploy-website.yml`)
- **Timeout**: 15 minutes
- **Caching**:
  - npm packages via `actions/setup-node`
  - node_modules and .astro build cache
- **Offline mode**: `npm ci --prefer-offline`

### 4. **Android Build Features**
- **Disabled unused features**: buildConfig, aidl, renderScript, shaders, resValues
- **Resource optimization**: 
  - `android.nonFinalResIds=true`
  - `android.nonTransitiveRClass=true`
- **Lint configuration**: Suppress non-critical warnings
- **R8 optimization**: Enabled but not in full mode (for stability)

## Build Times

| Environment | Build Type | Estimated Time | Notes |
|------------|-----------|----------------|-------|
| Local (first) | Debug APK | ~2-3 min | Includes dependency download |
| Local (cached) | Debug APK | ~30-60s | With warm Gradle daemon |
| Local | Release APK | ~1-2 min | Optimized build |
| CI (first) | Full workflow | ~5-8 min | Includes setup + tests |
| CI (cached) | Full workflow | ~3-5 min | With dependency caching |

**APK Sizes:**
- Debug: ~150MB (includes debug symbols)
- Release: ~60MB (tree-shaken and optimized)

The release APK is 60% smaller thanks to Flutter's automatic tree-shaking of unused code and icon fonts.

## Key Files

### Build Configuration
1. `android/gradle.properties` - Local development settings (parallel, caching enabled)
2. `android/gradle-ci.properties` - CI-optimized settings (daemon disabled, reduced memory)
3. `android/build.gradle.kts` - Root build script with JVM target
4. `android/app/build.gradle.kts` - App-level configuration with build features

### CI/CD Workflows
1. `.github/workflows/build.yml` - PR/push validation with parallel tests
2. `.github/workflows/release.yml` - Tag-triggered release builds
3. `.github/workflows/deploy-website.yml` - Astro documentation deployment

## Best Practices Applied

✅ **Caching Strategy**
- Multi-level caching (Gradle, Flutter SDK, pub packages, npm)
- Separate local vs CI configuration
- Cache key based on lock files for accuracy

✅ **Parallel Execution**
- Gradle parallel builds enabled
- Multiple workers for concurrent tasks
- Parallel test execution with all CPU cores

✅ **Security**
- Gradle wrapper validation in CI
- Secure handling of signing credentials
- Automatic cleanup of sensitive files

✅ **Optimization**
- Configuration caching for faster configuration phase
- Incremental compilation in development
- Disabled unused Android build features
- Proper memory allocation per environment

✅ **Developer Experience**
- Fast incremental builds locally
- Clear timeout limits prevent hung jobs
- Concurrency control prevents redundant builds
- Auto-generated release notes

## Usage

### Local Development
```bash
# Uses android/gradle.properties automatically
flutter build apk --debug
flutter build apk --release
```

### CI/CD
The workflows automatically copy `android/gradle-ci.properties` over `android/gradle.properties` for optimal CI performance.

### Manual Testing
To test with CI settings locally:
```bash
cp android/gradle-ci.properties android/gradle.properties
flutter build apk --release
git restore android/gradle.properties
```

## Performance Tips

1. **First build**: Run `flutter pub get && dart run build_runner build --delete-conflicting-outputs` before building
2. **Clean builds**: Use `flutter clean` if encountering issues, but avoid in normal workflow
3. **Gradle daemon**: Keep running locally for faster builds (`./gradlew --status`)
4. **Android Studio**: Disable auto-import to prevent unexpected Gradle syncs

## Future Improvements

- [ ] Consider enabling R8 full mode after thorough testing
- [ ] Explore build splitting per ABI for Play Store (smaller downloads)
- [ ] Add build performance metrics tracking
- [ ] Implement build cache remote sharing for teams
