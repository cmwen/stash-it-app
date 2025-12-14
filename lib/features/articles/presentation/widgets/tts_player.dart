import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../domain/entities/tts_state.dart';
import '../providers/tts_provider.dart';

/// TTS player widget with playback controls.
class TtsPlayer extends ConsumerWidget {
  final String articleId;
  final String articleContent;

  const TtsPlayer({
    super.key,
    required this.articleId,
    required this.articleContent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ttsState = ref.watch(articleTtsProvider(articleId));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Initialize TTS if needed
    if (ttsState.totalLength == 0 && articleContent.isNotEmpty) {
      Future.microtask(() async {
        await ref
            .read(articleTtsProvider(articleId).notifier)
            .initialize(articleContent);
      });
    }

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(AppSpacing.md)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Progress bar
              _buildProgressBar(context, ref, ttsState),
              const SizedBox(height: AppSpacing.md),
              // Controls
              _buildControls(context, ref, ttsState, colorScheme),
              const SizedBox(height: AppSpacing.sm),
              // Speed control
              _buildSpeedControl(context, ref, ttsState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(
    BuildContext context,
    WidgetRef ref,
    TtsState ttsState,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        LinearProgressIndicator(
          value: ttsState.progress,
          backgroundColor: colorScheme.surfaceContainerHigh,
          valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
        ),
        const SizedBox(height: AppSpacing.xs),
        if (ttsState.currentWord != null && ttsState.currentWord!.isNotEmpty)
          Text(
            ttsState.currentWord!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.primary,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  Widget _buildControls(
    BuildContext context,
    WidgetRef ref,
    TtsState ttsState,
    ColorScheme colorScheme,
  ) {
    final notifier = ref.read(articleTtsProvider(articleId).notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Skip backward
        IconButton(
          icon: const Icon(Icons.replay_10),
          iconSize: 32,
          onPressed: ttsState.isStopped ? null : () => notifier.skipBackward(),
          tooltip: 'Rewind 10 seconds',
        ),
        // Play/Pause button
        Container(
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              ttsState.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
            iconSize: 40,
            color: colorScheme.onPrimary,
            onPressed: () {
              if (ttsState.isPlaying) {
                notifier.pause();
              } else {
                notifier.play();
              }
            },
            tooltip: ttsState.isPlaying ? 'Pause' : 'Play',
          ),
        ),
        // Skip forward
        IconButton(
          icon: const Icon(Icons.forward_10),
          iconSize: 32,
          onPressed: ttsState.isStopped ? null : () => notifier.skipForward(),
          tooltip: 'Forward 10 seconds',
        ),
        // Stop button
        IconButton(
          icon: const Icon(Icons.stop),
          iconSize: 32,
          onPressed: ttsState.isStopped ? null : () => notifier.stop(),
          tooltip: 'Stop',
        ),
      ],
    );
  }

  Widget _buildSpeedControl(
    BuildContext context,
    WidgetRef ref,
    TtsState ttsState,
  ) {
    final notifier = ref.read(articleTtsProvider(articleId).notifier);
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: ttsState.speechRate <= 0.25
              ? null
              : () => notifier.decreaseSpeed(),
          tooltip: 'Decrease speed',
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          child: Row(
            children: [
              const Icon(Icons.speed, size: 20),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '${_formatSpeed(ttsState.speechRate)}x',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed:
              ttsState.speechRate >= 2.0 ? null : () => notifier.increaseSpeed(),
          tooltip: 'Increase speed',
        ),
      ],
    );
  }

  String _formatSpeed(double speed) {
    // Convert 0.5 (normal) to 1.0x display
    final displaySpeed = speed * 2.0;
    return displaySpeed.toStringAsFixed(1);
  }
}
