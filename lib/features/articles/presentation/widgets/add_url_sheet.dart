import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/theme.dart';

/// Bottom sheet for adding a new article URL.
class AddUrlSheet extends StatefulWidget {
  final Function(String url) onSave;

  const AddUrlSheet({super.key, required this.onSave});

  @override
  State<AddUrlSheet> createState() => _AddUrlSheetState();
}

class _AddUrlSheetState extends State<AddUrlSheet> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _errorText;
  bool _isValid = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Auto-paste from clipboard on open
    _checkClipboard();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _checkClipboard() async {
    try {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      if (data?.text != null) {
        final text = data!.text!.trim();
        if (_isValidUrl(text) && _controller.text.isEmpty) {
          _controller.text = text;
          _validate(text);
        }
      }
    } catch (_) {}
  }

  bool _isValidUrl(String value) {
    if (value.isEmpty) return false;
    final uri = Uri.tryParse(value);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  void _validate(String value) {
    final valid = _isValidUrl(value);
    setState(() {
      _isValid = valid;
      _errorText =
          value.isEmpty ? null : (valid ? null : 'Please enter a valid URL');
    });
  }

  Future<void> _pasteFromClipboard() async {
    try {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      if (data?.text != null) {
        _controller.text = data!.text!.trim();
        _validate(_controller.text);
      }
    } catch (_) {}
  }

  void _handleSave() {
    if (!_isValid || _isSaving) return;

    setState(() => _isSaving = true);
    widget.onSave(_controller.text.trim());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.sm,
        bottom: AppSpacing.md + bottomPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.4,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Title
          Text(
            'Add Article',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // URL input
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'Paste or type URL...',
              errorText: _errorText,
              prefixIcon: const Icon(Icons.link),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_controller.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        _validate('');
                      },
                      tooltip: 'Clear',
                    ),
                  IconButton(
                    icon: const Icon(Icons.content_paste),
                    onPressed: _pasteFromClipboard,
                    tooltip: 'Paste from clipboard',
                  ),
                ],
              ),
            ),
            onChanged: _validate,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            autofocus: true,
            autocorrect: false,
            onSubmitted: (_) => _handleSave(),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed:
                      _isSaving ? null : () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: FilledButton(
                  onPressed: _isValid && !_isSaving ? _handleSave : null,
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Shows the add URL bottom sheet.
Future<void> showAddUrlSheet(
  BuildContext context, {
  required Function(String url) onSave,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => AddUrlSheet(onSave: onSave),
  );
}
