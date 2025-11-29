import 'package:equatable/equatable.dart';

/// Status of article content fetching.
enum ArticleStatus {
  /// URL saved, content not fetched yet
  pending,

  /// Currently downloading/extracting content
  fetching,

  /// Content successfully extracted and ready
  ready,

  /// Content extraction failed
  failed,
}

/// Represents a saved article entity.
class Article extends Equatable {
  /// Unique identifier (UUID)
  final String id;

  /// Original URL of the article
  final String url;

  /// Extracted article title
  final String title;

  /// Article author (if extracted)
  final String? author;

  /// Short summary/excerpt
  final String? excerpt;

  /// Cleaned HTML content for reader view
  final String content;

  /// Featured image URL
  final String? imageUrl;

  /// Source website name
  final String? siteName;

  /// When the user saved this article
  final DateTime savedAt;

  /// Original publish date (if extracted)
  final DateTime? publishedAt;

  /// Word count for reading time calculation
  final int wordCount;

  /// Whether the user has read this article
  final bool isRead;

  /// Whether the article is archived
  final bool isArchived;

  /// Whether the article is favorited
  final bool isFavorite;

  /// User-assigned tags
  final List<String> tags;

  /// Current status of content fetching
  final ArticleStatus status;

  /// Last scroll position (0.0 to 1.0)
  final double? scrollPosition;

  /// For future P2P sync
  final DateTime? lastSyncedAt;

  const Article({
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
    this.isRead = false,
    this.isArchived = false,
    this.isFavorite = false,
    this.tags = const [],
    required this.status,
    this.scrollPosition,
    this.lastSyncedAt,
  });

  /// Estimated reading time in minutes (assuming 200 words per minute)
  int get readingTimeMinutes => (wordCount / 200).ceil().clamp(1, 999);

  /// Creates a copy with updated fields
  Article copyWith({
    String? id,
    String? url,
    String? title,
    String? author,
    String? excerpt,
    String? content,
    String? imageUrl,
    String? siteName,
    DateTime? savedAt,
    DateTime? publishedAt,
    int? wordCount,
    bool? isRead,
    bool? isArchived,
    bool? isFavorite,
    List<String>? tags,
    ArticleStatus? status,
    double? scrollPosition,
    DateTime? lastSyncedAt,
  }) {
    return Article(
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
    );
  }

  @override
  List<Object?> get props => [
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
}
