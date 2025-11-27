# Stash It - MVP Roadmap

**Created:** November 25, 2025  
**Version:** 1.0  
**Status:** Draft  
**Timeline:** 4 Weeks

---

## MVP Scope Definition

### What's IN Scope ✅

| Feature | Description |
|---------|-------------|
| **Save via Share** | Save URLs from any app using system share |
| **Save via Input** | Paste/type URLs directly in app |
| **Content Extraction** | Automatically extract article content |
| **Offline Storage** | Store articles and images locally |
| **Article List** | Browse all saved articles |
| **Reader View** | Clean reading experience |
| **Delete Articles** | Remove unwanted saves |
| **Basic Theming** | Light/Dark mode support |

### What's OUT of Scope ❌ (Post-MVP)

| Feature | Planned Version |
|---------|-----------------|
| Tags | v1.5 |
| Full-text Search | v1.5 |
| Archive | v1.5 |
| Favorites | v2.0 |
| Import/Export | v1.5/v2.0 |
| P2P Sync | v3.0 |
| Text-to-Speech | v2.0+ |
| Highlights/Annotations | v2.0+ |
| Browser Extension | v2.0+ |

---

## Sprint Plan (4 x 1-Week Sprints)

### Sprint 1: Foundation 🏗️
**Goal:** Project architecture and local database

| Task | Story Points | Dependencies |
|------|--------------|--------------|
| Set up project structure (Clean Architecture) | 3 | - |
| Configure dependencies (pubspec.yaml) | 2 | - |
| Create Article entity and data models | 3 | - |
| Implement Isar database schema | 5 | Models |
| Create ArticleRepository interface | 3 | Entity |
| Implement local ArticleRepository | 5 | Database |
| Add basic theme configuration | 2 | - |
| **Sprint Total** | **23** | |

**Deliverables:**
- [ ] Working database with CRUD operations
- [ ] Unit tests for repository
- [ ] Basic app shell with routing

---

### Sprint 2: Save & Extract 📥
**Goal:** Save URLs and extract article content

| Task | Story Points | Dependencies |
|------|--------------|--------------|
| Create Save URL use case | 3 | Repository |
| Implement share intent receiver (Android) | 5 | - |
| Build "Add URL" input UI | 3 | - |
| Create ContentExtractor service | 8 | - |
| Implement HTML parsing and cleaning | 5 | Extractor |
| Download and cache images | 5 | Extractor |
| Handle offline save (queue) | 3 | Repository |
| **Sprint Total** | **37** | |

**Deliverables:**
- [ ] Can save URLs via share from browser
- [ ] Content extracted and stored locally
- [ ] Images cached for offline viewing
- [ ] Offline saves queued for later processing

---

### Sprint 3: List & Read 📖
**Goal:** View articles and reader experience

| Task | Story Points | Dependencies |
|------|--------------|--------------|
| Build Article List page | 5 | Repository |
| Create article card widget | 3 | - |
| Implement pull-to-refresh | 2 | - |
| Add empty state UI | 2 | - |
| Build Reader View page | 5 | - |
| Implement reading typography | 3 | Reader |
| Add swipe-to-delete | 3 | List |
| Implement "Open Original" | 2 | Reader |
| Add loading/error states | 3 | - |
| **Sprint Total** | **28** | |

**Deliverables:**
- [ ] Article list showing all saves
- [ ] Tap to open in reader view
- [ ] Clean, readable article display
- [ ] Swipe to delete articles

---

### Sprint 4: Polish & Ship 🚀
**Goal:** Quality, edge cases, and release prep

| Task | Story Points | Dependencies |
|------|--------------|--------------|
| Light/Dark theme toggle | 3 | - |
| Settings page (theme selection) | 3 | - |
| Offline indicator UI | 2 | - |
| Error handling & retry logic | 5 | - |
| Reading time calculation | 2 | - |
| Mark as read functionality | 3 | - |
| App icon and splash screen | 3 | - |
| Testing and bug fixes | 8 | All |
| Documentation and README | 3 | - |
| **Sprint Total** | **32** | |

**Deliverables:**
- [ ] Polished UI with theme support
- [ ] Robust error handling
- [ ] App ready for release
- [ ] Updated documentation

---

## Total Effort Summary

| Sprint | Points | Focus Area |
|--------|--------|------------|
| Sprint 1 | 23 | Foundation |
| Sprint 2 | 37 | Saving |
| Sprint 3 | 28 | Viewing |
| Sprint 4 | 32 | Polish |
| **Total** | **120** | |

**Velocity Assumption:** ~30 points per sprint (1 developer)

---

## Risk Register

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Content extraction fails on many sites | Medium | High | Fallback to simple HTML view |
| Share intent differences between platforms | Medium | Medium | Platform-specific implementation |
| Image caching uses too much storage | Low | Medium | Compress images, add cache limit |
| Isar database learning curve | Low | Low | Good documentation available |

---

## Definition of Done (MVP)

### Feature Complete
- [ ] Save URLs via share intent (Android)
- [ ] Save URLs via manual input
- [ ] Content extraction working for major sites
- [ ] Articles stored locally with images
- [ ] Full offline reading capability
- [ ] Article list with sorting
- [ ] Reader view with good typography
- [ ] Delete functionality
- [ ] Light/Dark theme
- [ ] Mark as read

### Quality Gates
- [ ] No critical bugs
- [ ] 60%+ test coverage
- [ ] Works offline completely
- [ ] <2s cold start time
- [ ] Tested on Android

### Documentation
- [ ] README updated
- [ ] Architecture documented
- [ ] User guide created

---

## Post-MVP Priorities

### v1.5 Priorities (Immediately After MVP)
1. **Tags** - High user value, enables organization
2. **Full-text Search** - Essential for large collections
3. **Archive** - Keeps list manageable
4. **Export** - Data ownership promise

### v2.0 Priorities
1. **Import from Pocket** - Migration path
2. **Favorites** - Quick access to important items
3. **Reader Customization** - Font size, spacing
4. **Storage Management** - User control

### v3.0 Priorities
1. **P2P Sync Foundation** - Device discovery
2. **CRDT Implementation** - Conflict-free sync
3. **Sync UI** - User-facing sync controls

---

## Success Criteria (MVP Launch)

| Metric | Target |
|--------|--------|
| Save success rate | >90% |
| Crash-free sessions | >99% |
| Cold start time | <2s |
| Works fully offline | Yes |
| Platforms | Android only |

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-11-25 | Product Owner | Initial MVP roadmap |
