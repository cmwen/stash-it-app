import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/theme.dart';
import '../../domain/entities/article.dart';
import '../providers/providers.dart';

/// Reader page for viewing article content.
class ReaderPage extends ConsumerStatefulWidget {
  final String articleId;

  const ReaderPage({
    super.key,
    required this.articleId,
  });

  @override
  ConsumerState<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends ConsumerState<ReaderPage> {
  final _scrollController = ScrollController();
  bool _hasMarkedAsRead = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_hasMarkedAsRead && _scrollController.hasClients) {
      final position = _scrollController.position;
      final progress = position.pixels / position.maxScrollExtent;
      
      // Mark as read when scrolled 50% or reached the bottom
      if (progress > 0.5 || position.pixels >= position.maxScrollExtent - 100) {
        _hasMarkedAsRead = true;
        ref.read(articleNotifierProvider.notifier).markAsRead(widget.articleId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final articleAsync = ref.watch(articleProvider(widget.articleId));
    
    return articleAsync.when(
      data: (article) {
        if (article == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Article not found'),
            ),
          );
        }
        
        return _buildReaderView(context, article);
      },
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64),
              const SizedBox(height: AppSpacing.md),
              Text('Error loading article: $error'),
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: () => ref.invalidate(articleProvider(widget.articleId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReaderView(BuildContext context, Article article) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) => _handleMenuAction(value, article),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'original',
                    child: ListTile(
                      leading: Icon(Icons.open_in_browser),
                      title: Text('Open original'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'read_status',
                    child: ListTile(
                      leading: Icon(article.isRead ? Icons.mark_email_unread : Icons.mark_email_read),
                      title: Text(article.isRead ? 'Mark as unread' : 'Mark as read'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete, color: AppColors.error),
                      title: Text('Delete', style: TextStyle(color: AppColors.error)),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: _buildArticleContent(context, article),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleContent(BuildContext context, Article article) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth > AppSpacing.readerMaxWidth
        ? (screenWidth - AppSpacing.readerMaxWidth) / 2
        : AppSpacing.readerHorizontalPadding;
    
    // Handle failed or pending articles
    if (article.status == ArticleStatus.failed) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Failed to load article content',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'This site may not be supported, or there was a network error.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => _openOriginal(article.url),
                        icon: const Icon(Icons.open_in_browser),
                        label: const Text('Open Original'),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      FilledButton.icon(
                        onPressed: () {
                          ref.read(articleNotifierProvider.notifier)
                              .retryFetch(article.id);
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    
    if (article.status == ArticleStatus.fetching || article.status == ArticleStatus.pending) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: AppSpacing.md),
                  Text('Loading article content...'),
                ],
              ),
            ),
          ],
        ),
      );
    }
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            article.title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          
          // Meta info
          _buildMetaInfo(context, article),
          const SizedBox(height: AppSpacing.md),
          
          // Divider
          Divider(color: theme.colorScheme.outlineVariant),
          const SizedBox(height: AppSpacing.md),
          
          // Content
          Html(
            data: article.content,
            style: {
              'body': Style(
                fontSize: FontSize(18),
                lineHeight: const LineHeight(1.7),
                fontFamily: 'Georgia',
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
              ),
              'p': Style(
                margin: Margins.only(bottom: 16),
              ),
              'h1': Style(
                fontSize: FontSize(28),
                fontWeight: FontWeight.bold,
                margin: Margins.only(top: 24, bottom: 12),
              ),
              'h2': Style(
                fontSize: FontSize(24),
                fontWeight: FontWeight.bold,
                margin: Margins.only(top: 20, bottom: 10),
              ),
              'h3': Style(
                fontSize: FontSize(20),
                fontWeight: FontWeight.w600,
                margin: Margins.only(top: 16, bottom: 8),
              ),
              'blockquote': Style(
                border: Border(
                  left: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 4,
                  ),
                ),
                padding: HtmlPaddings.only(left: 16),
                margin: Margins.symmetric(vertical: 16),
                fontStyle: FontStyle.italic,
              ),
              'pre': Style(
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                padding: HtmlPaddings.all(12),
              ),
              'code': Style(
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                fontFamily: 'monospace',
                fontSize: FontSize(14),
              ),
              'a': Style(
                color: theme.colorScheme.primary,
              ),
              'img': Style(
                margin: Margins.symmetric(vertical: 16),
              ),
            },
            onLinkTap: (url, attributes, element) {
              if (url != null) {
                _openUrl(url);
              }
            },
          ),
          
          // Bottom padding
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildMetaInfo(BuildContext context, Article article) {
    final theme = Theme.of(context);
    final parts = <String>[];
    
    if (article.siteName != null && article.siteName!.isNotEmpty) {
      parts.add(article.siteName!);
    }
    
    if (article.author != null && article.author!.isNotEmpty) {
      parts.add(article.author!);
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (parts.isNotEmpty)
          Text(
            parts.join(' • '),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        const SizedBox(height: 4),
        Text(
          _buildDateAndReadingTime(article),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  String _buildDateAndReadingTime(Article article) {
    final parts = <String>[];
    
    if (article.publishedAt != null) {
      parts.add(DateFormat.yMMMd().format(article.publishedAt!));
    } else {
      parts.add(DateFormat.yMMMd().format(article.savedAt));
    }
    
    if (article.wordCount > 0) {
      parts.add('${article.readingTimeMinutes} min read');
    }
    
    return parts.join(' • ');
  }

  void _handleMenuAction(String action, Article article) {
    switch (action) {
      case 'original':
        _openOriginal(article.url);
        break;
      case 'read_status':
        final notifier = ref.read(articleNotifierProvider.notifier);
        if (article.isRead) {
          notifier.markAsUnread(article.id);
        } else {
          notifier.markAsRead(article.id);
        }
        break;
      case 'delete':
        ref.read(articleNotifierProvider.notifier).deleteArticle(article.id);
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Article deleted')),
        );
        break;
    }
  }

  Future<void> _openOriginal(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }
}
