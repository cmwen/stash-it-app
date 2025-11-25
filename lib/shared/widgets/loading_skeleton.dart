import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/theme.dart';

/// Skeleton loading widget for article cards.
class ArticleCardSkeleton extends StatelessWidget {
  const ArticleCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          child: Row(
            children: [
              Container(
                width: AppSpacing.thumbnailSize,
                height: AppSpacing.thumbnailSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.thumbnailRadius,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(height: 12, width: 150, color: Colors.white),
                    const SizedBox(height: 8),
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

/// List of skeleton cards for loading state.
class ArticleListSkeleton extends StatelessWidget {
  final int count;

  const ArticleListSkeleton({super.key, this.count = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      itemCount: count,
      itemBuilder: (context, index) => const ArticleCardSkeleton(),
    );
  }
}
