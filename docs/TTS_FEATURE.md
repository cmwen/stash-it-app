# Text-to-Speech (TTS) Feature

## Overview

The Text-to-Speech feature allows users to listen to their saved articles using Android's built-in TTS engine. This is perfect for consuming content while multitasking, commuting, or when you prefer audio over reading.

## Features

- **Play/Pause**: Start and pause audio playback
- **Stop**: Stop playback and reset to the beginning
- **Skip Forward/Backward**: Jump 10 seconds forward or backward
- **Speed Control**: Adjust playback speed from 0.5x to 2.0x (0.25 increments)
- **Progress Tracking**: Visual progress bar showing current position
- **Word Highlighting**: See the current word being spoken
- **Automatic HTML Parsing**: Extracts clean text from HTML article content

## User Guide

### Accessing TTS

1. Open any saved article in the reader view
2. Tap the **microphone icon** (🎙️) in the top app bar
3. The TTS player will appear as a bottom sheet

### Controls

#### Play/Pause Button (Center, Large)
- **Play** (▶️): Start reading the article from the beginning or resume from current position
- **Pause** (⏸️): Pause playback at current position

#### Skip Buttons
- **Rewind 10s** (⏪): Skip backward approximately 10 seconds
- **Forward 10s** (⏩): Skip forward approximately 10 seconds

#### Stop Button
- **Stop** (⏹️): Stop playback and reset to beginning

#### Speed Control
- **Decrease** (➖): Slow down speech rate by 0.25x
- **Increase** (➕): Speed up speech rate by 0.25x
- **Display**: Shows current speed (e.g., "1.0x", "1.5x", "2.0x")

### Speed Settings

| Display | Internal Rate | Description |
|---------|--------------|-------------|
| 0.5x    | 0.25         | Very slow   |
| 1.0x    | 0.50         | Normal      |
| 1.5x    | 0.75         | Fast        |
| 2.0x    | 1.00         | Very fast   |

## Technical Architecture

### Components

#### 1. TtsService (`lib/features/articles/data/services/tts_service.dart`)
- Wraps `flutter_tts` package
- Manages TTS engine initialization and configuration
- Provides methods for speak, pause, stop, and rate control
- Handles callbacks for completion, progress, and errors

#### 2. TtsState (`lib/features/articles/domain/entities/tts_state.dart`)
- Immutable state class using Equatable
- Tracks playback state, position, speed, and current word
- Provides computed properties (progress, isPlaying, etc.)

#### 3. TtsNotifier (`lib/features/articles/presentation/providers/tts_provider.dart`)
- StateNotifier managing TTS state
- Extracts plain text from HTML content
- Handles playback control logic
- Manages seek operations

#### 4. TtsPlayer Widget (`lib/features/articles/presentation/widgets/tts_player.dart`)
- Bottom sheet UI with Material 3 design
- Displays progress bar and controls
- Auto-initializes TTS on first render
- Responsive to state changes

### State Management

Uses Riverpod with code generation:

```dart
@riverpod
class ArticleTts extends _$ArticleTts {
  @override
  TtsState build(String articleId) {
    return const TtsState();
  }
  // ... control methods
}
```

### HTML to Text Conversion

The TTS service automatically extracts clean text from HTML:

1. Parse HTML using `html` package
2. Extract text content from DOM
3. Clean whitespace and normalize line breaks
4. Remove empty lines
5. Join into single text string for TTS

## Implementation Details

### Dependencies

- **flutter_tts**: ^4.2.0 - Core TTS functionality
- **html**: ^0.15.5 - HTML parsing (already used)
- **riverpod_annotation**: ^3.0.3 - State management (already used)

### Platform Support

- **Android**: ✅ Full support using Android TTS engine
- **iOS**: ❌ Not supported (app is Android-only)

### Limitations

1. **Approximate Seeking**: Skip forward/backward uses character count approximation (150 chars ≈ 10 seconds)
2. **No Resume After Stop**: flutter_tts doesn't support true resume, so we re-speak from position
3. **Single Language**: Currently set to English (en-US)
4. **No Background Playback**: TTS stops when app is backgrounded (Android system behavior)

## Testing

### Unit Tests

- **TtsService**: Basic initialization and method calls
- **TtsState**: State logic, progress calculation, equality
- **TtsPlayer Widget**: UI rendering, state transitions

Run tests:
```bash
flutter test test/features/articles/data/services/tts_service_test.dart
flutter test test/features/articles/domain/entities/tts_state_test.dart
flutter test test/features/articles/presentation/widgets/tts_player_test.dart
```

## Future Enhancements

### Potential Features
- [ ] Background playback with MediaSession
- [ ] Save/restore playback position per article
- [ ] Voice selection (male/female, accents)
- [ ] Multi-language support with auto-detection
- [ ] Pitch control
- [ ] Sleep timer
- [ ] Download as audio file
- [ ] Highlight current sentence in reader view
- [ ] Custom skip intervals (5s, 15s, 30s)

### Known Issues
- Progress tracking is approximate due to TTS callback limitations
- Skip operations may not be precise
- Some HTML elements (code blocks, tables) may not read well

## Code Examples

### Using TTS in Code

```dart
// Get TTS notifier
final ttsNotifier = ref.read(articleTtsProvider(articleId).notifier);

// Initialize with article content
await ttsNotifier.initialize(article.content);

// Control playback
await ttsNotifier.play();
await ttsNotifier.pause();
await ttsNotifier.stop();

// Adjust speed
await ttsNotifier.setSpeechRate(0.75); // 1.5x display speed

// Skip
await ttsNotifier.skipForward();
await ttsNotifier.skipBackward();
```

### Watching TTS State

```dart
final ttsState = ref.watch(articleTtsProvider(articleId));

if (ttsState.isPlaying) {
  // Show pause button
}

if (ttsState.progress > 0.5) {
  // Over 50% complete
}
```

## Troubleshooting

### TTS Not Working
1. Ensure device has TTS engine installed (usually pre-installed on Android)
2. Check device volume is not muted
3. Try restarting the app
4. Check Android TTS settings: Settings → Accessibility → Text-to-speech

### Poor Quality Audio
1. Install a better TTS engine from Play Store (e.g., Google Text-to-Speech)
2. Adjust speed to slower rate
3. Check article content isn't corrupted

### Skipping Issues
- Skip operations are approximate; try using play/pause for precise control

## License

Part of Stash It app - see root LICENSE file.
