# Stash It - User Personas

**Created:** November 25, 2025  
**Version:** 1.0  
**Status:** Draft

---

## Primary Personas

### 👤 Persona 1: Maya - The Privacy-Conscious Reader

**Demographics:**
- Age: 32
- Occupation: Software Engineer
- Location: San Francisco, CA
- Devices: Pixel phone, MacBook, Linux desktop

**Bio:**
Maya is a senior developer who values open source and data privacy. She uses Firefox with strict tracking protection, prefers self-hosted solutions, and actively avoids services that monetize user data. She reads extensively about technology, security, and software development.

**Goals:**
- Save interesting articles without creating another account
- Read articles on her commute (BART has spotty connectivity)
- Own her data and export it anytime
- Eventually sync between her phone and laptop without cloud

**Frustrations:**
- Pocket requires an account and tracks reading habits
- Most apps send data to servers she doesn't control
- Losing saved content when services shut down
- Can't easily move data between apps

**Tech Savviness:** ★★★★★ (Expert)

**Quote:**
> "I just want to save an article, not give away my reading history."

**Key Scenarios:**
1. Finds an article on HN, shares to Stash It while scrolling
2. Reads saved articles on the train with no signal
3. Exports all articles yearly as backup
4. Syncs phone with laptop over local WiFi (future)

**Success Metrics:**
- Zero data sent to external servers
- Works 100% offline
- Easy data export

---

### 👤 Persona 2: Daniel - The Subway Commuter

**Demographics:**
- Age: 28
- Occupation: Marketing Manager
- Location: New York City
- Devices: iPhone, iPad

**Bio:**
Daniel has a 45-minute subway commute each way. Cell service is unreliable underground, so he needs content ready before he descends. He saves articles throughout the day from Twitter, newsletters, and Slack, then catches up during his commute.

**Goals:**
- Quickly save articles to read later
- Read offline during commute without issues
- Get through his reading list efficiently
- Not think about syncing or connectivity

**Frustrations:**
- Articles that won't load when he's offline
- Cluttered reading experiences with popups
- Managing too many apps and accounts
- Lost scroll position when resuming articles

**Tech Savviness:** ★★★☆☆ (Average)

**Quote:**
> "I have 45 minutes twice a day. Don't waste my time with loading spinners."

**Key Scenarios:**
1. Saves 3-5 articles during morning coffee
2. Opens Stash It on subway, picks article by reading time
3. Reads 2 articles per commute
4. Deletes or archives finished articles weekly

**Success Metrics:**
- Save takes <3 seconds
- Articles always available offline
- Reading time estimates are accurate

---

### 👤 Persona 3: Dr. Sarah - The Academic Researcher

**Demographics:**
- Age: 45
- Occupation: Professor of Economics
- Location: Boston, MA
- Devices: Samsung phone, Windows laptop, Kindle

**Bio:**
Sarah collects research papers, news articles, and blog posts for her work. She saves dozens of items per week and needs to organize them by project and topic. She often references saved articles in her writing and teaching.

**Goals:**
- Save large volumes of content without slowdown
- Organize by research project using tags
- Search full text of saved articles
- Keep articles for years (archival)

**Frustrations:**
- Running out of cloud storage
- Poor search in other apps
- Losing organization when switching tools
- Articles that expire or disappear

**Tech Savviness:** ★★★☆☆ (Average)

**Quote:**
> "I saved it somewhere, but I can't find it when I need it."

**Key Scenarios:**
1. Saves 10+ articles from journals and news sites
2. Tags each with project name and topic
3. Searches for "inflation data 2024" across all saves
4. Exports bibliography of tagged articles

**Success Metrics:**
- Can save 1000+ articles without issues
- Tags and search work reliably
- Storage is transparent and manageable

---

### 👤 Persona 4: Tom - The Minimalist

**Demographics:**
- Age: 24
- Occupation: Freelance Designer
- Location: Austin, TX
- Devices: iPhone only

**Bio:**
Tom avoids subscription services and account-based apps. He prefers simple, focused tools that do one thing well. He reads a few articles per week, mostly design and tech content.

**Goals:**
- Save occasional interesting finds
- Read without distractions
- Not manage another account or subscription
- Simple app that stays out of the way

**Frustrations:**
- Apps that nag for sign-up
- Premium features paywalled
- Bloated apps with features he doesn't need
- Complicated interfaces

**Tech Savviness:** ★★★★☆ (Good)

**Quote:**
> "An app should do one thing and do it well."

**Key Scenarios:**
1. Saves 2-3 articles per week from Twitter
2. Reads when he has downtime
3. Deletes after reading
4. Never opens settings

**Success Metrics:**
- Works on first launch, no setup
- No accounts, no premium upsells
- Clean, minimal interface

---

## Secondary Personas

### 👤 Persona 5: Alex - The Multi-Device User

**Demographics:**
- Age: 38
- Occupation: Product Manager
- Location: Seattle, WA
- Devices: iPhone, iPad Pro, MacBook Air

**Bio:**
Alex switches between devices constantly. She might save an article on her phone during lunch, start reading on her iPad at home, and finish on her laptop at work. Seamless sync is critical.

**Goals:**
- Save on any device, read on any device
- Automatic sync without thinking
- Same reading position across devices
- No duplicate saves

**Frustrations:**
- Cloud sync that's slow or unreliable
- Having to re-download content on each device
- Sync conflicts that lose data
- Privacy concerns with cloud sync

**Tech Savviness:** ★★★★☆ (Good)

**Quote:**
> "I don't care where I saved it, I just want it on the device I'm using now."

**Key Scenarios:**
1. Saves article on phone
2. Gets home, article is on iPad
3. P2P sync when devices on same WiFi
4. Continues reading where she left off

**Success Metrics (v3.0):**
- Devices sync within 1 minute on same network
- No cloud account required
- Sync progress visible but not intrusive

---

### 👤 Persona 6: James - The Content Curator

**Demographics:**
- Age: 50
- Occupation: Journalist
- Location: Washington, D.C.
- Devices: iPhone, MacBook

**Bio:**
James collects articles for research, story ideas, and sharing with colleagues. He often sends article links to teammates and needs to organize content by story topic.

**Goals:**
- Quickly save content for later review
- Share saved articles with others
- Organize by story/project
- Export collections for reference

**Frustrations:**
- Can't share read-later collections
- Losing context of why something was saved
- Disorganized piles of saves
- Articles that go behind paywalls

**Tech Savviness:** ★★★☆☆ (Average)

**Quote:**
> "I save 50 articles for every story I write. I need to find the good ones."

**Key Scenarios:**
1. Saves articles from various sources for story research
2. Tags with story code: #election-2026
3. Reviews and rates saved articles
4. Exports collection as reading list for editor

**Success Metrics:**
- Bulk organization tools
- Easy sharing of collections
- Reliable article archiving

---

## Persona Comparison Matrix

| Attribute | Maya | Daniel | Sarah | Tom | Alex | James |
|-----------|------|--------|-------|-----|------|-------|
| **Tech Level** | Expert | Average | Average | Good | Good | Average |
| **Volume** | Medium | Low | High | Low | Medium | High |
| **Offline Need** | High | Critical | Medium | Medium | Medium | Low |
| **Privacy Focus** | Critical | Low | Medium | Medium | High | Low |
| **Sync Need** | Future | None | Low | None | Critical | Medium |
| **Organization** | Tags | Simple | Tags+Search | None | Basic | Tags |

---

## Design Implications

### From Maya (Privacy)
- No accounts, no tracking
- Local-first architecture
- Transparent data handling
- Export in open formats

### From Daniel (Commuter)
- Fast, reliable offline
- Reading time estimates
- Remember scroll position
- Quick save flow

### From Sarah (Researcher)
- Robust tagging system
- Full-text search
- Handle large libraries
- Long-term storage

### From Tom (Minimalist)
- Simple onboarding
- No upsells or nags
- Clean, focused UI
- Progressive disclosure

### From Alex (Multi-Device)
- P2P sync architecture
- Conflict resolution
- Cross-platform consistency
- Sync status visibility

### From James (Curator)
- Bulk actions
- Sharing features
- Collection exports
- Note-taking (future)

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-11-25 | Product Owner | Initial personas |
