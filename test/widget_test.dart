// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stash_it/features/settings/presentation/providers/providers.dart';
import 'package:stash_it/main.dart';

void main() {
  testWidgets('App renders smoke test', (WidgetTester tester) async {
    // Set up mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // Build our app and trigger a frame with mocked SharedPreferences
    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const StashItApp(),
      ),
    );

    // Allow the first frame + small delay so the app can build without waiting
    // for asynchronous background work (avoids pumpAndSettle flakiness).
    await tester.pump(const Duration(milliseconds: 500));

    // Verify that the app title is displayed
    expect(find.text('Stash It'), findsOneWidget);
  });
}
