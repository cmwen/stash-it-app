import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stash_it/features/articles/domain/entities/tts_state.dart';
import 'package:stash_it/features/articles/presentation/providers/tts_provider.dart';
import 'package:stash_it/features/articles/presentation/widgets/tts_player.dart';

void main() {
  group('TtsPlayer', () {
    const testArticleId = 'test-article-123';
    const testContent = '<p>Test content</p>';

    Widget createTestWidget({TtsState? ttsState}) {
      return ProviderScope(
        overrides: [
          if (ttsState != null)
            articleTtsProvider(testArticleId).overrideWith((ref) => ttsState),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: TtsPlayer(articleId: testArticleId, articleContent: testContent),
          ),
        ),
      );
    }

    testWidgets('renders with initial stopped state', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();
      expect(find.byType(TtsPlayer), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });

    testWidgets('shows pause icon when playing', (tester) async {
      const playingState = TtsState(playbackState: TtsPlaybackState.playing);
      await tester.pumpWidget(createTestWidget(ttsState: playingState));
      await tester.pump();
      expect(find.byIcon(Icons.pause), findsOneWidget);
    });
  });
}
