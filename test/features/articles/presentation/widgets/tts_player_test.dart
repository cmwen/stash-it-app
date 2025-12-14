import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stash_it/features/articles/presentation/widgets/tts_player.dart';

void main() {
  group('TtsPlayer', () {
    const testArticleId = 'test-article-123';
    const testContent = '<p>Test content</p>';

    Widget createTestWidget() {
      return ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TtsPlayer(
              articleId: testArticleId,
              articleContent: testContent,
            ),
          ),
        ),
      );
    }

    testWidgets('renders TtsPlayer widget', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      expect(find.byType(TtsPlayer), findsOneWidget);
    });
  });
}
