# Stash It - Technical Requirements

**Created:** November 25, 2025  
**Version:** 1.0  
**Status:** Draft  
**Audience:** Development Team, Technical Leads

---

## Overview

This document outlines the technical requirements, architecture decisions, and implementation guidelines for Stash It - a local-first, offline-capable "save it later" application.

---

## Technology Stack

### Core Framework
| Component | Technology | Rationale |
|-----------|------------|-----------|
| **Framework** | Flutter 3.10+ | Cross-platform, single codebase |
| **Language** | Dart 3.10+ | Type-safe, null-safe, async support |
| **State Management** | Riverpod or Bloc | Testable, scalable state |
| **Navigation** | go_router | Declarative routing, deep linking |

### Local Storage
| Component | Technology | Rationale |
|-----------|------------|-----------|
| **Database** | Isar or Drift (SQLite) | Fast, local-first, full-text search |
| **Key-Value Store** | shared_preferences | Simple settings storage |
| **File Storage** | path_provider + file cache | Cached images, exports |

### Content Processing
| Component | Technology | Rationale |
|-----------|------------|-----------|
| **HTTP Client** | dio | Robust, interceptors, caching |
| **HTML Parsing** | html package | Parse article content |
| **Article Extraction** | readability/custom | Extract main content |
| **Image Caching** | cached_network_image | Efficient image handling |

### Future P2P Sync
| Component | Technology | Rationale |
|-----------|------------|-----------|
| **Data Sync** | CRDTs (e.g., automerge-dart) | Conflict-free replication |
| **Discovery** | mDNS / Bonjour | Local network discovery |
| **Transport** | libp2p or custom | Direct peer communication |

---

## Architecture

### Clean Architecture Layers

```
┌──────────────────────────────────────────────────────┐
│                   Presentation                        │
│        (Widgets, Pages, State Management)             │
├──────────────────────────────────────────────────────┤
│                   Application                         │
│          (Use Cases, Business Logic)                  │
├──────────────────────────────────────────────────────┤
│                     Domain                            │
│        (Entities, Repository Interfaces)              │
├──────────────────────────────────────────────────────┤
│                  Infrastructure                       │
│    (Database, API, File System, Implementations)      │
└──────────────────────────────────────────────────────┘
```

### Project Structure

```
lib/
├── main.dart                 # App entry point
├── app/
│   ├── app.dart              # MaterialApp configuration
│   └── router.dart           # Route definitions
├── core/
│   ├── constants/            # App constants
│   ├── errors/               # Error handling
│   ├── extensions/           # Dart extensions
│   ├── theme/                # Theme definitions
│   └── utils/                # Utility functions
├── features/
│   ├── articles/
│   │   ├── data/
│   │   │   ├── datasources/  # Local/remote data sources
│   │   │   ├── models/       # Data models (JSON/DB)
│   │   │   └── repositories/ # Repository implementations
│   │   ├── domain/
│   │   │   ├── entities/     # Business entities
│   │   │   ├── repositories/ # Repository interfaces
│   │   │   └── usecases/     # Business logic
│   │   └── presentation/
│   │       ├── pages/        # Screen widgets
│   │       ├── widgets/      # Feature-specific widgets
│   │       └── providers/    # State management
│   ├── settings/
│   │   └── ...
│   └── sync/                 # Future P2P sync
│       └── ...
└── shared/
    └── widgets/              # Shared UI components
```

---

## Data Models

### Article Entity

```dart
class Article {
  final String id;              // UUID
  final String url;             // Original URL
  final String title;           // Extracted title
  final String? author;         // Article author
  final String? excerpt;        // Short summary
  final String content;         // Cleaned HTML content
  final String? imageUrl;       // Featured image
  final String? siteName;       // Source website
  final DateTime savedAt;       // When user saved
  final DateTime? publishedAt;  // Original publish date
  final int wordCount;          // For reading time
  final bool isRead;            // Read status
  final bool isArchived;        // Archive status
  final bool isFavorite;        // Favorite status
  final List<String> tags;      // User tags
  final ArticleStatus status;   // pending, ready, failed
  final DateTime? lastSyncedAt; // For P2P sync
}

enum ArticleStatus {
  pending,    // URL saved, content not fetched
  fetching,   // Currently downloading
  ready,      // Content available
  failed,     // Extraction failed
}
```

### Tag Entity

```dart
class Tag {
  final String id;
  final String name;
  final String? color;
  final int articleCount;
  final DateTime createdAt;
}
```

### Settings Entity

```dart
class AppSettings {
  final ThemeMode themeMode;
  final ReaderTheme readerTheme;
  final double fontSize;
  final double lineSpacing;
  final bool autoMarkRead;
  final SortOrder defaultSort;
  final bool confirmDelete;
  final bool showArchived;
}
```

---

## Functional Requirements

### FR-1: Content Saving

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-1.1 | Accept URLs via system share intent | P0 |
| FR-1.2 | Accept URLs via in-app text input | P0 |
| FR-1.3 | Validate URL format before processing | P0 |
| FR-1.4 | Queue URL for processing when offline | P0 |
| FR-1.5 | Extract article content using readability algorithm | P0 |
| FR-1.6 | Download and cache article images locally | P0 |
| FR-1.7 | Handle extraction failures gracefully | P0 |
| FR-1.8 | Detect and handle duplicate URLs | P1 |

### FR-2: Reading Experience

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-2.1 | Display article in clean reader view | P0 |
| FR-2.2 | Support light, dark, and sepia themes | P1 |
| FR-2.3 | Allow font size adjustment | P1 |
| FR-2.4 | Display reading time estimate | P2 |
| FR-2.5 | Remember scroll position | P1 |
| FR-2.6 | Open original URL in browser | P1 |

### FR-3: Organization

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-3.1 | List all saved articles | P0 |
| FR-3.2 | Sort by date, title, or source | P1 |
| FR-3.3 | Full-text search (offline) | P1 |
| FR-3.4 | Tag articles with multiple tags | P1 |
| FR-3.5 | Filter by tag, status, favorites | P1 |
| FR-3.6 | Archive articles | P1 |
| FR-3.7 | Delete articles | P0 |
| FR-3.8 | Mark as favorite | P2 |

### FR-4: Data Management

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-4.1 | Store all data locally | P0 |
| FR-4.2 | Export data to JSON/HTML | P1 |
| FR-4.3 | Import from Pocket export | P2 |
| FR-4.4 | Display storage usage | P2 |
| FR-4.5 | Clear image cache | P2 |

### FR-5: P2P Sync (Future)

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-5.1 | Discover devices on local network | P3 |
| FR-5.2 | Pair devices with confirmation | P3 |
| FR-5.3 | Bi-directional sync with CRDTs | P3 |
| FR-5.4 | Sync articles, tags, and read status | P3 |
| FR-5.5 | Manual sync trigger | P3 |

---

## Non-Functional Requirements

### NFR-1: Performance

| ID | Requirement | Target |
|----|-------------|--------|
| NFR-1.1 | App cold start time | < 2 seconds |
| NFR-1.2 | Article list scroll | 60 FPS |
| NFR-1.3 | Open saved article | < 500ms |
| NFR-1.4 | Fetch and parse new article | < 5 seconds |
| NFR-1.5 | Search response time | < 200ms |

### NFR-2: Storage

| ID | Requirement | Target |
|----|-------------|--------|
| NFR-2.1 | App bundle size | < 30 MB |
| NFR-2.2 | Average article storage | < 500 KB |
| NFR-2.3 | Database query performance | < 50ms |
| NFR-2.4 | Support 10,000+ articles | Tested |

### NFR-3: Offline Capability

| ID | Requirement | Target |
|----|-------------|--------|
| NFR-3.1 | Full functionality offline | 100% core features |
| NFR-3.2 | Graceful degradation | Clear offline indicators |
| NFR-3.3 | Sync queue persistence | Survives app restart |

### NFR-4: Reliability

| ID | Requirement | Target |
|----|-------------|--------|
| NFR-4.1 | Crash-free sessions | > 99.5% |
| NFR-4.2 | Data loss prevention | 0 data loss |
| NFR-4.3 | Recovery from interruption | Auto-resume |

### NFR-5: Security

| ID | Requirement | Target |
|----|-------------|--------|
| NFR-5.1 | No data collection | Verified |
| NFR-5.2 | No external analytics | Verified |
| NFR-5.3 | Secure local storage | Platform encryption |
| NFR-5.4 | HTTPS for content fetch | Enforced |

### NFR-6: Accessibility

| ID | Requirement | Target |
|----|-------------|--------|
| NFR-6.1 | Screen reader support | Full |
| NFR-6.2 | Minimum touch target | 48dp |
| NFR-6.3 | Color contrast ratio | > 4.5:1 |
| NFR-6.4 | Dynamic text scaling | Supported |

---

## Dependencies (Recommended)

### pubspec.yaml additions

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.4.0
  
  # Navigation
  go_router: ^12.0.0
  
  # Local Database
  isar: ^3.1.0
  isar_flutter_libs: ^3.1.0
  
  # HTTP & Networking
  dio: ^5.3.0
  connectivity_plus: ^5.0.0
  
  # HTML Parsing & Content Extraction
  html: ^0.15.0
  
  # Image Handling
  cached_network_image: ^3.3.0
  
  # Storage
  path_provider: ^2.1.0
  shared_preferences: ^2.2.0
  
  # Utilities
  uuid: ^4.2.0
  url_launcher: ^6.2.0
  share_plus: ^7.2.0
  receive_sharing_intent: ^1.6.0
  
  # UI
  flutter_slidable: ^3.0.0
  shimmer: ^3.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  isar_generator: ^3.1.0
  build_runner: ^2.4.0
  mocktail: ^1.0.0
```

---

## API Contracts

### Article Repository Interface

```dart
abstract class ArticleRepository {
  // CRUD
  Future<Article> saveArticle(String url);
  Future<Article?> getArticle(String id);
  Future<List<Article>> getAllArticles({
    SortOrder? sort,
    bool? isArchived,
    bool? isFavorite,
    List<String>? tags,
  });
  Future<void> updateArticle(Article article);
  Future<void> deleteArticle(String id);
  
  // Bulk operations
  Future<void> deleteMultiple(List<String> ids);
  Future<void> archiveMultiple(List<String> ids);
  
  // Search
  Future<List<Article>> searchArticles(String query);
  
  // Status
  Future<void> markAsRead(String id);
  Future<void> toggleFavorite(String id);
  Future<void> toggleArchive(String id);
  
  // Tags
  Future<void> addTag(String articleId, String tag);
  Future<void> removeTag(String articleId, String tag);
  
  // Sync
  Stream<Article> watchArticle(String id);
  Stream<List<Article>> watchAllArticles();
}
```

### Content Extractor Interface

```dart
abstract class ContentExtractor {
  Future<ExtractedContent> extract(String url);
}

class ExtractedContent {
  final String title;
  final String? author;
  final String? excerpt;
  final String content;      // Cleaned HTML
  final String? imageUrl;
  final String? siteName;
  final DateTime? publishedAt;
  final int wordCount;
}
```

---

## Testing Requirements

### Unit Tests
- All use cases must have unit tests
- Repository implementations must be tested with mocks
- Content extraction logic must be tested with sample HTML

### Widget Tests
- All pages must have widget tests
- Critical user flows must be tested
- Accessibility must be verified

### Integration Tests
- Save article flow (end-to-end)
- Offline mode behavior
- Data persistence across restarts

### Test Coverage Target
- Minimum 80% code coverage for business logic
- Minimum 60% overall coverage

---

## Milestones

### MVP (v1.0) - Target: 4 weeks
- [ ] Project setup with architecture
- [ ] Local database implementation
- [ ] Save URL via share intent
- [ ] Content extraction
- [ ] Article list view
- [ ] Reader view
- [ ] Basic offline support
- [ ] Delete functionality

### v1.5 - Target: 3 weeks after MVP
- [ ] Tags and filtering
- [ ] Full-text search
- [ ] Archive functionality
- [ ] Theme support
- [ ] Reader customization
- [ ] Export functionality

### v2.0 - Target: 4 weeks after v1.5
- [ ] Import from Pocket/Instapaper
- [ ] Favorites
- [ ] Storage management
- [ ] Advanced settings
- [ ] Performance optimization

### v3.0 - Target: 6 weeks after v2.0
- [ ] P2P device discovery
- [ ] CRDT-based sync
- [ ] Conflict resolution
- [ ] Sync UI/UX

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-11-25 | Product Owner | Initial technical requirements |
