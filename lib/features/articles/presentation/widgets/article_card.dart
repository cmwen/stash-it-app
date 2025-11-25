import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/theme/theme.dart';
import '../../domain/entities/article.dart';

/// Card widget displaying an article in the list.
class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isRead = article.isRead;

    return Dismissible(
      key: Key(article.id),
      direction: DismissDirection.endToStart,
      background: _buildDeleteBackground(context),
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Opacity(
            opacity: isRead ? 0.7 : 1.0,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildThumbnail(context),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: _buildContent(context)),
                  if (!isRead) _buildUnreadDot(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteBackground(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.deleteBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: AppSpacing.lg),
      child: const Icon(Icons.delete, color: AppColors.deleteIcon),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return true; // Delete immediately, show undo snackbar instead
  }

  Widget _buildThumbnail(BuildContext context) {
    final theme = Theme.of(context);

    if (article.status == ArticleStatus.fetching) {
      return Container(
        width: AppSpacing.thumbnailSize,
        height: AppSpacing.thumbnailSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSpacing.thumbnailRadius),
        ),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      );
    }

    if (article.status == ArticleStatus.failed) {
      return Container(
        width: AppSpacing.thumbnailSize,
        height: AppSpacing.thumbnailSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(AppSpacing.thumbnailRadius),
        ),
        child: Icon(Icons.error_outline, color: theme.colorScheme.error),
      );
    }

    if (article.imageUrl != null && article.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.thumbnailRadius),
        child: CachedNetworkImage(
          imageUrl: article.imageUrl!,
          width: AppSpacing.thumbnailSize,
          height: AppSpacing.thumbnailSize,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            width: AppSpacing.thumbnailSize,
            height: AppSpacing.thumbnailSize,
            color: theme.colorScheme.surfaceContainerHighest,
            child: Icon(Icons.image, color: theme.colorScheme.onSurfaceVariant),
          ),
          errorWidget: (context, url, error) => Container(
            width: AppSpacing.thumbnailSize,
            height: AppSpacing.thumbnailSize,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppSpacing.thumbnailRadius),
            ),
            child: Icon(
              Icons.article,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return Container(
      width: AppSpacing.thumbnailSize,
      height: AppSpacing.thumbnailSize,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.thumbnailRadius),
      ),
      child: Icon(Icons.article, color: theme.colorScheme.onSurfaceVariant),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          article.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        // Source and reading time
        Text(
          _buildMetaText(),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        // Saved time
        Text(
          _buildTimeText(),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  String _buildMetaText() {
    final parts = <String>[];

    if (article.siteName != null && article.siteName!.isNotEmpty) {
      parts.add(article.siteName!);
    } else {
      try {
        final uri = Uri.parse(article.url);
        parts.add(uri.host.replaceFirst('www.', ''));
      } catch (_) {}
    }

    if (article.status == ArticleStatus.ready && article.wordCount > 0) {
      parts.add('${article.readingTimeMinutes} min read');
    } else if (article.status == ArticleStatus.fetching) {
      parts.add('Loading...');
    } else if (article.status == ArticleStatus.failed) {
      parts.add('Failed to load');
    } else if (article.status == ArticleStatus.pending) {
      parts.add('Pending');
    }

    return parts.join(' • ');
  }

  String _buildTimeText() {
    if (article.isRead) {
      return 'Read ${timeago.format(article.savedAt)}';
    }
    return 'Saved ${timeago.format(article.savedAt)}';
  }

  Widget _buildUnreadDot(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.only(left: AppSpacing.sm),
      decoration: const BoxDecoration(
        color: AppColors.unreadDot,
        shape: BoxShape.circle,
      ),
    );
  }
}
