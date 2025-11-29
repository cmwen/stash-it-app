import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local/database.dart';
import '../../data/repositories/article_repository_impl.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/article_repository.dart';

/// Provider for the database instance.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// Provider for the article repository.
final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ArticleRepositoryImpl(database: database);
});

/// Filter state for article list.
enum ArticleFilter { all, favorites, archived }

/// Provider for current filter selection.
final articleFilterProvider =
    NotifierProvider<ArticleFilterNotifier, ArticleFilter>(
      ArticleFilterNotifier.new,
    );

class ArticleFilterNotifier extends Notifier<ArticleFilter> {
  @override
  ArticleFilter build() => ArticleFilter.all;

  void setFilter(ArticleFilter filter) {
    state = filter;
  }
}

/// Provider for search query.
final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

/// Provider for the list of articles (filtered by current filter).
/// Soft delete an article (can be undone)
final softDeleteArticleProvider = FutureProvider.family<void, int>((
  ref,
  id,
) async {
  final repository = ref.read(articleRepositoryProvider);
  await repository.softDeleteArticle(id);
});

/// Restore a deleted article (undo delete)
final restoreArticleProvider = FutureProvider.family<void, int>((
  ref,
  id,
) async {
  final repository = ref.read(articleRepositoryProvider);
  await repository.restoreArticle(id);
});

/// Filter articles by tag
final articlesByTagProvider = FutureProvider.family<List<Article>, String>((
  ref,
  tag,
) async {
  final repository = ref.read(articleRepositoryProvider);
  return repository.getArticlesByTag(tag);
});

final articlesProvider = StreamProvider.autoDispose<List<Article>>((ref) {
  final repository = ref.watch(articleRepositoryProvider);
  final filter = ref.watch(articleFilterProvider);

  switch (filter) {
    case ArticleFilter.all:
      return repository.watchAllArticles(isArchived: false);
    case ArticleFilter.favorites:
      return repository
          .watchAllArticles(isArchived: false)
          .map((articles) => articles.where((a) => a.isFavorite).toList());
    case ArticleFilter.archived:
      return repository.watchAllArticles(isArchived: true);
  }
});

/// Provider for search results.
final searchResultsProvider = FutureProvider.autoDispose<List<Article>>((
  ref,
) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  final repository = ref.watch(articleRepositoryProvider);
  return repository.searchArticles(query);
});

/// Provider for all unique tags across articles.
final allTagsProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  final repository = ref.watch(articleRepositoryProvider);
  final articles = await repository.getAllArticles();
  final tags = <String>{};
  for (final article in articles) {
    tags.addAll(article.tags);
  }
  return tags.toList()..sort();
});

/// Provider for a single article by ID.
final articleProvider = FutureProvider.autoDispose.family<Article?, String>((
  ref,
  id,
) async {
  final repository = ref.watch(articleRepositoryProvider);
  return repository.getArticle(id);
});

/// Notifier for article operations.
class ArticleNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  ArticleRepository get _repository => ref.read(articleRepositoryProvider);

  Future<Article?> saveArticle(String url) async {
    state = const AsyncValue.loading();
    try {
      final article = await _repository.saveArticle(url);
      state = const AsyncValue.data(null);
      ref.invalidate(articlesProvider);
      return article;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> deleteArticle(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteArticle(id);
      state = const AsyncValue.data(null);
      ref.invalidate(articlesProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await _repository.markAsRead(id);
      ref.invalidate(articlesProvider);
      ref.invalidate(articleProvider(id));
    } catch (_) {
      // Silently fail for read status
    }
  }

  Future<void> markAsUnread(String id) async {
    try {
      await _repository.markAsUnread(id);
      ref.invalidate(articlesProvider);
      ref.invalidate(articleProvider(id));
    } catch (_) {
      // Silently fail for read status
    }
  }

  Future<void> toggleFavorite(String id) async {
    try {
      await _repository.toggleFavorite(id);
      ref.invalidate(articlesProvider);
      ref.invalidate(articleProvider(id));
    } catch (_) {}
  }

  Future<void> toggleArchive(String id) async {
    try {
      await _repository.toggleArchive(id);
      ref.invalidate(articlesProvider);
      ref.invalidate(articleProvider(id));
    } catch (_) {}
  }

  Future<void> retryFetch(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.retryFetchContent(id);
      state = const AsyncValue.data(null);
      ref.invalidate(articlesProvider);
      ref.invalidate(articleProvider(id));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateScrollPosition(String id, double position) async {
    try {
      await _repository.updateScrollPosition(id, position);
    } catch (_) {}
  }

  /// Add a tag to an article.
  Future<void> addTag(String id, String tag) async {
    try {
      final article = await _repository.getArticle(id);
      if (article != null && !article.tags.contains(tag)) {
        final updatedTags = [...article.tags, tag];
        await _repository.updateArticle(article.copyWith(tags: updatedTags));
        ref.invalidate(articlesProvider);
        ref.invalidate(articleProvider(id));
        ref.invalidate(allTagsProvider);
      }
    } catch (_) {}
  }

  /// Remove a tag from an article.
  Future<void> removeTag(String id, String tag) async {
    try {
      final article = await _repository.getArticle(id);
      if (article != null && article.tags.contains(tag)) {
        final updatedTags = article.tags.where((t) => t != tag).toList();
        await _repository.updateArticle(article.copyWith(tags: updatedTags));
        ref.invalidate(articlesProvider);
        ref.invalidate(articleProvider(id));
        ref.invalidate(allTagsProvider);
      }
    } catch (_) {}
  }

  /// Export all articles to JSON format.
  Future<String> exportToJson() async {
    final articles = await _repository.getAllArticles();
    final data = {
      'version': '1.5.0',
      'exportedAt': DateTime.now().toIso8601String(),
      'articleCount': articles.length,
      'articles': articles
          .map(
            (a) => {
              'id': a.id,
              'url': a.url,
              'title': a.title,
              'author': a.author,
              'excerpt': a.excerpt,
              'siteName': a.siteName,
              'savedAt': a.savedAt.toIso8601String(),
              'publishedAt': a.publishedAt?.toIso8601String(),
              'wordCount': a.wordCount,
              'isRead': a.isRead,
              'isArchived': a.isArchived,
              'isFavorite': a.isFavorite,
              'tags': a.tags,
            },
          )
          .toList(),
    };
    return const JsonEncoder.withIndent('  ').convert(data);
  }
}

/// Provider for article operations.
final articleNotifierProvider =
    NotifierProvider<ArticleNotifier, AsyncValue<void>>(ArticleNotifier.new);
