import 'package:flutter_test/flutter_test.dart';
import 'package:stash_it/features/articles/domain/entities/tts_state.dart';

void main() {
  group('TtsState', () {
    test('initial state has correct defaults', () {
      const state = TtsState();
      expect(state.playbackState, TtsPlaybackState.stopped);
      expect(state.currentPosition, 0);
      expect(state.speechRate, 0.5);
    });

    test('progress calculation returns correct percentage', () {
      const state = TtsState(currentPosition: 50, totalLength: 100);
      expect(state.progress, 0.5);
    });

    test('isPlaying returns true when playing', () {
      const state = TtsState(playbackState: TtsPlaybackState.playing);
      expect(state.isPlaying, true);
      expect(state.isPaused, false);
    });

    test('copyWith creates new instance with updated values', () {
      const original = TtsState(speechRate: 0.5);
      final updated = original.copyWith(speechRate: 0.75);
      expect(updated.speechRate, 0.75);
    });
  });
}
