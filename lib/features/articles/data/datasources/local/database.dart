import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'articles_table.dart';

part 'database.g.dart';

/// Drift database for the Stash It app.
@DriftDatabase(tables: [ArticlesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'stash_it_db');
  }

  // Article CRUD operations

  Future<List<ArticlesTableData>> getAllArticles({
    String orderBy = 'savedAt',
    bool descending = true,
    bool? isArchived,
  }) async {
    final query = select(articlesTable);

    if (isArchived != null) {
      query.where((t) => t.isArchived.equals(isArchived));
    }

    query.orderBy([
      (t) {
        final column = switch (orderBy) {
          'title' => t.title,
          'savedAt' => t.savedAt,
          _ => t.savedAt,
        };
        return OrderingTerm(
          expression: column,
          mode: descending ? OrderingMode.desc : OrderingMode.asc,
        );
      },
    ]);

    return query.get();
  }

  /// Soft delete an article (mark as deleted without removing)
  Future<int> softDeleteArticle(int id) {
    return (update(articlesTable)..where((a) => a.id.equals(id)))
        .write(const ArticlesTableCompanion(isDeleted: Value(true)));
  }

  /// Restore a soft-deleted article
  Future<int> restoreArticle(int id) {
    return (update(articlesTable)..where((a) => a.id.equals(id)))
        .write(const ArticlesTableCompanion(isDeleted: Value(false)));
  }

  /// Get articles that contain a specific tag
  Future<List<ArticlesTableData>> getArticlesByTag(String tag) {
    return (select(articlesTable)
      ..where((a) => a.tags.like('%$tag%') & a.isDeleted.equals(false))
      ..orderBy([(a) => OrderingTerm.desc(a.createdAt)]))
      .get();
  }

  Stream<List<ArticlesTableData>> watchAllArticles() {
    // Filter out soft-deleted articles
    return (select(articlesTable)
      ..where((a) => a.isDeleted.equals(false))
      ..orderBy([(a) => OrderingTerm.desc(a.createdAt)]))
      .watch();
  }({
    String orderBy = 'savedAt',
    bool descending = true,
    bool? isArchived,
  }) {
    final query = select(articlesTable);

    if (isArchived != null) {
      query.where((t) => t.isArchived.equals(isArchived));
    }

    query.orderBy([
      (t) {
        final column = switch (orderBy) {
          'title' => t.title,
          'savedAt' => t.savedAt,
          _ => t.savedAt,
        };
        return OrderingTerm(
          expression: column,
          mode: descending ? OrderingMode.desc : OrderingMode.asc,
        );
      },
    ]);

    return query.watch();
  }

  Future<ArticlesTableData?> getArticleById(String id) {
    return (select(
      articlesTable,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<ArticlesTableData?> getArticleByUrl(String url) {
    return (select(
      articlesTable,
    )..where((t) => t.url.equals(url))).getSingleOrNull();
  }

  Future<int> insertArticle(ArticlesTableCompanion article) {
    return into(articlesTable).insert(article);
  }

  Future<bool> updateArticle(ArticlesTableCompanion article) {
    return update(articlesTable).replace(
      ArticlesTableData(
        id: article.id.value,
        url: article.url.value,
        title: article.title.value,
        author: article.author.value,
        excerpt: article.excerpt.value,
        content: article.content.value,
        imageUrl: article.imageUrl.value,
        siteName: article.siteName.value,
        savedAt: article.savedAt.value,
        publishedAt: article.publishedAt.value,
        wordCount: article.wordCount.value,
        isRead: article.isRead.value,
        isArchived: article.isArchived.value,
        isFavorite: article.isFavorite.value,
        tags: article.tags.value,
        status: article.status.value,
        scrollPosition: article.scrollPosition.value,
        lastSyncedAt: article.lastSyncedAt.value,
      ),
    );
  }

  Future<int> deleteArticleById(String id) {
    return (delete(articlesTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> markAsRead(String id) async {
    await (update(articlesTable)..where((t) => t.id.equals(id))).write(
      const ArticlesTableCompanion(isRead: Value(true)),
    );
  }

  Future<void> markAsUnread(String id) async {
    await (update(articlesTable)..where((t) => t.id.equals(id))).write(
      const ArticlesTableCompanion(isRead: Value(false)),
    );
  }

  Future<void> toggleFavorite(String id) async {
    final article = await getArticleById(id);
    if (article != null) {
      await (update(articlesTable)..where((t) => t.id.equals(id))).write(
        ArticlesTableCompanion(isFavorite: Value(!article.isFavorite)),
      );
    }
  }

  Future<void> toggleArchive(String id) async {
    final article = await getArticleById(id);
    if (article != null) {
      await (update(articlesTable)..where((t) => t.id.equals(id))).write(
        ArticlesTableCompanion(isArchived: Value(!article.isArchived)),
      );
    }
  }

  Future<void> updateScrollPosition(String id, double position) async {
    await (update(articlesTable)..where((t) => t.id.equals(id))).write(
      ArticlesTableCompanion(scrollPosition: Value(position)),
    );
  }

  Future<void> updateStatus(String id, String status) async {
    await (update(articlesTable)..where((t) => t.id.equals(id))).write(
      ArticlesTableCompanion(status: Value(status)),
    );
  }

  Future<List<ArticlesTableData>> searchArticles(String query) async {
    final searchTerm = '%$query%';
    return (select(articlesTable)..where(
          (t) =>
              t.title.like(searchTerm) |
              t.content.like(searchTerm) |
              t.siteName.like(searchTerm),
        ))
        .get();
  }
}
