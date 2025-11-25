/// Design tokens for animation durations.
abstract class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  static const Duration snackbarDuration = Duration(seconds: 4);
  static const Duration undoWindow = Duration(seconds: 5);
  static const Duration debounceSearch = Duration(milliseconds: 300);
}
