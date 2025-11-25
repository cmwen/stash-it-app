import '../entities/article.dart';

/// Sort order for article lists.
enum SortOrder { savedAtDesc, savedAtAsc, titleAsc, titleDesc }

/// Repository interface for article operations.
abstract class ArticleRepository {
  // CRUD
  Future<Article> saveArticle(String url);
  Future<Article?> getArticle(String id);
  Future<List<Article>> getAllArticles({
    SortOrder sort = SortOrder.savedAtDesc,
    bool? isArchived,
    bool? isFavorite,
    List<String>? tags,
  });
  Future<void> updateArticle(Article article);
  Future<void> deleteArticle(String id);

  // Bulk operations
  Future<void> deleteMultiple(List<String> ids);

  // Status updates
  Future<void> markAsRead(String id);
  Future<void> markAsUnread(String id);
  Future<void> toggleFavorite(String id);
  Future<void> toggleArchive(String id);

  // Search
  Future<List<Article>> searchArticles(String query);

  // Stream for reactive updates
  Stream<List<Article>> watchAllArticles({
    SortOrder sort = SortOrder.savedAtDesc,
    bool? isArchived,
  });

  // Retry failed article
  Future<Article> retryFetchContent(String id);

  // Update scroll position
  Future<void> updateScrollPosition(String id, double position);
}
