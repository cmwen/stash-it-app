import 'package:drift/drift.dart';

/// Database table for articles.
class ArticlesTable extends Table {
  @override
  String get tableName => 'articles';

  TextColumn get id => text()();
  TextColumn get url => text()();
  TextColumn get title => text()();
  TextColumn get author => text().nullable()();
  TextColumn get excerpt => text().nullable()();
  TextColumn get content => text()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get siteName => text().nullable()();
  DateTimeColumn get savedAt => dateTime()();
  DateTimeColumn get publishedAt => dateTime().nullable()();
  IntColumn get wordCount => integer().withDefault(const Constant(0))();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  TextColumn get tags =>
      text().withDefault(const Constant('[]'))(); // JSON array
  TextColumn get status => text().withDefault(const Constant('pending'))();
  RealColumn get scrollPosition => real().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
