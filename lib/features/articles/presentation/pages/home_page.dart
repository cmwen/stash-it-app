import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

/// Home page showing the list of saved articles.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(articleFilterProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final isSearchActive = searchQuery.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? null : const Text('Stash It'),
        titleSpacing: _isSearching ? 0 : null,
        leading: _isSearching
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  ref.read(searchQueryProvider.notifier).state = '';
                  setState(() => _isSearching = false);
                },
              )
            : null,
        actions: [
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => setState(() => _isSearching = true),
              tooltip: 'Search',
            ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) => _handleMenuAction(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'export',
                child: ListTile(
                  leading: Icon(Icons.download),
                  title: Text('Export Data'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
        bottom: _isSearching
            ? PreferredSize(
                preferredSize: const Size.fromHeight(64),
                child: _buildSearchBar(),
              )
            : PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: _buildFilterTabs(filter),
              ),
      ),
      body: isSearchActive
          ? SearchResultsView(
              onArticleTap: (id) => context.push('/article/$id'),
            )
          : _buildArticleList(filter),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUrlSheet(context, ref),
        tooltip: 'Save article',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search articles...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: ref.watch(searchQueryProvider).isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    ref.read(searchQueryProvider.notifier).state = '';
                  },
                )
              : null,
          filled: true,
          fillColor:
              Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(128),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
        onChanged: (query) {
          ref.read(searchQueryProvider.notifier).state = query;
        },
      ),
    );
  }

  Widget _buildFilterTabs(ArticleFilter currentFilter) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          _FilterChip(
            label: 'All',
            icon: Icons.list,
            isSelected: currentFilter == ArticleFilter.all,
            onSelected: () => ref.read(articleFilterProvider.notifier).state =
                ArticleFilter.all,
          ),
          const SizedBox(width: AppSpacing.sm),
          _FilterChip(
            label: 'Favorites',
            icon: Icons.star,
            isSelected: currentFilter == ArticleFilter.favorites,
            onSelected: () => ref.read(articleFilterProvider.notifier).state =
                ArticleFilter.favorites,
          ),
          const SizedBox(width: AppSpacing.sm),
          _FilterChip(
            label: 'Archived',
            icon: Icons.archive,
            isSelected: currentFilter == ArticleFilter.archived,
            onSelected: () => ref.read(articleFilterProvider.notifier).state =
                ArticleFilter.archived,
          ),
        ],
      ),
    );
  }

  Widget _buildArticleList(ArticleFilter filter) {
    final articlesAsync = ref.watch(articlesProvider);

    return articlesAsync.when(
      data: (articles) {
        if (articles.isEmpty) {
          return _buildEmptyState(filter);
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(articlesProvider);
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(
              top: AppSpacing.sm,
              bottom: 88,
            ),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ArticleCard(
                article: article,
                onTap: () => context.push('/article/${article.id}'),
                onDelete: () => _deleteArticle(context, ref, article.id),
                onArchive: () => _archiveArticle(context, ref, article),
                onFavorite: () => _toggleFavorite(ref, article.id),
                onTagTap: () => showTagManagementSheet(
                  context,
                  articleId: article.id,
                  currentTags: article.tags,
                ),
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
    );
  }

  Widget _buildEmptyState(ArticleFilter filter) {
    switch (filter) {
      case ArticleFilter.favorites:
        return const EmptyState(
          icon: Icons.star_outline,
          title: 'No favorites yet',
          description:
              'Tap the star icon on any article to add it to your favorites.',
        );
      case ArticleFilter.archived:
        return const EmptyState(
          icon: Icons.archive_outlined,
          title: 'No archived articles',
          description:
              'Swipe right on any article to archive it for later.',
        );
      case ArticleFilter.all:
        return EmptyState(
          icon: Icons.bookmark_border,
          title: 'No articles yet',
          description:
              'Save articles from any app using the share button, or tap the button below to add a URL.',
          actionLabel: 'Save Your First Article',
          onAction: () => _showAddUrlSheet(context, ref),
        );
    }
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'export':
        _exportData(context, ref);
        break;
      case 'settings':
        context.push('/settings');
        break;
    }
  }

  Future<void> _exportData(BuildContext context, WidgetRef ref) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: AppSpacing.sm),
              Text('Exporting data...'),
            ],
          ),
          duration: Duration(seconds: 30),
        ),
      );

      final notifier = ref.read(articleNotifierProvider.notifier);
      final jsonData = await notifier.exportToJson();

      final directory = await getTemporaryDirectory();
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final file = File('${directory.path}/stash_it_export_$timestamp.json');
      await file.writeAsString(jsonData);

      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        showModalBottomSheet(
          context: context,
          builder: (context) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Export Complete',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ListTile(
                    leading: const Icon(Icons.share),
                    title: const Text('Share File'),
                    subtitle: const Text('Send to another app or save'),
                    onTap: () async {
                      Navigator.pop(context);
                      await Share.shareXFiles(
                        [XFile(file.path)],
                        subject: 'Stash It Export',
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.copy),
                    title: const Text('Copy to Clipboard'),
                    subtitle: const Text('Copy JSON data'),
                    onTap: () async {
                      Navigator.pop(context);
                      await Clipboard.setData(ClipboardData(text: jsonData));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copied to clipboard')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: AppColors.error),
                const SizedBox(width: AppSpacing.sm),
                Text('Export failed: $e'),
              ],
            ),
          ),
        );
      }
    }
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Article deleted'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
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

  void _archiveArticle(BuildContext context, WidgetRef ref, article) {
    final notifier = ref.read(articleNotifierProvider.notifier);
    final isArchived = article.isArchived;

    notifier.toggleArchive(article.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isArchived ? 'Article unarchived' : 'Article archived'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () => notifier.toggleArchive(article.id),
        ),
        duration: AppDurations.snackbarDuration,
      ),
    );
  }

  void _toggleFavorite(WidgetRef ref, String id) {
    ref.read(articleNotifierProvider.notifier).toggleFavorite(id);
  }
}

/// Filter chip widget for filter tabs.
class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onSelected;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
    );
  }
}
