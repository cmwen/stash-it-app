// Icon generation script for Stash It
// Run with: dart run assets/icon/generate_icons.dart
// This creates SVG icons for the app

import 'dart:io';

/// Stash It App Icon Design:
/// - A stylized bookmark/stash icon
/// - Primary purple (#6750A4) background with rounded corners
/// - White bookmark/folder icon representing "stashing" content
/// - Modern, clean Material 3 aesthetic

void main() async {
  // Create icon directory if it doesn't exist
  final iconDir = Directory('assets/icon');
  if (!iconDir.existsSync()) {
    iconDir.createSync(recursive: true);
  }

  // Generate the main icon SVG
  final iconSvg = generateIconSvg();
  await File('assets/icon/icon.svg').writeAsString(iconSvg);
  stdout.writeln('✅ Created icon.svg');

  // Generate foreground for adaptive icons
  final foregroundSvg = generateForegroundSvg();
  await File('assets/icon/icon_foreground.svg').writeAsString(foregroundSvg);
  stdout.writeln('✅ Created icon_foreground.svg');

  // Generate monochrome version
  final monoSvg = generateMonochromeSvg();
  await File('assets/icon/icon_mono.svg').writeAsString(monoSvg);
  stdout.writeln('✅ Created icon_mono.svg');

  stdout.writeln(
    '\n📱 Icons generated! Use flutter_launcher_icons to apply them.',
  );
  stdout.writeln('Run: flutter pub run flutter_launcher_icons');
}

String generateIconSvg() {
  return '''<?xml version="1.0" encoding="UTF-8"?>
<svg width="1024" height="1024" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bgGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#7B68EE;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#6750A4;stop-opacity:1" />
    </linearGradient>
    <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="8" stdDeviation="20" flood-color="#000" flood-opacity="0.15"/>
    </filter>
  </defs>
  
  <!-- Background with rounded corners -->
  <rect x="0" y="0" width="1024" height="1024" rx="224" ry="224" fill="url(#bgGradient)"/>
  
  <!-- Stash/Bookmark Icon -->
  <g transform="translate(512, 512)" filter="url(#shadow)">
    <!-- Main bookmark shape -->
    <path d="M-200,-320 
             L200,-320 
             C230,-320 256,-294 256,-264 
             L256,280 
             C256,300 244,318 224,324 
             C204,330 182,324 170,308 
             L0,100 
             L-170,308 
             C-182,324 -204,330 -224,324 
             C-244,318 -256,300 -256,280 
             L-256,-264 
             C-256,-294 -230,-320 -200,-320 Z" 
          fill="#FFFFFF"/>
    
    <!-- Inner fold detail -->
    <path d="M-140,-240 
             L140,-240 
             L140,-160 
             L-140,-160 Z" 
          fill="rgba(103, 80, 164, 0.2)" 
          rx="12"/>
    
    <!-- Arrow/stash indicator pointing down -->
    <path d="M-80,-60 
             L80,-60 
             L80,20 
             L120,20 
             L0,140 
             L-120,20 
             L-80,20 Z" 
          fill="rgba(103, 80, 164, 0.3)"/>
  </g>
</svg>''';
}

String generateForegroundSvg() {
  return '''<?xml version="1.0" encoding="UTF-8"?>
<svg width="1024" height="1024" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg">
  <!-- Adaptive icon foreground (transparent background) -->
  <g transform="translate(512, 512)">
    <!-- Main bookmark shape -->
    <path d="M-180,-280 
             L180,-280 
             C206,-280 228,-258 228,-232 
             L228,250 
             C228,268 218,284 200,290 
             C182,296 162,290 152,276 
             L0,90 
             L-152,276 
             C-162,290 -182,296 -200,290 
             C-218,284 -228,268 -228,250 
             L-228,-232 
             C-228,-258 -206,-280 -180,-280 Z" 
          fill="#FFFFFF"/>
    
    <!-- Inner fold detail -->
    <path d="M-120,-210 
             L120,-210 
             L120,-140 
             L-120,-140 Z" 
          fill="rgba(103, 80, 164, 0.25)" 
          rx="10"/>
    
    <!-- Arrow/stash indicator -->
    <path d="M-70,-50 
             L70,-50 
             L70,20 
             L100,20 
             L0,120 
             L-100,20 
             L-70,20 Z" 
          fill="rgba(103, 80, 164, 0.35)"/>
  </g>
</svg>''';
}

String generateMonochromeSvg() {
  return '''<?xml version="1.0" encoding="UTF-8"?>
<svg width="1024" height="1024" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg">
  <!-- Monochrome version for notifications etc -->
  <g transform="translate(512, 512)">
    <!-- Main bookmark shape -->
    <path d="M-200,-320 
             L200,-320 
             C230,-320 256,-294 256,-264 
             L256,280 
             C256,300 244,318 224,324 
             C204,330 182,324 170,308 
             L0,100 
             L-170,308 
             C-182,324 -204,330 -224,324 
             C-244,318 -256,300 -256,280 
             L-256,-264 
             C-256,-294 -230,-320 -200,-320 Z" 
          fill="#FFFFFF"/>
  </g>
</svg>''';
}
