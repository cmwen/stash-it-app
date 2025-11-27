import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Keys for stored settings.
class SettingsKeys {
  static const String themeMode = 'theme_mode';
  static const String fontSize = 'font_size';
}

/// Font size options for the reader.
enum ReaderFontSize {
  small(14.0, 'Small'),
  medium(18.0, 'Medium'),
  large(22.0, 'Large'),
  xlarge(26.0, 'Extra Large');

  final double size;
  final String label;
  const ReaderFontSize(this.size, this.label);
}

/// Provider for SharedPreferences instance.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden in main.dart');
});

/// Theme mode state notifier.
class ThemeModeNotifier extends Notifier<ThemeMode> {
  late final SharedPreferences _prefs;

  @override
  ThemeMode build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    return _loadThemeMode(_prefs);
  }

  static ThemeMode _loadThemeMode(SharedPreferences prefs) {
    final value = prefs.getString(SettingsKeys.themeMode);
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _prefs.setString(SettingsKeys.themeMode, mode.name);
  }

  String get themeModeLabel {
    switch (state) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System default';
    }
  }
}

/// Provider for theme mode.
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

/// Font size state notifier.
class FontSizeNotifier extends Notifier<ReaderFontSize> {
  late final SharedPreferences _prefs;

  @override
  ReaderFontSize build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    return _loadFontSize(_prefs);
  }

  static ReaderFontSize _loadFontSize(SharedPreferences prefs) {
    final value = prefs.getString(SettingsKeys.fontSize);
    return ReaderFontSize.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ReaderFontSize.medium,
    );
  }

  Future<void> setFontSize(ReaderFontSize size) async {
    state = size;
    await _prefs.setString(SettingsKeys.fontSize, size.name);
  }
}

/// Provider for reader font size.
final fontSizeProvider = NotifierProvider<FontSizeNotifier, ReaderFontSize>(
  FontSizeNotifier.new,
);
