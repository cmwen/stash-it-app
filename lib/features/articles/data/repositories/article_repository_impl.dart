import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/article.dart';
import '../../domain/repositories/article_repository.dart';
import '../datasources/local/database.dart';
import '../services/content_extractor.dart';
import '../services/web_fetcher.dart';

/// Implementation of ArticleRepository using local database.
class ArticleRepositoryImpl implements ArticleRepository {
  final AppDatabase _database;
  final WebFetcher _webFetcher;
  final ContentExtractor _contentExtractor;
  final Uuid _uuid;

  ArticleRepositoryImpl({
    required AppDatabase database,
    WebFetcher? webFetcher,
    ContentExtractor? contentExtractor,
    Uuid? uuid,
  }) : _database = database,
       _webFetcher = webFetcher ?? WebFetcher(),
       _contentExtractor = contentExtractor ?? ContentExtractor(),
       _uuid = uuid ?? const Uuid();

  @override
  Future<Article> saveArticle(String url) async {
    // Check for existing article with same URL
    final existing = await _database.getArticleByUrl(url);
    if (existing != null) {
      return _mapToEntity(existing);
    }

    // Create new article with pending status
    final id = _uuid.v4();
    final now = DateTime.now();

    // Extract domain for initial title
    String initialTitle;
    try {
      final uri = Uri.parse(url);
      initialTitle = uri.host;
    } catch (_) {
      initialTitle = url;
    }

    // Insert pending article
    await _database.insertArticle(
      ArticlesTableCompanion(
        id: Value(id),
        url: Value(url),
        title: Value(initialTitle),
        content: const Value(''),
        savedAt: Value(now),
        wordCount: const Value(0),
        status: const Value('pending'),
        tags: const Value('[]'),
      ),
    );

    // Try to fetch and extract content
    try {
      await _database.updateStatus(id, 'fetching');

      final html = await _webFetcher.fetchHtml(url);
      final extracted = _contentExtractor.extract(html, url);

      await _database.updateArticle(
        ArticlesTableCompanion(
          id: Value(id),
          url: Value(url),
          title: Value(extracted.title),
          author: Value(extracted.author),
          excerpt: Value(extracted.excerpt),
          content: Value(extracted.content),
          imageUrl: Value(extracted.imageUrl),
          siteName: Value(extracted.siteName),
          savedAt: Value(now),
          publishedAt: Value(extracted.publishedAt),
          wordCount: Value(extracted.wordCount),
          isRead: const Value(false),
          isArchived: const Value(false),
          isFavorite: const Value(false),
          tags: const Value('[]'),
          status: const Value('ready'),
          scrollPosition: const Value(null),
          lastSyncedAt: const Value(null),
        ),
      );
    } catch (e) {
      await _database.updateStatus(id, 'failed');
    }

    final article = await _database.getArticleById(id);
    return _mapToEntity(article!);
  }

  @override
  Future<Article?> getArticle(String id) async {
    final data = await _database.getArticleById(id);
    return data != null ? _mapToEntity(data) : null;
  }

  @override
  Future<List<Article>> getAllArticles({
    SortOrder sort = SortOrder.savedAtDesc,
    bool? isArchived,
    bool? isFavorite,
    List<String>? tags,
  }) async {
    final (orderBy, descending) = _getSortParams(sort);
    final data = await _database.getAllArticles(
      orderBy: orderBy,
      descending: descending,
      isArchived: isArchived,
    );

    var articles = data.map(_mapToEntity).toList();

    // Filter by favorite if specified
    if (isFavorite != null) {
      articles = articles.where((a) => a.isFavorite == isFavorite).toList();
    }

    // Filter by tags if specified
    if (tags != null && tags.isNotEmpty) {
      articles = articles
          .where((a) => tags.any((tag) => a.tags.contains(tag)))
          .toList();
    }

    return articles;
  }

  @override
  Future<void> updateArticle(Article article) async {
    await _database.updateArticle(_mapToCompanion(article));
  }

  @override
  Future<List<Article>> getArticlesByTag(String tag) async {
    final articles = await _database.getArticlesByTag(tag);
    return articles.map((a) => Article(
      id: a.id,
      url: a.url,
      title: a.title,
      content: a.content,
      excerpt: a.excerpt,
      imageUrl: a.imageUrl,
      isRead: a.isRead,
      isFavorite: a.isFavorite,
      createdAt: a.createdAt,
      readAt: a.readAt,
      tags: a.tags?.split(',').where((t) => t.isNotEmpty).toList() ?? [],
    )).toList();
  }

  @override
  Future<void> softDeleteArticle(int id) async {
    await _database.softDeleteArticle(id);
  }

  @override
  Future<void> restoreArticle(int id) async {
    await _database.restoreArticle(id);
  }

  @override
  Future<void> deleteArticle(String id) async {
    await _database.deleteArticleById(id);
  }

  @override
  Future<void> deleteMultiple(List<String> ids) async {
    for (final id in ids) {
      await _database.deleteArticleById(id);
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    await _database.markAsRead(id);
  }

  @override
  Future<void> markAsUnread(String id) async {
    await _database.markAsUnread(id);
  }

  @override
  Future<void> toggleFavorite(String id) async {
    await _database.toggleFavorite(id);
  }

  @override
  Future<void> toggleArchive(String id) async {
    await _database.toggleArchive(id);
  }

  @override
  Future<List<Article>> searchArticles(String query) async {
    final data = await _database.searchArticles(query);
    return data.map(_mapToEntity).toList();
  }

  @override
  Stream<List<Article>> watchAllArticles({
    SortOrder sort = SortOrder.savedAtDesc,
    bool? isArchived,
  }) {
    final (orderBy, descending) = _getSortParams(sort);
    return _database
        .watchAllArticles(
          orderBy: orderBy,
          descending: descending,
          isArchived: isArchived,
        )
        .map((list) => list.map(_mapToEntity).toList());
  }

  @override
  Future<Article> retryFetchContent(String id) async {
    final article = await _database.getArticleById(id);
    if (article == null) {
      throw Exception('Article not found');
    }

    await _database.updateStatus(id, 'fetching');

    try {
      final html = await _webFetcher.fetchHtml(article.url);
      final extracted = _contentExtractor.extract(html, article.url);

      await _database.updateArticle(
        ArticlesTableCompanion(
          id: Value(article.id),
          url: Value(article.url),
          title: Value(extracted.title),
          author: Value(extracted.author),
          excerpt: Value(extracted.excerpt),
          content: Value(extracted.content),
          imageUrl: Value(extracted.imageUrl),
          siteName: Value(extracted.siteName),
          savedAt: Value(article.savedAt),
          publishedAt: Value(extracted.publishedAt),
          wordCount: Value(extracted.wordCount),
          isRead: Value(article.isRead),
          isArchived: Value(article.isArchived),
          isFavorite: Value(article.isFavorite),
          tags: Value(article.tags),
          status: const Value('ready'),
          scrollPosition: Value(article.scrollPosition),
          lastSyncedAt: Value(article.lastSyncedAt),
        ),
      );
    } catch (e) {
      await _database.updateStatus(id, 'failed');
      rethrow;
    }

    final updated = await _database.getArticleById(id);
    return _mapToEntity(updated!);
  }

  @override
  Future<void> updateScrollPosition(String id, double position) async {
    await _database.updateScrollPosition(id, position);
  }

  // Helper methods

  (String, bool) _getSortParams(SortOrder sort) {
    return switch (sort) {
      SortOrder.savedAtDesc => ('savedAt', true),
      SortOrder.savedAtAsc => ('savedAt', false),
      SortOrder.titleAsc => ('title', false),
      SortOrder.titleDesc => ('title', true),
    };
  }

  Article _mapToEntity(ArticlesTableData data) {
    List<String> tags;
    try {
      tags = (jsonDecode(data.tags) as List).cast<String>();
    } catch (_) {
      tags = [];
    }

    return Article(
      id: data.id,
      url: data.url,
      title: data.title,
      author: data.author,
      excerpt: data.excerpt,
      content: data.content,
      imageUrl: data.imageUrl,
      siteName: data.siteName,
      savedAt: data.savedAt,
      publishedAt: data.publishedAt,
      wordCount: data.wordCount,
      isRead: data.isRead,
      isArchived: data.isArchived,
      isFavorite: data.isFavorite,
      tags: tags,
      status: _parseStatus(data.status),
      scrollPosition: data.scrollPosition,
      lastSyncedAt: data.lastSyncedAt,
    );
  }

  ArticleStatus _parseStatus(String status) {
    return switch (status) {
      'pending' => ArticleStatus.pending,
      'fetching' => ArticleStatus.fetching,
      'ready' => ArticleStatus.ready,
      'failed' => ArticleStatus.failed,
      _ => ArticleStatus.pending,
    };
  }

  ArticlesTableCompanion _mapToCompanion(Article article) {
    return ArticlesTableCompanion(
      id: Value(article.id),
      url: Value(article.url),
      title: Value(article.title),
      author: Value(article.author),
      excerpt: Value(article.excerpt),
      content: Value(article.content),
      imageUrl: Value(article.imageUrl),
      siteName: Value(article.siteName),
      savedAt: Value(article.savedAt),
      publishedAt: Value(article.publishedAt),
      wordCount: Value(article.wordCount),
      isRead: Value(article.isRead),
      isArchived: Value(article.isArchived),
      isFavorite: Value(article.isFavorite),
      tags: Value(jsonEncode(article.tags)),
      status: Value(article.status.name),
      scrollPosition: Value(article.scrollPosition),
      lastSyncedAt: Value(article.lastSyncedAt),
    );
  }
}
