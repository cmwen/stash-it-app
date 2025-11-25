import 'package:flutter/material.dart';

/// Design tokens for colors used throughout the app.
abstract class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF6750A4);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color onPrimaryContainer = Color(0xFF21005D);

  // Secondary Palette
  static const Color secondary = Color(0xFF625B71);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE8DEF8);
  static const Color onSecondaryContainer = Color(0xFF1D192B);

  // Surface & Background
  static const Color surface = Color(0xFFFFFBFE);
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color surfaceVariant = Color(0xFFE7E0EC);
  static const Color onSurfaceVariant = Color(0xFF49454F);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Reader Themes - Light
  static const Color readerLightBg = Color(0xFFFFFFFF);
  static const Color readerLightText = Color(0xFF1C1B1F);

  // Reader Themes - Dark
  static const Color readerDarkBg = Color(0xFF1C1B1F);
  static const Color readerDarkText = Color(0xFFE6E1E5);

  // Reader Themes - Sepia
  static const Color readerSepiaBg = Color(0xFFF4ECD8);
  static const Color readerSepiaText = Color(0xFF5B4636);

  // Status Indicators
  static const Color unreadDot = Color(0xFF6750A4);
  static const Color offlineBanner = Color(0xFFFFF3E0);
  static const Color deleteBackground = Color(0xFFFFCDD2);
  static const Color deleteIcon = Color(0xFFD32F2F);
}
