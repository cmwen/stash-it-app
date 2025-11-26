import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/router/router.dart';
import 'core/sharing/sharing.dart';
import 'core/theme/theme.dart';
import 'features/articles/presentation/providers/providers.dart';
import 'features/settings/presentation/providers/providers.dart';

/// Global key for the scaffold messenger to show snackbars from anywhere.
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences before running app
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const StashItApp(),
    ),
  );
}

/// The root widget of the Stash It application.
class StashItApp extends ConsumerStatefulWidget {
  const StashItApp({super.key});

  @override
  ConsumerState<StashItApp> createState() => _StashItAppState();
}

class _StashItAppState extends ConsumerState<StashItApp> {
  late final SharingIntentHandler _sharingHandler;

  @override
  void initState() {
    super.initState();
    _sharingHandler = ref.read(sharingIntentHandlerProvider);
    _initSharingIntent();
  }

  Future<void> _initSharingIntent() async {
    await _sharingHandler.initialize(
      onSharedText: (url) => _handleSharedUrl(url),
    );
  }

  Future<void> _handleSharedUrl(String url) async {
    // Show a loading indicator
    scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 12),
            Text('Saving article...'),
          ],
        ),
        duration: Duration(seconds: 30),
      ),
    );

    try {
      final notifier = ref.read(articleNotifierProvider.notifier);
      final article = await notifier.saveArticle(url);

      scaffoldMessengerKey.currentState?.hideCurrentSnackBar();

      if (article != null) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: AppColors.success),
                SizedBox(width: 12),
                Expanded(child: Text('Article saved!')),
              ],
            ),
            action: SnackBarAction(
              label: 'OPEN',
              onPressed: () {
                router.push('/article/${article.id}');
              },
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      } else {
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.error, color: AppColors.error),
                SizedBox(width: 12),
                Text('Failed to save article'),
              ],
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: AppColors.error),
              const SizedBox(width: 12),
              Expanded(child: Text('Error: $e')),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    _sharingHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Stash It',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
