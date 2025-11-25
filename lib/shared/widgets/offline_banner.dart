import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';

/// Banner shown when the app is offline.
class OfflineBanner extends StatelessWidget {
  final VoidCallback? onDismiss;

  const OfflineBanner({
    super.key,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offlineBanner,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Icon(
            Icons.cloud_off,
            size: 18,
            color: Colors.orange[800],
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Offline - Reading from saved content',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.orange[900],
              ),
            ),
          ),
          if (onDismiss != null)
            IconButton(
              icon: Icon(
                Icons.close,
                size: 18,
                color: Colors.orange[800],
              ),
              onPressed: onDismiss,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }
}
