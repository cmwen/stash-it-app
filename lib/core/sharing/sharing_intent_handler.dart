import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

/// Provider for handling shared content from other apps.
final sharingIntentHandlerProvider =
    Provider<SharingIntentHandler>((ref) => SharingIntentHandler());

/// Handles incoming shared content from other apps.
class SharingIntentHandler {
  StreamSubscription? _subscription;

  /// Starts listening for shared media from other apps.
  /// 
  /// [onSharedText] is called when text/URL is shared to the app.
  /// Returns the initial shared text if the app was opened via a share intent.
  Future<String?> initialize({
    required void Function(String url) onSharedText,
  }) async {
    // Handle initial share intent (when app is opened via share)
    final initialMedia = await ReceiveSharingIntent.instance.getInitialMedia();
    String? initialUrl;
    
    if (initialMedia.isNotEmpty) {
      final url = _extractUrl(initialMedia.first.path);
      if (url != null) {
        initialUrl = url;
        onSharedText(url);
      }
    }

    // Listen for shares while app is running
    _subscription = ReceiveSharingIntent.instance.getMediaStream().listen(
      (List<SharedMediaFile> mediaList) {
        if (mediaList.isNotEmpty) {
          final url = _extractUrl(mediaList.first.path);
          if (url != null) {
            onSharedText(url);
          }
        }
      },
      onError: (err) {
        debugPrint('SharingIntentHandler error: $err');
      },
    );

    return initialUrl;
  }

  /// Extracts a URL from shared text.
  /// 
  /// The shared text might be a plain URL, or text containing a URL.
  String? _extractUrl(String? text) {
    if (text == null || text.isEmpty) return null;

    // If it's already a valid URL, return it
    if (_isValidUrl(text.trim())) {
      return text.trim();
    }

    // Try to extract URL from text
    final urlRegex = RegExp(
      r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
      caseSensitive: false,
    );

    final match = urlRegex.firstMatch(text);
    return match?.group(0);
  }

  /// Checks if a string is a valid URL.
  bool _isValidUrl(String text) {
    try {
      final uri = Uri.parse(text);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (_) {
      return false;
    }
  }

  /// Disposes the stream subscription.
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
