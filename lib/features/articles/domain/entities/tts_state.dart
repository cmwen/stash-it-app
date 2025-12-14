import 'package:equatable/equatable.dart';

/// Playback state for TTS.
enum TtsPlaybackState { stopped, playing, paused }

/// TTS state for an article.
class TtsState extends Equatable {
  /// Current playback state
  final TtsPlaybackState playbackState;

  /// Current speaking position in the text (character index)
  final int currentPosition;

  /// Total text length
  final int totalLength;

  /// Speech rate (0.25 to 2.0, where 0.5 is normal)
  final double speechRate;

  /// Currently speaking word
  final String? currentWord;

  /// Error message if any
  final String? error;

  const TtsState({
    this.playbackState = TtsPlaybackState.stopped,
    this.currentPosition = 0,
    this.totalLength = 0,
    this.speechRate = 0.5,
    this.currentWord,
    this.error,
  });

  /// Progress as percentage (0.0 to 1.0).
  double get progress {
    if (totalLength == 0) return 0.0;
    return (currentPosition / totalLength).clamp(0.0, 1.0);
  }

  /// Whether TTS is currently playing.
  bool get isPlaying => playbackState == TtsPlaybackState.playing;

  /// Whether TTS is paused.
  bool get isPaused => playbackState == TtsPlaybackState.paused;

  /// Whether TTS is stopped.
  bool get isStopped => playbackState == TtsPlaybackState.stopped;

  TtsState copyWith({
    TtsPlaybackState? playbackState,
    int? currentPosition,
    int? totalLength,
    double? speechRate,
    String? currentWord,
    String? error,
  }) {
    return TtsState(
      playbackState: playbackState ?? this.playbackState,
      currentPosition: currentPosition ?? this.currentPosition,
      totalLength: totalLength ?? this.totalLength,
      speechRate: speechRate ?? this.speechRate,
      currentWord: currentWord ?? this.currentWord,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    playbackState,
    currentPosition,
    totalLength,
    speechRate,
    currentWord,
    error,
  ];
}
