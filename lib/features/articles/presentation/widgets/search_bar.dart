import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../providers/providers.dart';

/// Search bar widget for searching articles.
class ArticleSearchBar extends ConsumerStatefulWidget {
  const ArticleSearchBar({super.key});

  @override
  ConsumerState<ArticleSearchBar> createState() => _ArticleSearchBarState();
}

class _ArticleSearchBarState extends ConsumerState<ArticleSearchBar> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _isSearching = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    ref.read(searchQueryProvider.notifier).state = query;
  }

  void _clearSearch() {
    _controller.clear();
    ref.read(searchQueryProvider.notifier).state = '';
    setState(() => _isSearching = false);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: AppDurations.fast,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: _onSearchChanged,
        onTap: () => setState(() => _isSearching = true),
        decoration: InputDecoration(
          hintText: 'Search articles...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _isSearching || _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _clearSearch,
                )
              : null,
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest.withAlpha(128),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
        textInputAction: TextInputAction.search,
      ),
    );
  }
}

/// Search results view.
class SearchResultsView extends ConsumerWidget {
  final Function(String articleId) onArticleTap;

  const SearchResultsView({super.key, required this.onArticleTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);

    if (query.isEmpty) {
      return const SizedBox.shrink();
    }

    final resultsAsync = ref.watch(searchResultsProvider);
    final theme = Theme.of(context);

    return resultsAsync.when(
      data: (results) {
        if (results.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'No results for "$query"',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Try searching for something else',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: 88),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final article = results[index];
            return ListTile(
              leading: Icon(
                article.isArchived ? Icons.archive : Icons.article,
                color: theme.colorScheme.primary,
              ),
              title: Text(
                article.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                article.siteName ?? article.url,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: article.isFavorite
                  ? Icon(Icons.star, color: Colors.amber.shade600)
                  : null,
              onTap: () => onArticleTap(article.id),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text(
          'Search failed',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.error,
          ),
        ),
      ),
    );
  }
}
