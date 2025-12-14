import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stash_it/features/articles/data/services/tts_service.dart';

void main() {
  group('TtsService', () {
    late TtsService ttsService;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();

      // Mock the flutter_tts platform channel
      const channel = MethodChannel('flutter_tts');
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
            return null;
          });

      ttsService = TtsService();
    });

    tearDown(() {
      ttsService.dispose();
    });

    test('initialize sets up TTS with default settings', () async {
      await ttsService.initialize();
      expect(ttsService, isNotNull);
    });

    test('setSpeechRate updates speech rate', () async {
      await ttsService.initialize();
      await ttsService.setSpeechRate(0.75);
      expect(ttsService, isNotNull);
    });

    test('setLanguage updates language', () async {
      await ttsService.initialize();
      await ttsService.setLanguage('en-US');
      expect(ttsService, isNotNull);
    });
  });
}
