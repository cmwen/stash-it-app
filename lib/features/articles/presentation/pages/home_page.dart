import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

/// Home page showing the list of saved articles.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsync = ref.watch(articlesProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stash It'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: articlesAsync.when(
        data: (articles) {
          if (articles.isEmpty) {
            return EmptyState(
              icon: Icons.bookmark_border,
              title: 'No articles yet',
              description: 'Save articles from any app using the share button, or tap the button below to add a URL.',
              actionLabel: 'Save Your First Article',
              onAction: () => _showAddUrlSheet(context, ref),
            );
          }
          
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(articlesProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(
                top: AppSpacing.sm,
                bottom: 88, // Space for FAB
              ),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ArticleCard(
                  article: article,
                  onTap: () => context.push('/article/${article.id}'),
                  onDelete: () => _deleteArticle(context, ref, article.id),
                );
              },
            ),
          );
        },
        loading: () => const ArticleListSkeleton(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              FilledButton(
                onPressed: () => ref.invalidate(articlesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUrlSheet(context, ref),
        tooltip: 'Save article',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddUrlSheet(BuildContext context, WidgetRef ref) {
    showAddUrlSheet(
      context,
      onSave: (url) async {
        final notifier = ref.read(articleNotifierProvider.notifier);
        final article = await notifier.saveArticle(url);
        
        if (context.mounted) {
          if (article != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.check_circle, color: AppColors.success),
                    SizedBox(width: AppSpacing.sm),
                    Text('Article saved'),
                  ],
                ),
                action: SnackBarAction(
                  label: 'OPEN',
                  onPressed: () => context.push('/article/${article.id}'),
                ),
                duration: AppDurations.snackbarDuration,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.error, color: AppColors.error),
                    SizedBox(width: AppSpacing.sm),
                    Text('Failed to save article'),
                  ],
                ),
                action: SnackBarAction(
                  label: 'RETRY',
                  onPressed: () => _showAddUrlSheet(context, ref),
                ),
                duration: AppDurations.snackbarDuration,
              ),
            );
          }
        }
      },
    );
  }

  void _deleteArticle(BuildContext context, WidgetRef ref, String id) {
    final notifier = ref.read(articleNotifierProvider.notifier);
    
    // Show undo snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Article deleted'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            // The article is already deleted, we'd need to restore it
            // For now, just show a message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Undo not available'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
        duration: AppDurations.undoWindow,
      ),
    );
    
    notifier.deleteArticle(id);
  }
}
