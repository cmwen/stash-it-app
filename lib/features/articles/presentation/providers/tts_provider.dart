import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/services/tts_service.dart';
import '../../domain/entities/tts_state.dart';

part 'tts_provider.g.dart';

final ttsServiceProvider = Provider<TtsService>((ref) {
  final service = TtsService();
  ref.onDispose(() => service.dispose());
  return service;
});

@riverpod
class ArticleTts extends _$ArticleTts {
  TtsService? _ttsService;
  String _fullText = '';

  @override
  TtsState build(String articleId) {
    _ttsService = ref.read(ttsServiceProvider);
    _setupHandlers();
    ref.onDispose(() {
      _ttsService?.stop();
    });
    return const TtsState();
  }

  void _setupHandlers() {
    _ttsService?.setCompletionHandler(() {
      state = state.copyWith(
        playbackState: TtsPlaybackState.stopped,
        currentPosition: 0,
      );
    });

    _ttsService?.setProgressHandler((text, start, end, word) {
      state = state.copyWith(currentPosition: end, currentWord: word);
    });

    _ttsService?.setErrorHandler((message) {
      state = state.copyWith(
        playbackState: TtsPlaybackState.stopped,
        error: message,
      );
    });
  }

  Future<void> initialize(String htmlContent) async {
    await _ttsService?.initialize();
    _fullText = _extractTextFromHtml(htmlContent);
    state = state.copyWith(
      totalLength: _fullText.length,
      currentPosition: 0,
      playbackState: TtsPlaybackState.stopped,
    );
  }

  String _extractTextFromHtml(String htmlContent) {
    if (htmlContent.isEmpty) return '';

    final document = html_parser.parse(htmlContent);
    final text = document.body?.text ?? '';

    return text
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .join(' ');
  }

  Future<void> play() async {
    if (_fullText.isEmpty) return;

    if (state.isPaused) {
      final remainingText = _fullText.substring(state.currentPosition);
      await _ttsService?.speak(remainingText);
    } else {
      await _ttsService?.speak(_fullText);
    }

    state = state.copyWith(playbackState: TtsPlaybackState.playing);
  }

  Future<void> pause() async {
    await _ttsService?.pause();
    state = state.copyWith(playbackState: TtsPlaybackState.paused);
  }

  Future<void> stop() async {
    await _ttsService?.stop();
    state = state.copyWith(
      playbackState: TtsPlaybackState.stopped,
      currentPosition: 0,
    );
  }

  Future<void> skipBackward() async {
    final newPosition = (state.currentPosition - 150).clamp(
      0,
      _fullText.length,
    );
    await _seekToPosition(newPosition);
  }

  Future<void> skipForward() async {
    final newPosition = (state.currentPosition + 150).clamp(
      0,
      _fullText.length,
    );
    await _seekToPosition(newPosition);
  }

  Future<void> _seekToPosition(int position) async {
    final wasPlaying = state.isPlaying;
    await _ttsService?.stop();

    state = state.copyWith(currentPosition: position);

    if (wasPlaying && position < _fullText.length) {
      final remainingText = _fullText.substring(position);
      await _ttsService?.speak(remainingText);
      state = state.copyWith(playbackState: TtsPlaybackState.playing);
    }
  }

  Future<void> setSpeechRate(double rate) async {
    final clampedRate = rate.clamp(0.25, 2.0);
    await _ttsService?.setSpeechRate(clampedRate);
    state = state.copyWith(speechRate: clampedRate);
  }

  Future<void> increaseSpeed() async {
    final newRate = (state.speechRate + 0.25).clamp(0.25, 2.0);
    await setSpeechRate(newRate);
  }

  Future<void> decreaseSpeed() async {
    final newRate = (state.speechRate - 0.25).clamp(0.25, 2.0);
    await setSpeechRate(newRate);
  }
}
