# Stash It - UX Quick Reference

**For:** Development Team  
**Version:** MVP (v1.0)

---

## 📱 Screen Map

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│  ┌──────────────┐      ┌──────────────┐      ┌──────────────┐  │
│  │              │      │              │      │              │  │
│  │    HOME      │─────▶│   READER     │      │   SETTINGS   │  │
│  │   (List)     │      │   (View)     │      │              │  │
│  │              │      │              │      │              │  │
│  └──────────────┘      └──────────────┘      └──────────────┘  │
│         │                                           ▲          │
│         │                                           │          │
│         ▼                                           │          │
│  ┌──────────────┐                                   │          │
│  │   ADD URL    │                      ─────────────┘          │
│  │   (Sheet)    │                                              │
│  └──────────────┘                                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🎯 Primary User Flows

### Flow 1: Save from Browser
```
Browser → Share → Stash It → Toast "Saved!" → (Optional) Open app
```

### Flow 2: Save in App
```
Home → FAB (+) → Paste URL → Save → New item in list
```

### Flow 3: Read Article
```
Home → Tap card → Reader → Scroll → Auto-mark read → Back
```

### Flow 4: Delete Article
```
Home → Swipe left → Confirm → "Deleted" snackbar → [UNDO]
```

---

## 🧩 Core Components

| Component | Location | Purpose |
|-----------|----------|---------|
| `ArticleCard` | Home list | Display saved article |
| `EmptyState` | Home (no items) | Onboarding CTA |
| `AddUrlSheet` | Bottom sheet | Manual URL input |
| `ReaderView` | Full screen | Article reading |
| `OfflineBanner` | Top of list | Connectivity status |
| `LoadingSkeleton` | List loading | Placeholder animation |

---

## 🎨 Theme Quick Reference

### Colors
```
Primary:     #6750A4 (Purple)
Surface:     #FFFBFE (White-ish)
Error:       #F44336 (Red)
Success:     #4CAF50 (Green)
```

### Reader Themes
```
Light:  White bg, dark text
Dark:   Dark bg, light text  
Sepia:  Cream bg, brown text
```

### Spacing Scale
```
xs: 4dp   sm: 8dp   md: 16dp   lg: 24dp   xl: 32dp
```

---

## ✋ Gestures

| Gesture | Element | Action |
|---------|---------|--------|
| Tap | Article card | Open reader |
| Swipe left | Article card | Delete |
| Tap | FAB | Open add URL |
| Pull down | List | Refresh |
| Tap | Back arrow | Navigate back |

---

## 📊 Article Card States

```
┌─────────────────────────────────────┐
│ UNREAD                           ●  │  ← Purple dot
│ Full opacity                        │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ READ                                │  ← No dot
│ Opacity 0.7                         │  ← Slightly faded
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ LOADING                             │
│ ░░░░░░░░░░░ Shimmer animation       │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ ERROR                          ⚠️   │
│ [Retry] button visible              │
└─────────────────────────────────────┘
```

---

## 💬 Feedback Messages

### Snackbars
| Action | Message | Action Button |
|--------|---------|---------------|
| Save success | "Article saved" | OPEN |
| Save offline | "Saved for later" | - |
| Save error | "Couldn't save" | RETRY |
| Delete | "Article deleted" | UNDO |

### Toasts (Share Intent)
| State | Message |
|-------|---------|
| Saving | "Saving article..." |
| Success | "Saved!" |
| Queued | "Saved for later" |
| Error | "Couldn't save. Tap to retry." |

---

## 📐 Layout Specs

### Article Card
```
Height: min 88dp
Padding: 16dp all sides
Thumbnail: 72x72dp
Title: max 2 lines
Spacing between elements: 8dp
```

### Reader View
```
Max width: 680dp (centered on large screens)
Horizontal padding: 24dp
Font size: 18dp (adjustable 14-24)
Line height: 1.7
```

### Touch Targets
```
Minimum: 48x48dp
FAB: 56x56dp
Icon buttons: 48x48dp
```

---

## ⏱️ Animation Timings

| Animation | Duration |
|-----------|----------|
| Button press | 100ms |
| Page transition | 300ms |
| Snackbar appear | 200ms |
| Delete slide | 300ms |
| Shimmer cycle | 1500ms |

---

## ♿ Accessibility Checklist

- [ ] All images have alt text
- [ ] Touch targets ≥ 48dp
- [ ] Color contrast ≥ 4.5:1
- [ ] Screen reader labels on actions
- [ ] Dynamic type supported
- [ ] Focus visible
- [ ] Error messages descriptive

---

## 📁 File Structure for UI

```
lib/
├── core/
│   └── theme/
│       ├── app_colors.dart
│       ├── app_typography.dart
│       ├── app_spacing.dart
│       └── app_theme.dart
├── shared/
│   └── widgets/
│       ├── empty_state.dart
│       ├── loading_skeleton.dart
│       ├── offline_banner.dart
│       └── snackbar_helper.dart
└── features/
    ├── articles/
    │   └── presentation/
    │       ├── pages/
    │       │   ├── home_page.dart
    │       │   └── reader_page.dart
    │       └── widgets/
    │           ├── article_card.dart
    │           ├── article_list.dart
    │           └── add_url_sheet.dart
    └── settings/
        └── presentation/
            └── pages/
                └── settings_page.dart
```

---

## 📖 Full Documentation

| Document | Content |
|----------|---------|
| [UX_DESIGN.md](./UX_DESIGN.md) | Complete UX specification |
| [PERSONAS.md](./PERSONAS.md) | User personas |
| [DESIGN_SYSTEM.md](./DESIGN_SYSTEM.md) | Component specs & code |
| [USER_STORIES.md](./USER_STORIES.md) | Feature requirements |

---

*Last updated: November 25, 2025*
