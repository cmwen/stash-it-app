# Flutter specific ProGuard rules
# Keep Flutter wrapper classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep Drift database classes
-keep class drift.** { *; }
-keep class com.cmwen.stash_it.** { *; }

# Keep sqlite3 native libraries
-keep class org.sqlite.** { *; }
-keep class sqlite3.** { *; }

# Optimize but don't obfuscate for easier debugging
-dontobfuscate

# Remove logging in release builds
-assumenosideeffects class android.util.Log {
    public static int v(...);
    public static int d(...);
    public static int i(...);
}

# Keep annotations
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keepattributes Signature

# Keep generic type info for Riverpod
-keepattributes InnerClasses
-keep class **.R$* { *; }
