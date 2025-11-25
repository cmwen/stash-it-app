#!/usr/bin/env zsh

# Helper script to generate code for this Flutter project.
# - runs `flutter pub get` (safe to call repeatedly)
# - runs build_runner to generate Drift and Riverpod generated files

set -euo pipefail

echo "[stash-it] Ensuring dependencies are installed..."
flutter pub get

echo "[stash-it] Running code generation (build_runner)..."
flutter pub run build_runner build --delete-conflicting-outputs

echo "[stash-it] Code generation finished. You can now run the app with 'flutter run'."
