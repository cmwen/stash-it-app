// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ArticlesTableTable extends ArticlesTable
    with TableInfo<$ArticlesTableTable, ArticlesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _excerptMeta = const VerificationMeta(
    'excerpt',
  );
  @override
  late final GeneratedColumn<String> excerpt = GeneratedColumn<String>(
    'excerpt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _siteNameMeta = const VerificationMeta(
    'siteName',
  );
  @override
  late final GeneratedColumn<String> siteName = GeneratedColumn<String>(
    'site_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wordCountMeta = const VerificationMeta(
    'wordCount',
  );
  @override
  late final GeneratedColumn<int> wordCount = GeneratedColumn<int>(
    'word_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _scrollPositionMeta = const VerificationMeta(
    'scrollPosition',
  );
  @override
  late final GeneratedColumn<double> scrollPosition = GeneratedColumn<double>(
    'scroll_position',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    url,
    title,
    author,
    excerpt,
    content,
    imageUrl,
    siteName,
    savedAt,
    publishedAt,
    wordCount,
    isRead,
    isArchived,
    isFavorite,
    tags,
    status,
    scrollPosition,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ArticlesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('excerpt')) {
      context.handle(
        _excerptMeta,
        excerpt.isAcceptableOrUnknown(data['excerpt']!, _excerptMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('site_name')) {
      context.handle(
        _siteNameMeta,
        siteName.isAcceptableOrUnknown(data['site_name']!, _siteNameMeta),
      );
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_savedAtMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    }
    if (data.containsKey('word_count')) {
      context.handle(
        _wordCountMeta,
        wordCount.isAcceptableOrUnknown(data['word_count']!, _wordCountMeta),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('scroll_position')) {
      context.handle(
        _scrollPositionMeta,
        scrollPosition.isAcceptableOrUnknown(
          data['scroll_position']!,
          _scrollPositionMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArticlesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArticlesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      excerpt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}excerpt'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      siteName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}site_name'],
      ),
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      ),
      wordCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_count'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      scrollPosition: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}scroll_position'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $ArticlesTableTable createAlias(String alias) {
    return $ArticlesTableTable(attachedDatabase, alias);
  }
}

class ArticlesTableData extends DataClass
    implements Insertable<ArticlesTableData> {
  final String id;
  final String url;
  final String title;
  final String? author;
  final String? excerpt;
  final String content;
  final String? imageUrl;
  final String? siteName;
  final DateTime savedAt;
  final DateTime? publishedAt;
  final int wordCount;
  final bool isRead;
  final bool isArchived;
  final bool isFavorite;
  final String tags;
  final String status;
  final double? scrollPosition;
  final DateTime? lastSyncedAt;
  const ArticlesTableData({
    required this.id,
    required this.url,
    required this.title,
    this.author,
    this.excerpt,
    required this.content,
    this.imageUrl,
    this.siteName,
    required this.savedAt,
    this.publishedAt,
    required this.wordCount,
    required this.isRead,
    required this.isArchived,
    required this.isFavorite,
    required this.tags,
    required this.status,
    this.scrollPosition,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['url'] = Variable<String>(url);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || excerpt != null) {
      map['excerpt'] = Variable<String>(excerpt);
    }
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || siteName != null) {
      map['site_name'] = Variable<String>(siteName);
    }
    map['saved_at'] = Variable<DateTime>(savedAt);
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    map['word_count'] = Variable<int>(wordCount);
    map['is_read'] = Variable<bool>(isRead);
    map['is_archived'] = Variable<bool>(isArchived);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['tags'] = Variable<String>(tags);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || scrollPosition != null) {
      map['scroll_position'] = Variable<double>(scrollPosition);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  ArticlesTableCompanion toCompanion(bool nullToAbsent) {
    return ArticlesTableCompanion(
      id: Value(id),
      url: Value(url),
      title: Value(title),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      excerpt: excerpt == null && nullToAbsent
          ? const Value.absent()
          : Value(excerpt),
      content: Value(content),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      siteName: siteName == null && nullToAbsent
          ? const Value.absent()
          : Value(siteName),
      savedAt: Value(savedAt),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      wordCount: Value(wordCount),
      isRead: Value(isRead),
      isArchived: Value(isArchived),
      isFavorite: Value(isFavorite),
      tags: Value(tags),
      status: Value(status),
      scrollPosition: scrollPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(scrollPosition),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory ArticlesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArticlesTableData(
      id: serializer.fromJson<String>(json['id']),
      url: serializer.fromJson<String>(json['url']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String?>(json['author']),
      excerpt: serializer.fromJson<String?>(json['excerpt']),
      content: serializer.fromJson<String>(json['content']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      siteName: serializer.fromJson<String?>(json['siteName']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      wordCount: serializer.fromJson<int>(json['wordCount']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      tags: serializer.fromJson<String>(json['tags']),
      status: serializer.fromJson<String>(json['status']),
      scrollPosition: serializer.fromJson<double?>(json['scrollPosition']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'url': serializer.toJson<String>(url),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String?>(author),
      'excerpt': serializer.toJson<String?>(excerpt),
      'content': serializer.toJson<String>(content),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'siteName': serializer.toJson<String?>(siteName),
      'savedAt': serializer.toJson<DateTime>(savedAt),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'wordCount': serializer.toJson<int>(wordCount),
      'isRead': serializer.toJson<bool>(isRead),
      'isArchived': serializer.toJson<bool>(isArchived),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'tags': serializer.toJson<String>(tags),
      'status': serializer.toJson<String>(status),
      'scrollPosition': serializer.toJson<double?>(scrollPosition),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  ArticlesTableData copyWith({
    String? id,
    String? url,
    String? title,
    Value<String?> author = const Value.absent(),
    Value<String?> excerpt = const Value.absent(),
    String? content,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> siteName = const Value.absent(),
    DateTime? savedAt,
    Value<DateTime?> publishedAt = const Value.absent(),
    int? wordCount,
    bool? isRead,
    bool? isArchived,
    bool? isFavorite,
    String? tags,
    String? status,
    Value<double?> scrollPosition = const Value.absent(),
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => ArticlesTableData(
    id: id ?? this.id,
    url: url ?? this.url,
    title: title ?? this.title,
    author: author.present ? author.value : this.author,
    excerpt: excerpt.present ? excerpt.value : this.excerpt,
    content: content ?? this.content,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    siteName: siteName.present ? siteName.value : this.siteName,
    savedAt: savedAt ?? this.savedAt,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
    wordCount: wordCount ?? this.wordCount,
    isRead: isRead ?? this.isRead,
    isArchived: isArchived ?? this.isArchived,
    isFavorite: isFavorite ?? this.isFavorite,
    tags: tags ?? this.tags,
    status: status ?? this.status,
    scrollPosition: scrollPosition.present
        ? scrollPosition.value
        : this.scrollPosition,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  ArticlesTableData copyWithCompanion(ArticlesTableCompanion data) {
    return ArticlesTableData(
      id: data.id.present ? data.id.value : this.id,
      url: data.url.present ? data.url.value : this.url,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      excerpt: data.excerpt.present ? data.excerpt.value : this.excerpt,
      content: data.content.present ? data.content.value : this.content,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      siteName: data.siteName.present ? data.siteName.value : this.siteName,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      wordCount: data.wordCount.present ? data.wordCount.value : this.wordCount,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      tags: data.tags.present ? data.tags.value : this.tags,
      status: data.status.present ? data.status.value : this.status,
      scrollPosition: data.scrollPosition.present
          ? data.scrollPosition.value
          : this.scrollPosition,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesTableData(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('excerpt: $excerpt, ')
          ..write('content: $content, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('siteName: $siteName, ')
          ..write('savedAt: $savedAt, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('wordCount: $wordCount, ')
          ..write('isRead: $isRead, ')
          ..write('isArchived: $isArchived, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('tags: $tags, ')
          ..write('status: $status, ')
          ..write('scrollPosition: $scrollPosition, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    url,
    title,
    author,
    excerpt,
    content,
    imageUrl,
    siteName,
    savedAt,
    publishedAt,
    wordCount,
    isRead,
    isArchived,
    isFavorite,
    tags,
    status,
    scrollPosition,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticlesTableData &&
          other.id == this.id &&
          other.url == this.url &&
          other.title == this.title &&
          other.author == this.author &&
          other.excerpt == this.excerpt &&
          other.content == this.content &&
          other.imageUrl == this.imageUrl &&
          other.siteName == this.siteName &&
          other.savedAt == this.savedAt &&
          other.publishedAt == this.publishedAt &&
          other.wordCount == this.wordCount &&
          other.isRead == this.isRead &&
          other.isArchived == this.isArchived &&
          other.isFavorite == this.isFavorite &&
          other.tags == this.tags &&
          other.status == this.status &&
          other.scrollPosition == this.scrollPosition &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class ArticlesTableCompanion extends UpdateCompanion<ArticlesTableData> {
  final Value<String> id;
  final Value<String> url;
  final Value<String> title;
  final Value<String?> author;
  final Value<String?> excerpt;
  final Value<String> content;
  final Value<String?> imageUrl;
  final Value<String?> siteName;
  final Value<DateTime> savedAt;
  final Value<DateTime?> publishedAt;
  final Value<int> wordCount;
  final Value<bool> isRead;
  final Value<bool> isArchived;
  final Value<bool> isFavorite;
  final Value<String> tags;
  final Value<String> status;
  final Value<double?> scrollPosition;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const ArticlesTableCompanion({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.excerpt = const Value.absent(),
    this.content = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.siteName = const Value.absent(),
    this.savedAt = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.tags = const Value.absent(),
    this.status = const Value.absent(),
    this.scrollPosition = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArticlesTableCompanion.insert({
    required String id,
    required String url,
    required String title,
    this.author = const Value.absent(),
    this.excerpt = const Value.absent(),
    required String content,
    this.imageUrl = const Value.absent(),
    this.siteName = const Value.absent(),
    required DateTime savedAt,
    this.publishedAt = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.tags = const Value.absent(),
    this.status = const Value.absent(),
    this.scrollPosition = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       url = Value(url),
       title = Value(title),
       content = Value(content),
       savedAt = Value(savedAt);
  static Insertable<ArticlesTableData> custom({
    Expression<String>? id,
    Expression<String>? url,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? excerpt,
    Expression<String>? content,
    Expression<String>? imageUrl,
    Expression<String>? siteName,
    Expression<DateTime>? savedAt,
    Expression<DateTime>? publishedAt,
    Expression<int>? wordCount,
    Expression<bool>? isRead,
    Expression<bool>? isArchived,
    Expression<bool>? isFavorite,
    Expression<String>? tags,
    Expression<String>? status,
    Expression<double>? scrollPosition,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (excerpt != null) 'excerpt': excerpt,
      if (content != null) 'content': content,
      if (imageUrl != null) 'image_url': imageUrl,
      if (siteName != null) 'site_name': siteName,
      if (savedAt != null) 'saved_at': savedAt,
      if (publishedAt != null) 'published_at': publishedAt,
      if (wordCount != null) 'word_count': wordCount,
      if (isRead != null) 'is_read': isRead,
      if (isArchived != null) 'is_archived': isArchived,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (tags != null) 'tags': tags,
      if (status != null) 'status': status,
      if (scrollPosition != null) 'scroll_position': scrollPosition,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArticlesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? url,
    Value<String>? title,
    Value<String?>? author,
    Value<String?>? excerpt,
    Value<String>? content,
    Value<String?>? imageUrl,
    Value<String?>? siteName,
    Value<DateTime>? savedAt,
    Value<DateTime?>? publishedAt,
    Value<int>? wordCount,
    Value<bool>? isRead,
    Value<bool>? isArchived,
    Value<bool>? isFavorite,
    Value<String>? tags,
    Value<String>? status,
    Value<double?>? scrollPosition,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return ArticlesTableCompanion(
      id: id ?? this.id,
      url: url ?? this.url,
      title: title ?? this.title,
      author: author ?? this.author,
      excerpt: excerpt ?? this.excerpt,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      siteName: siteName ?? this.siteName,
      savedAt: savedAt ?? this.savedAt,
      publishedAt: publishedAt ?? this.publishedAt,
      wordCount: wordCount ?? this.wordCount,
      isRead: isRead ?? this.isRead,
      isArchived: isArchived ?? this.isArchived,
      isFavorite: isFavorite ?? this.isFavorite,
      tags: tags ?? this.tags,
      status: status ?? this.status,
      scrollPosition: scrollPosition ?? this.scrollPosition,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (excerpt.present) {
      map['excerpt'] = Variable<String>(excerpt.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (siteName.present) {
      map['site_name'] = Variable<String>(siteName.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (wordCount.present) {
      map['word_count'] = Variable<int>(wordCount.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (scrollPosition.present) {
      map['scroll_position'] = Variable<double>(scrollPosition.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesTableCompanion(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('excerpt: $excerpt, ')
          ..write('content: $content, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('siteName: $siteName, ')
          ..write('savedAt: $savedAt, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('wordCount: $wordCount, ')
          ..write('isRead: $isRead, ')
          ..write('isArchived: $isArchived, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('tags: $tags, ')
          ..write('status: $status, ')
          ..write('scrollPosition: $scrollPosition, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ArticlesTableTable articlesTable = $ArticlesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [articlesTable];
}

typedef $$ArticlesTableTableCreateCompanionBuilder =
    ArticlesTableCompanion Function({
      required String id,
      required String url,
      required String title,
      Value<String?> author,
      Value<String?> excerpt,
      required String content,
      Value<String?> imageUrl,
      Value<String?> siteName,
      required DateTime savedAt,
      Value<DateTime?> publishedAt,
      Value<int> wordCount,
      Value<bool> isRead,
      Value<bool> isArchived,
      Value<bool> isFavorite,
      Value<String> tags,
      Value<String> status,
      Value<double?> scrollPosition,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$ArticlesTableTableUpdateCompanionBuilder =
    ArticlesTableCompanion Function({
      Value<String> id,
      Value<String> url,
      Value<String> title,
      Value<String?> author,
      Value<String?> excerpt,
      Value<String> content,
      Value<String?> imageUrl,
      Value<String?> siteName,
      Value<DateTime> savedAt,
      Value<DateTime?> publishedAt,
      Value<int> wordCount,
      Value<bool> isRead,
      Value<bool> isArchived,
      Value<bool> isFavorite,
      Value<String> tags,
      Value<String> status,
      Value<double?> scrollPosition,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$ArticlesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ArticlesTableTable> {
  $$ArticlesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get excerpt => $composableBuilder(
    column: $table.excerpt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get siteName => $composableBuilder(
    column: $table.siteName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get scrollPosition => $composableBuilder(
    column: $table.scrollPosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ArticlesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ArticlesTableTable> {
  $$ArticlesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get excerpt => $composableBuilder(
    column: $table.excerpt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get siteName => $composableBuilder(
    column: $table.siteName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get scrollPosition => $composableBuilder(
    column: $table.scrollPosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ArticlesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArticlesTableTable> {
  $$ArticlesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get excerpt =>
      $composableBuilder(column: $table.excerpt, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get siteName =>
      $composableBuilder(column: $table.siteName, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wordCount =>
      $composableBuilder(column: $table.wordCount, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get scrollPosition => $composableBuilder(
    column: $table.scrollPosition,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$ArticlesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArticlesTableTable,
          ArticlesTableData,
          $$ArticlesTableTableFilterComposer,
          $$ArticlesTableTableOrderingComposer,
          $$ArticlesTableTableAnnotationComposer,
          $$ArticlesTableTableCreateCompanionBuilder,
          $$ArticlesTableTableUpdateCompanionBuilder,
          (
            ArticlesTableData,
            BaseReferences<
              _$AppDatabase,
              $ArticlesTableTable,
              ArticlesTableData
            >,
          ),
          ArticlesTableData,
          PrefetchHooks Function()
        > {
  $$ArticlesTableTableTableManager(_$AppDatabase db, $ArticlesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArticlesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArticlesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArticlesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> excerpt = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> siteName = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<int> wordCount = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double?> scrollPosition = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArticlesTableCompanion(
                id: id,
                url: url,
                title: title,
                author: author,
                excerpt: excerpt,
                content: content,
                imageUrl: imageUrl,
                siteName: siteName,
                savedAt: savedAt,
                publishedAt: publishedAt,
                wordCount: wordCount,
                isRead: isRead,
                isArchived: isArchived,
                isFavorite: isFavorite,
                tags: tags,
                status: status,
                scrollPosition: scrollPosition,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String url,
                required String title,
                Value<String?> author = const Value.absent(),
                Value<String?> excerpt = const Value.absent(),
                required String content,
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> siteName = const Value.absent(),
                required DateTime savedAt,
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<int> wordCount = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double?> scrollPosition = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArticlesTableCompanion.insert(
                id: id,
                url: url,
                title: title,
                author: author,
                excerpt: excerpt,
                content: content,
                imageUrl: imageUrl,
                siteName: siteName,
                savedAt: savedAt,
                publishedAt: publishedAt,
                wordCount: wordCount,
                isRead: isRead,
                isArchived: isArchived,
                isFavorite: isFavorite,
                tags: tags,
                status: status,
                scrollPosition: scrollPosition,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ArticlesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArticlesTableTable,
      ArticlesTableData,
      $$ArticlesTableTableFilterComposer,
      $$ArticlesTableTableOrderingComposer,
      $$ArticlesTableTableAnnotationComposer,
      $$ArticlesTableTableCreateCompanionBuilder,
      $$ArticlesTableTableUpdateCompanionBuilder,
      (
        ArticlesTableData,
        BaseReferences<_$AppDatabase, $ArticlesTableTable, ArticlesTableData>,
      ),
      ArticlesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ArticlesTableTableTableManager get articlesTable =>
      $$ArticlesTableTableTableManager(_db, _db.articlesTable);
}
