import 'package:flutter_tts/flutter_tts.dart';

/// Service for Text-to-Speech functionality.
class TtsService {
  final FlutterTts _tts = FlutterTts();
  bool _isInitialized = false;

  /// Initialize TTS with default settings.
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.5); // Default speed (0.5 = normal)
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);

    // Android-specific: Use high-quality engine
    await _tts.setSharedInstance(true);

    _isInitialized = true;
  }

  /// Speak the given text.
  Future<void> speak(String text) async {
    await initialize();
    await _tts.speak(text);
  }

  /// Pause speaking.
  Future<void> pause() async {
    await _tts.pause();
  }

  /// Resume speaking.
  Future<void> resume() async {
    // Flutter TTS doesn't have resume, so we continue
    await _tts.speak('');
  }

  /// Stop speaking and reset.
  Future<void> stop() async {
    await _tts.stop();
  }

  /// Set speaking rate (0.0 to 1.0, where 0.5 is normal).
  Future<void> setSpeechRate(double rate) async {
    await _tts.setSpeechRate(rate);
  }

  /// Set language.
  Future<void> setLanguage(String language) async {
    await _tts.setLanguage(language);
  }

  /// Get available languages.
  Future<List<dynamic>> getLanguages() async {
    return await _tts.getLanguages;
  }

  /// Get available voices.
  Future<List<dynamic>> getVoices() async {
    return await _tts.getVoices;
  }

  /// Set voice by name.
  Future<void> setVoice(Map<String, String> voice) async {
    await _tts.setVoice(voice);
  }

  /// Set completion handler.
  void setCompletionHandler(Function handler) {
    _tts.setCompletionHandler(() => handler());
  }

  /// Set progress handler.
  void setProgressHandler(
    Function(String text, int start, int end, String word) handler,
  ) {
    _tts.setProgressHandler((text, start, end, word) {
      handler(text, start, end, word);
    });
  }

  /// Set error handler.
  void setErrorHandler(Function(String message) handler) {
    _tts.setErrorHandler((message) => handler(message));
  }



  /// Dispose resources.
  void dispose() {
    _tts.stop();
  }
}
