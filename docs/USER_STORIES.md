# Stash It - User Stories

**Created:** November 25, 2025  
**Version:** 1.0  
**Status:** Draft  
**Sprint/Milestone:** MVP (v1.0)

---

## Epic 1: Content Saving

### US-1.1: Save URL via Share Intent
**As a** mobile user  
**I want to** share a URL from any app to Stash It  
**So that** I can quickly save content without opening the app

**Acceptance Criteria:**
- [ ] App appears in Android share sheet
- [ ] URL is captured and saved immediately
- [ ] Brief toast/notification confirms save
- [ ] Works offline (queues for content fetch later)
- [ ] Handles duplicate URLs gracefully (option to save again or skip)

**Priority:** P0 (Must Have)  
**Story Points:** 5

---

### US-1.2: Save URL via In-App Input
**As a** user  
**I want to** paste or type a URL directly in the app  
**So that** I can save content when copy-pasting URLs

**Acceptance Criteria:**
- [ ] Text input field on home screen or via FAB
- [ ] Validates URL format before saving
- [ ] Shows loading state while fetching content
- [ ] Displays error message for invalid URLs
- [ ] Supports paste from clipboard with one tap

**Priority:** P0 (Must Have)  
**Story Points:** 3

---

### US-1.3: Auto-Extract Article Content
**As a** user  
**I want** the app to automatically extract the main article content  
**So that** I get a clean, readable version without ads and clutter

**Acceptance Criteria:**
- [ ] Extracts title, author, publication date
- [ ] Extracts main article body (text + images)
- [ ] Removes ads, navigation, sidebars
- [ ] Preserves essential formatting (headings, lists, quotes)
- [ ] Falls back to full page if extraction fails
- [ ] Shows extraction status/progress

**Priority:** P0 (Must Have)  
**Story Points:** 8

---

### US-1.4: Save Article for Offline Reading
**As a** user  
**I want** saved articles to be available offline  
**So that** I can read without internet connection

**Acceptance Criteria:**
- [ ] Article text stored in local database
- [ ] Images downloaded and cached locally
- [ ] Offline indicator shown when no connection
- [ ] Articles open instantly when offline
- [ ] Storage size shown per article (optional)

**Priority:** P0 (Must Have)  
**Story Points:** 5

---

### US-1.5: Save Plain Text Note
**As a** user  
**I want to** save plain text notes or quotes  
**So that** I can stash text snippets that aren't from URLs

**Acceptance Criteria:**
- [ ] "Add Note" option in addition to URL
- [ ] Rich text input field
- [ ] Saved with timestamp
- [ ] Searchable like articles
- [ ] Can optionally add source URL reference

**Priority:** P2 (Nice to Have)  
**Story Points:** 3

---

## Epic 2: Reading Experience

### US-2.1: Read Saved Article
**As a** user  
**I want to** open and read my saved articles  
**So that** I can consume content I've stashed

**Acceptance Criteria:**
- [ ] Tap article to open reader view
- [ ] Clean, distraction-free reading layout
- [ ] Proper typography (readable fonts, spacing)
- [ ] Images display inline
- [ ] Scroll position remembered if interrupted

**Priority:** P0 (Must Have)  
**Story Points:** 5

---

### US-2.2: Customize Reading Settings
**As a** user  
**I want to** adjust font size, theme, and spacing  
**So that** I can read comfortably in any environment

**Acceptance Criteria:**
- [ ] Font size slider (small to large)
- [ ] Theme options: Light, Dark, Sepia, System
- [ ] Line spacing adjustment
- [ ] Settings persist across sessions
- [ ] Preview changes in real-time

**Priority:** P1 (Should Have)  
**Story Points:** 5

---

### US-2.3: View Original Page
**As a** user  
**I want to** open the original URL in a browser  
**So that** I can see the full page if extraction missed something

**Acceptance Criteria:**
- [ ] "Open Original" button in reader view
- [ ] Opens in in-app browser or external browser
- [ ] Indicates if device is offline
- [ ] Works from article detail screen

**Priority:** P1 (Should Have)  
**Story Points:** 2

---

### US-2.4: Mark as Read/Unread
**As a** user  
**I want to** mark articles as read or unread  
**So that** I can track what I've consumed

**Acceptance Criteria:**
- [ ] Auto-mark as read when opened (configurable)
- [ ] Manual toggle for read/unread status
- [ ] Visual indicator in list (opacity, checkmark)
- [ ] Filter by read/unread status

**Priority:** P1 (Should Have)  
**Story Points:** 3

---

### US-2.5: Estimate Reading Time
**As a** user  
**I want to** see estimated reading time for each article  
**So that** I can pick articles that fit my available time

**Acceptance Criteria:**
- [ ] Calculate based on word count (~200 wpm)
- [ ] Display in list view and detail view
- [ ] Format: "5 min read"

**Priority:** P2 (Nice to Have)  
**Story Points:** 1

---

## Epic 3: Content Organization

### US-3.1: View All Saved Items
**As a** user  
**I want to** see a list of all my saved items  
**So that** I can browse and pick what to read

**Acceptance Criteria:**
- [ ] List view showing title, source, date, thumbnail
- [ ] Sort by: Date saved (default), Title, Source
- [ ] Pull-to-refresh (if online)
- [ ] Empty state with call-to-action
- [ ] Shows total count

**Priority:** P0 (Must Have)  
**Story Points:** 5

---

### US-3.2: Search Saved Content
**As a** user  
**I want to** search my saved articles  
**So that** I can find specific content quickly

**Acceptance Criteria:**
- [ ] Search by title, content, source
- [ ] Full-text search works offline
- [ ] Search-as-you-type with debouncing
- [ ] Highlight matched terms in results
- [ ] Recent searches remembered

**Priority:** P1 (Should Have)  
**Story Points:** 5

---

### US-3.3: Add Tags to Articles
**As a** user  
**I want to** tag my articles  
**So that** I can organize content by topic

**Acceptance Criteria:**
- [ ] Add one or more tags to any item
- [ ] Create new tags inline
- [ ] Autocomplete existing tags
- [ ] Filter list by tag
- [ ] Tag management (rename, delete, merge)

**Priority:** P1 (Should Have)  
**Story Points:** 5

---

### US-3.4: Archive Items
**As a** user  
**I want to** archive articles I've finished  
**So that** my main list stays focused on unread content

**Acceptance Criteria:**
- [ ] Swipe or button to archive
- [ ] Archived items hidden from main list
- [ ] Access archived items via filter/tab
- [ ] Unarchive option available
- [ ] Archive ≠ Delete (still searchable)

**Priority:** P1 (Should Have)  
**Story Points:** 3

---

### US-3.5: Delete Items
**As a** user  
**I want to** delete articles I no longer need  
**So that** I can manage my storage and reduce clutter

**Acceptance Criteria:**
- [ ] Swipe or button to delete
- [ ] Confirmation dialog for single delete
- [ ] Bulk delete option
- [ ] Permanent deletion (recoverable for 30 days?)
- [ ] Frees up local storage

**Priority:** P0 (Must Have)  
**Story Points:** 2

---

### US-3.6: Favorite/Star Items
**As a** user  
**I want to** favorite important articles  
**So that** I can quickly access my best saves

**Acceptance Criteria:**
- [ ] Star/heart icon toggle
- [ ] Filter by favorites
- [ ] Favorites section in navigation
- [ ] Visual distinction in list

**Priority:** P2 (Nice to Have)  
**Story Points:** 2

---

## Epic 4: Data Management

### US-4.1: Persist Data Locally
**As a** user  
**I want** my data stored securely on my device  
**So that** I own my content and it's always available

**Acceptance Criteria:**
- [ ] Use SQLite/Isar for structured data
- [ ] Store articles, tags, settings locally
- [ ] Data survives app updates
- [ ] No data sent to external servers
- [ ] Encryption at rest (optional setting)

**Priority:** P0 (Must Have)  
**Story Points:** 5

---

### US-4.2: Export Data
**As a** user  
**I want to** export all my saved content  
**So that** I can backup or migrate to another app

**Acceptance Criteria:**
- [ ] Export to JSON format
- [ ] Export to HTML (readable format)
- [ ] Include: articles, tags, metadata
- [ ] Share export file via system share
- [ ] Export specific items or all

**Priority:** P1 (Should Have)  
**Story Points:** 3

---

### US-4.3: Import Data
**As a** user  
**I want to** import content from other apps  
**So that** I can migrate from Pocket/Instapaper

**Acceptance Criteria:**
- [ ] Import from Pocket export (HTML)
- [ ] Import from Instapaper CSV
- [ ] Import from Stash It backup
- [ ] Merge with existing data (no duplicates)
- [ ] Import progress indicator

**Priority:** P2 (Nice to Have)  
**Story Points:** 5

---

### US-4.4: View Storage Usage
**As a** user  
**I want to** see how much storage Stash It is using  
**So that** I can manage device space

**Acceptance Criteria:**
- [ ] Total storage used in Settings
- [ ] Breakdown: articles, images, database
- [ ] Clear cache option (images only)
- [ ] Per-article storage size

**Priority:** P2 (Nice to Have)  
**Story Points:** 2

---

## Epic 5: App Settings & Preferences

### US-5.1: Configure Theme
**As a** user  
**I want to** choose light or dark theme  
**So that** the app matches my preference and environment

**Acceptance Criteria:**
- [ ] Light, Dark, System (follow device) options
- [ ] Instant switch, no restart required
- [ ] Persists across sessions
- [ ] Consistent across all screens

**Priority:** P1 (Should Have)  
**Story Points:** 3

---

### US-5.2: Configure Default Behaviors
**As a** user  
**I want to** customize default app behaviors  
**So that** the app works the way I prefer

**Acceptance Criteria:**
- [ ] Auto-mark read: on/off
- [ ] Default sort order
- [ ] Show/hide archived in search
- [ ] Confirm before delete: on/off

**Priority:** P2 (Nice to Have)  
**Story Points:** 2

---

### US-5.3: View App Information
**As a** user  
**I want to** see app version and information  
**So that** I can troubleshoot or report issues

**Acceptance Criteria:**
- [ ] Version number
- [ ] Open source licenses
- [ ] Link to GitHub/website
- [ ] Privacy policy
- [ ] Contact/feedback option

**Priority:** P2 (Nice to Have)  
**Story Points:** 1

---

## Epic 6: P2P Sync (Future - v3.0)

### US-6.1: Discover Nearby Devices
**As a** user  
**I want to** find my other devices on the same network  
**So that** I can sync without internet

**Acceptance Criteria:**
- [ ] Auto-discover devices on local network
- [ ] Show device name/type
- [ ] Pairing confirmation required
- [ ] Remember paired devices

**Priority:** P3 (Future)  
**Story Points:** 8

---

### US-6.2: Sync Data Between Devices
**As a** user  
**I want to** sync my saved articles between devices  
**So that** I have the same content everywhere

**Acceptance Criteria:**
- [ ] Bi-directional sync
- [ ] Conflict resolution (CRDT-based)
- [ ] Selective sync (tags/collections)
- [ ] Sync progress indicator
- [ ] Works without internet

**Priority:** P3 (Future)  
**Story Points:** 13

---

### US-6.3: Manual Sync Trigger
**As a** user  
**I want to** manually trigger sync  
**So that** I can control when syncing happens

**Acceptance Criteria:**
- [ ] Sync button in app
- [ ] Shows last sync timestamp
- [ ] Indicates sync status (in progress, complete, failed)
- [ ] Option for auto-sync when on same network

**Priority:** P3 (Future)  
**Story Points:** 3

---

## Story Map Summary

| Epic | P0 (MVP) | P1 (v1.5) | P2 (v2.0) | P3 (v3.0) |
|------|----------|-----------|-----------|-----------|
| **Content Saving** | US-1.1, US-1.2, US-1.3, US-1.4 | | US-1.5 | |
| **Reading Experience** | US-2.1 | US-2.2, US-2.3, US-2.4 | US-2.5 | |
| **Content Organization** | US-3.1, US-3.5 | US-3.2, US-3.3, US-3.4 | US-3.6 | |
| **Data Management** | US-4.1 | US-4.2 | US-4.3, US-4.4 | |
| **Settings** | | US-5.1 | US-5.2, US-5.3 | |
| **P2P Sync** | | | | US-6.1, US-6.2, US-6.3 |

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-11-25 | Product Owner | Initial user stories |
