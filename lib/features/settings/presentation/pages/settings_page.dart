// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/theme/theme.dart';

/// Settings page for app configuration.
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    // Theme obtained where needed via Theme.of(context) in helpers

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Appearance Section
          _buildSectionHeader(context, 'Appearance'),
          _buildThemeTile(context),

          const Divider(),

          // Reader Section
          _buildSectionHeader(context, 'Reader'),
          _buildFontSizeTile(context),

          const Divider(),

          // Storage Section
          _buildSectionHeader(context, 'Storage'),
          _buildClearCacheTile(context),

          const Divider(),

          // About Section
          _buildSectionHeader(context, 'About'),
          _buildAboutTile(context),
          _buildVersionTile(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.xs,
      ),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildThemeTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.palette_outlined),
      title: const Text('Theme'),
      subtitle: const Text('System default'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showThemeDialog(context),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              value: 'system',
              groupValue: 'system', // TODO: Read from preferences
              onChanged: (value) => Navigator.pop(context),
              title: const Text('System default'),
              secondary: const Icon(Icons.settings_suggest_outlined),
            ),
            RadioListTile<String>(
              value: 'light',
              groupValue: 'system',
              onChanged: (value) => Navigator.pop(context),
              title: const Text('Light'),
              secondary: const Icon(Icons.light_mode_outlined),
            ),
            RadioListTile<String>(
              value: 'dark',
              groupValue: 'system',
              onChanged: (value) => Navigator.pop(context),
              title: const Text('Dark'),
              secondary: const Icon(Icons.dark_mode_outlined),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildFontSizeTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.text_fields_outlined),
      title: const Text('Font Size'),
      subtitle: const Text('Medium'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showFontSizeDialog(context),
    );
  }

  void _showFontSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reader Font Size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              value: 'small',
              groupValue: 'medium', // TODO: Read from preferences
              onChanged: (value) => Navigator.pop(context),
              title: const Text('Small'),
            ),
            RadioListTile<String>(
              value: 'medium',
              groupValue: 'medium',
              onChanged: (value) => Navigator.pop(context),
              title: const Text('Medium'),
            ),
            RadioListTile<String>(
              value: 'large',
              groupValue: 'medium',
              onChanged: (value) => Navigator.pop(context),
              title: const Text('Large'),
            ),
            RadioListTile<String>(
              value: 'xlarge',
              groupValue: 'medium',
              onChanged: (value) => Navigator.pop(context),
              title: const Text('Extra Large'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildClearCacheTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.cleaning_services_outlined),
      title: const Text('Clear Image Cache'),
      subtitle: const Text('Free up storage space'),
      onTap: () => _showClearCacheConfirmation(context),
    );
  }

  void _showClearCacheConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache?'),
        content: const Text(
          'This will remove all cached article images. '
          'Images will be downloaded again when you view articles.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Cache cleared')));
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: const Text('About Stash It'),
      onTap: () => _showAboutDialog(context),
    );
  }

  Future<void> _showAboutDialog(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();
    
    if (!context.mounted) return;
    
    showAboutDialog(
      context: context,
      applicationName: 'Stash It',
      applicationVersion: packageInfo.version,
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.bookmark,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      children: [
        const SizedBox(height: AppSpacing.md),
        const Text(
          'A local-first read-it-later app.\n'
          'Save articles from any app and read them offline.',
        ),
        const SizedBox(height: AppSpacing.md),
        Text('© 2025 Stash It', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildVersionTile(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final version = snapshot.data?.version ?? '1.0.0';
        return ListTile(
          leading: const Icon(Icons.verified_outlined),
          title: const Text('Version'),
          subtitle: Text(version),
        );
      },
    );
  }
}
