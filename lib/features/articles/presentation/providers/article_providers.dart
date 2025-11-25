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

/// Provider for the list of articles.
final articlesProvider = StreamProvider.autoDispose<List<Article>>((ref) {
  final repository = ref.watch(articleRepositoryProvider);
  return repository.watchAllArticles(isArchived: false);
});

/// Provider for a single article by ID.
final articleProvider = FutureProvider.autoDispose.family<Article?, String>((ref, id) async {
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
}

/// Provider for article operations.
final articleNotifierProvider = NotifierProvider<ArticleNotifier, AsyncValue<void>>(
  ArticleNotifier.new,
);
