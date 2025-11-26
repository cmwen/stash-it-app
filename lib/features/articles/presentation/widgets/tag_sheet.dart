import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../providers/providers.dart';

/// Tag management sheet for adding/removing tags from an article.
class TagManagementSheet extends ConsumerStatefulWidget {
  final String articleId;
  final List<String> currentTags;

  const TagManagementSheet({
    super.key,
    required this.articleId,
    required this.currentTags,
  });

  @override
  ConsumerState<TagManagementSheet> createState() => _TagManagementSheetState();
}

class _TagManagementSheetState extends ConsumerState<TagManagementSheet> {
  final _controller = TextEditingController();
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = List.from(widget.currentTags);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTag(String tag) {
    final normalizedTag = tag.trim().toLowerCase();
    if (normalizedTag.isNotEmpty && !_tags.contains(normalizedTag)) {
      setState(() {
        _tags.add(normalizedTag);
      });
      ref
          .read(articleNotifierProvider.notifier)
          .addTag(widget.articleId, normalizedTag);
      _controller.clear();
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
    ref.read(articleNotifierProvider.notifier).removeTag(widget.articleId, tag);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allTagsAsync = ref.watch(allTagsProvider);
    final existingTags = allTagsAsync.valueOrNull ?? [];
    final suggestedTags = existingTags
        .where((t) => !_tags.contains(t))
        .toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.md,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant.withAlpha(102),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Title
              Text(
                'Manage Tags',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // New tag input
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Add a new tag...',
                  prefixIcon: const Icon(Icons.label_outline),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _addTag(_controller.text),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: _addTag,
              ),
              const SizedBox(height: AppSpacing.md),

              // Current tags
              if (_tags.isNotEmpty) ...[
                Text(
                  'Current Tags',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: _tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      onDeleted: () => _removeTag(tag),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      backgroundColor: theme.colorScheme.primaryContainer,
                      labelStyle: TextStyle(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Suggested tags (from other articles)
              if (suggestedTags.isNotEmpty) ...[
                Text(
                  'Suggested Tags',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: suggestedTags.map((tag) {
                          return ActionChip(
                            label: Text(tag),
                            avatar: const Icon(Icons.add, size: 18),
                            onPressed: () => _addTag(tag),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ] else if (_tags.isEmpty) ...[
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.label_outline,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'No tags yet',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          'Add tags to organize your articles',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// Shows the tag management sheet.
void showTagManagementSheet(
  BuildContext context, {
  required String articleId,
  required List<String> currentTags,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) =>
        TagManagementSheet(articleId: articleId, currentTags: currentTags),
  );
}
