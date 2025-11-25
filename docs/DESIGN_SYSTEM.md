# Stash It - Component Library & Design Tokens

**Created:** November 25, 2025  
**Version:** 1.0  
**Status:** Draft  
**For:** Flutter Implementation

---

## Design Tokens

### Colors

```dart
// lib/core/theme/app_colors.dart

abstract class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF6750A4);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color onPrimaryContainer = Color(0xFF21005D);

  // Secondary Palette
  static const Color secondary = Color(0xFF625B71);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE8DEF8);
  static const Color onSecondaryContainer = Color(0xFF1D192B);

  // Surface & Background
  static const Color surface = Color(0xFFFFFBFE);
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color surfaceVariant = Color(0xFFE7E0EC);
  static const Color onSurfaceVariant = Color(0xFF49454F);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Reader Themes
  static const Color readerLightBg = Color(0xFFFFFFFF);
  static const Color readerLightText = Color(0xFF1C1B1F);
  
  static const Color readerDarkBg = Color(0xFF1C1B1F);
  static const Color readerDarkText = Color(0xFFE6E1E5);
  
  static const Color readerSepiaBg = Color(0xFFF4ECD8);
  static const Color readerSepiaText = Color(0xFF5B4636);

  // Status Indicators
  static const Color unreadDot = Color(0xFF6750A4);
  static const Color offlineBanner = Color(0xFFFFF3E0);
}
```

### Typography

```dart
// lib/core/theme/app_typography.dart

abstract class AppTypography {
  // App UI Typography (Material 3)
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Reader Typography
  static const String readerFontFamily = 'Georgia'; // Or system serif
  
  static TextStyle readerBody(double fontSize) => TextStyle(
    fontFamily: readerFontFamily,
    fontSize: fontSize,
    fontWeight: FontWeight.w400,
    height: 1.7,
    letterSpacing: 0.2,
  );

  static TextStyle readerH1(double baseFontSize) => TextStyle(
    fontFamily: readerFontFamily,
    fontSize: baseFontSize * 1.5,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static TextStyle readerH2(double baseFontSize) => TextStyle(
    fontFamily: readerFontFamily,
    fontSize: baseFontSize * 1.3,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );
}
```

### Spacing

```dart
// lib/core/theme/app_spacing.dart

abstract class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // Component-specific
  static const double cardPadding = 16;
  static const double listItemSpacing = 8;
  static const double screenPadding = 16;
  static const double readerHorizontalPadding = 24;
  static const double readerMaxWidth = 680;
}
```

### Durations

```dart
// lib/core/theme/app_durations.dart

abstract class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  
  static const Duration snackbarDuration = Duration(seconds: 4);
  static const Duration undoWindow = Duration(seconds: 5);
  static const Duration debounceSearch = Duration(milliseconds: 300);
}
```

---

## Component Specifications

### 1. Article Card

**Purpose:** Display article in list view

**Anatomy:**
```
┌─────────────────────────────────────────────────┐
│ ┌────────┐                                      │
│ │  IMG   │  Title (max 2 lines)            ●   │
│ │ 72x72  │  source.com • 5 min read            │
│ │        │  Saved 2 hours ago                  │
│ └────────┘                                      │
└─────────────────────────────────────────────────┘
```

**Properties:**
| Property | Type | Description |
|----------|------|-------------|
| title | String | Article title (required) |
| source | String | Website name or domain |
| imageUrl | String? | Thumbnail URL |
| readingTime | int | Minutes to read |
| savedAt | DateTime | When saved |
| isRead | bool | Read status |
| onTap | VoidCallback | Open article |
| onDismissed | VoidCallback | Delete action |

**States:**
- Default (unread) - Full opacity, unread dot
- Read - Slightly faded (opacity 0.7), no dot
- Loading - Skeleton shimmer
- Error - Warning icon, retry option
- Pressed - Subtle highlight

**Code Example:**
```dart
class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ArticleCard({
    required this.article,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(article.id),
      direction: DismissDirection.endToStart,
      background: _buildDeleteBackground(),
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.cardPadding),
            child: Row(
              children: [
                _buildThumbnail(),
                SizedBox(width: AppSpacing.md),
                Expanded(child: _buildContent()),
                if (!article.isRead) _buildUnreadDot(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

### 2. Empty State

**Purpose:** Guide users when no content exists

**Anatomy:**
```
┌─────────────────────────────────────────────────┐
│                                                 │
│                     📚                          │
│                                                 │
│              No articles yet                    │
│                                                 │
│        Save articles from any app               │
│        using the share button                   │
│                                                 │
│         [ Save Your First Article ]             │
│                                                 │
└─────────────────────────────────────────────────┘
```

**Properties:**
| Property | Type | Description |
|----------|------|-------------|
| icon | IconData | Visual icon |
| title | String | Primary message |
| description | String | Secondary text |
| actionLabel | String? | CTA button text |
| onAction | VoidCallback? | CTA callback |

**Code Example:**
```dart
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Theme.of(context).colorScheme.primary),
            SizedBox(height: AppSpacing.lg),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: AppSpacing.sm),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null) ...[
              SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

### 3. Add URL Bottom Sheet

**Purpose:** Manual URL input

**Anatomy:**
```
┌─────────────────────────────────────────────────┐
│                    ─────                        │
│                                                 │
│   Add Article                                   │
│                                                 │
│   ┌─────────────────────────────────────────┐   │
│   │  Paste or type URL...               📋  │   │
│   └─────────────────────────────────────────┘   │
│                                                 │
│   [      Cancel      ]    [      Save      ]    │
│                                                 │
└─────────────────────────────────────────────────┘
```

**Properties:**
| Property | Type | Description |
|----------|------|-------------|
| onSave | Function(String) | Save callback |
| onCancel | VoidCallback | Cancel callback |

**Validation:**
- Empty: Save disabled
- Invalid URL: Red border + error message
- Valid URL: Save enabled

**Code Example:**
```dart
class AddUrlSheet extends StatefulWidget {
  final Function(String url) onSave;

  const AddUrlSheet({required this.onSave});

  @override
  State<AddUrlSheet> createState() => _AddUrlSheetState();
}

class _AddUrlSheetState extends State<AddUrlSheet> {
  final _controller = TextEditingController();
  String? _errorText;
  bool _isValid = false;

  void _validate(String value) {
    final uri = Uri.tryParse(value);
    final valid = uri != null && 
                  (uri.scheme == 'http' || uri.scheme == 'https') &&
                  uri.host.isNotEmpty;
    setState(() {
      _isValid = valid;
      _errorText = value.isEmpty ? null : (valid ? null : 'Enter a valid URL');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Container(/* drag handle */)),
          SizedBox(height: AppSpacing.md),
          Text('Add Article', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Paste or type URL...',
              errorText: _errorText,
              suffixIcon: IconButton(
                icon: Icon(Icons.content_paste),
                onPressed: _pasteFromClipboard,
              ),
            ),
            onChanged: _validate,
            keyboardType: TextInputType.url,
            autofocus: true,
          ),
          SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: FilledButton(
                  onPressed: _isValid ? () => widget.onSave(_controller.text) : null,
                  child: Text('Save'),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
```

---

### 4. Reader View

**Purpose:** Display article content for reading

**Layout:**
```
┌─────────────────────────────────────────────────┐
│ [←]                                    [⋮]      │
├─────────────────────────────────────────────────┤
│                                                 │
│   Article Title That Might                      │
│   Be Really Long                                │
│                                                 │
│   source.com • John Smith                       │
│   Nov 20, 2025 • 8 min read                     │
│                                                 │
│   ───────────────────────────────               │
│                                                 │
│   <article content>                             │
│                                                 │
└─────────────────────────────────────────────────┘
```

**Features:**
- Scrollable content
- Responsive max-width
- HTML rendering
- Theme support (light/dark/sepia)
- Font size adjustment
- Scroll position persistence

**Reader Settings:**
```dart
class ReaderSettings {
  final ReaderTheme theme;
  final double fontSize; // 14-24
  final double lineHeight; // 1.4-2.0
  
  static const defaults = ReaderSettings(
    theme: ReaderTheme.system,
    fontSize: 18,
    lineHeight: 1.7,
  );
}

enum ReaderTheme { light, dark, sepia, system }
```

---

### 5. Offline Banner

**Purpose:** Indicate offline status

**Anatomy:**
```
┌─────────────────────────────────────────────────┐
│ 📴 Offline - Reading from saved content    [✕] │
└─────────────────────────────────────────────────┘
```

**Behavior:**
- Shows when connectivity lost
- Dismissible (won't show again until reconnect + disconnect)
- Subtle, non-intrusive
- Positioned at top of content area

**Code Example:**
```dart
class OfflineBanner extends StatelessWidget {
  final VoidCallback onDismiss;

  const OfflineBanner({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offlineBanner,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Icon(Icons.cloud_off, size: 18),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Offline - Reading from saved content',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, size: 18),
            onPressed: onDismiss,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
```

---

### 6. Loading Skeleton

**Purpose:** Show placeholder while loading

**Article Card Skeleton:**
```
┌─────────────────────────────────────────────────┐
│ ┌────────┐                                      │
│ │ ░░░░░░ │  ░░░░░░░░░░░░░░░░░░░░               │
│ │ ░░░░░░ │  ░░░░░░░░░░ • ░░░░░                 │
│ │ ░░░░░░ │  ░░░░░░░░░░░░░                      │
│ └────────┘                                      │
└─────────────────────────────────────────────────┘
```

**Code Example:**
```dart
class ArticleCardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.cardPadding),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 16, color: Colors.white),
                    SizedBox(height: 8),
                    Container(height: 12, width: 150, color: Colors.white),
                    SizedBox(height: 8),
                    Container(height: 12, width: 100, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### 7. Snackbar Messages

**Purpose:** Provide feedback on actions

**Variants:**
```
SUCCESS:
┌─────────────────────────────────────────────────┐
│ ✓  Article saved                       [OPEN]  │
└─────────────────────────────────────────────────┘

ERROR:
┌─────────────────────────────────────────────────┐
│ ✕  Couldn't save article              [RETRY]  │
└─────────────────────────────────────────────────┘

UNDO:
┌─────────────────────────────────────────────────┐
│    Article deleted                     [UNDO]  │
└─────────────────────────────────────────────────┘
```

**Usage:**
```dart
void showSuccessSnackbar(BuildContext context, String message, {String? action, VoidCallback? onAction}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.success),
          SizedBox(width: AppSpacing.sm),
          Text(message),
        ],
      ),
      action: action != null
          ? SnackBarAction(label: action, onPressed: onAction ?? () {})
          : null,
      duration: AppDurations.snackbarDuration,
    ),
  );
}
```

---

## Screen Layouts

### Home Screen Layout

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stash It'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: ArticleListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUrlSheet(context),
        child: Icon(Icons.add),
        tooltip: 'Save article',
      ),
    );
  }
}
```

### Settings Screen Layout

```dart
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          _buildSection('APPEARANCE', [
            ListTile(
              title: Text('Theme'),
              trailing: DropdownButton(...),
            ),
            ListTile(
              title: Text('Reader Theme'),
              trailing: DropdownButton(...),
            ),
          ]),
          _buildSection('READING', [
            ListTile(
              title: Text('Font Size'),
              subtitle: Slider(...),
            ),
            SwitchListTile(
              title: Text('Auto-mark as read'),
              value: settings.autoMarkRead,
              onChanged: (v) => updateSettings(...),
            ),
          ]),
          _buildSection('DATA', [
            ListTile(
              title: Text('Storage Used'),
              trailing: Text('156 MB'),
            ),
            ListTile(
              title: Text('Clear Image Cache'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => ...,
            ),
          ]),
          _buildSection('ABOUT', [
            ListTile(
              title: Text('Version'),
              trailing: Text('1.0.0'),
            ),
          ]),
        ],
      ),
    );
  }
}
```

---

## Animation Specifications

### Page Transitions

| From | To | Animation |
|------|-----|-----------|
| List → Reader | Slide up + shared element (image) |
| Reader → List | Slide down |
| Any → Sheet | Bottom sheet slide up |
| Any → Settings | Slide from right |

### Micro-animations

| Action | Animation | Duration |
|--------|-----------|----------|
| Card press | Scale 0.98 + opacity 0.8 | 100ms |
| FAB press | Ripple + scale 0.95 | 150ms |
| Delete swipe | Slide out + fade | 300ms |
| Snackbar | Slide up from bottom | 200ms |
| Shimmer | Left-to-right gradient | 1500ms loop |

---

## Accessibility Checklist

- [ ] All images have contentDescription
- [ ] Touch targets minimum 48dp
- [ ] Color contrast ≥ 4.5:1
- [ ] Focus indicators visible
- [ ] Screen reader announcements for actions
- [ ] Dynamic text scaling supported
- [ ] Reduce motion option respected
- [ ] Error messages descriptive

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-11-25 | Product Owner | Initial component library |
