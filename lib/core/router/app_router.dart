import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/articles/presentation/pages/pages.dart';
import '../../features/settings/settings.dart';

/// App router configuration using go_router.
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/article/:id',
      name: 'reader',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ReaderPage(articleId: id);
      },
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Page Not Found')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64),
          const SizedBox(height: 16),
          Text('Page not found: ${state.uri.path}'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.go('/'),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),
);
