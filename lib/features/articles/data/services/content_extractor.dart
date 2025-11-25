import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

/// Result of content extraction.
class ExtractedContent {
  final String title;
  final String? author;
  final String? excerpt;
  final String content;
  final String? imageUrl;
  final String? siteName;
  final DateTime? publishedAt;
  final int wordCount;

  const ExtractedContent({
    required this.title,
    this.author,
    this.excerpt,
    required this.content,
    this.imageUrl,
    this.siteName,
    this.publishedAt,
    required this.wordCount,
  });
}

/// Service to extract article content from HTML.
class ContentExtractor {
  /// Extracts the main content from HTML.
  ExtractedContent extract(String html, String url) {
    final document = html_parser.parse(html);

    // Extract title
    final title = _extractTitle(document);

    // Extract author
    final author = _extractAuthor(document);

    // Extract main content
    final content = _extractContent(document);

    // Extract excerpt
    final excerpt = _extractExcerpt(document, content);

    // Extract featured image
    final imageUrl = _extractImage(document);

    // Extract site name
    final siteName = _extractSiteName(document, url);

    // Extract publish date
    final publishedAt = _extractPublishDate(document);

    // Calculate word count
    final wordCount = _countWords(content);

    return ExtractedContent(
      title: title,
      author: author,
      excerpt: excerpt,
      content: content,
      imageUrl: imageUrl,
      siteName: siteName,
      publishedAt: publishedAt,
      wordCount: wordCount,
    );
  }

  String _extractTitle(Document document) {
    // Try Open Graph title first
    final ogTitle = document.querySelector('meta[property="og:title"]');
    if (ogTitle != null) {
      final content = ogTitle.attributes['content'];
      if (content != null && content.isNotEmpty) return content;
    }

    // Try Twitter title
    final twitterTitle = document.querySelector('meta[name="twitter:title"]');
    if (twitterTitle != null) {
      final content = twitterTitle.attributes['content'];
      if (content != null && content.isNotEmpty) return content;
    }

    // Try h1
    final h1 = document.querySelector('h1');
    if (h1 != null && h1.text.trim().isNotEmpty) {
      return h1.text.trim();
    }

    // Fall back to title tag
    final titleTag = document.querySelector('title');
    if (titleTag != null) {
      return titleTag.text.trim();
    }

    return 'Untitled';
  }

  String? _extractAuthor(Document document) {
    // Try meta author
    final metaAuthor = document.querySelector('meta[name="author"]');
    if (metaAuthor != null) {
      final content = metaAuthor.attributes['content'];
      if (content != null && content.isNotEmpty) return content;
    }

    // Try Open Graph article:author
    final ogAuthor = document.querySelector('meta[property="article:author"]');
    if (ogAuthor != null) {
      final content = ogAuthor.attributes['content'];
      if (content != null && content.isNotEmpty) return content;
    }

    // Try common author class patterns
    final authorPatterns = [
      '.author',
      '.byline',
      '[rel="author"]',
      '.post-author',
      '.entry-author',
    ];

    for (final pattern in authorPatterns) {
      final element = document.querySelector(pattern);
      if (element != null && element.text.trim().isNotEmpty) {
        return element.text.trim();
      }
    }

    return null;
  }

  String _extractContent(Document document) {
    // Remove unwanted elements
    final unwantedSelectors = [
      'script',
      'style',
      'nav',
      'header',
      'footer',
      'aside',
      '.advertisement',
      '.ads',
      '.sidebar',
      '.comments',
      '.social-share',
      '.related-posts',
    ];

    for (final selector in unwantedSelectors) {
      document.querySelectorAll(selector).forEach((e) => e.remove());
    }

    // Try to find article content
    final contentSelectors = [
      'article',
      '[role="main"]',
      '.post-content',
      '.entry-content',
      '.article-content',
      '.content',
      'main',
    ];

    for (final selector in contentSelectors) {
      final element = document.querySelector(selector);
      if (element != null) {
        final html = _cleanHtml(element);
        if (html.length > 200) {
          return html;
        }
      }
    }

    // Fall back to body
    final body = document.body;
    if (body != null) {
      return _cleanHtml(body);
    }

    return '';
  }

  String _cleanHtml(Element element) {
    // Clone to avoid modifying original
    final clone = element.clone(true);

    // Remove inline scripts and styles
    clone.querySelectorAll('script, style').forEach((e) => e.remove());

    // Keep only safe tags
    final safeTagNames = {
      'p',
      'h1',
      'h2',
      'h3',
      'h4',
      'h5',
      'h6',
      'ul',
      'ol',
      'li',
      'blockquote',
      'pre',
      'code',
      'strong',
      'b',
      'em',
      'i',
      'a',
      'img',
      'figure',
      'figcaption',
      'br',
      'hr',
      'table',
      'thead',
      'tbody',
      'tr',
      'th',
      'td',
    };

    // Build cleaned HTML
    final buffer = StringBuffer();
    _processNode(clone, buffer, safeTagNames);

    return buffer.toString().trim();
  }

  void _processNode(Node node, StringBuffer buffer, Set<String> safeTagNames) {
    if (node is Text) {
      buffer.write(node.text);
    } else if (node is Element) {
      final tagName = node.localName?.toLowerCase() ?? '';

      if (safeTagNames.contains(tagName)) {
        buffer.write('<$tagName');

        // Keep certain attributes
        if (tagName == 'a' && node.attributes.containsKey('href')) {
          buffer.write(' href="${node.attributes['href']}"');
        }
        if (tagName == 'img') {
          if (node.attributes.containsKey('src')) {
            buffer.write(' src="${node.attributes['src']}"');
          }
          if (node.attributes.containsKey('alt')) {
            buffer.write(' alt="${node.attributes['alt']}"');
          }
        }

        buffer.write('>');

        for (final child in node.nodes) {
          _processNode(child, buffer, safeTagNames);
        }

        if (!{'br', 'hr', 'img'}.contains(tagName)) {
          buffer.write('</$tagName>');
        }
      } else {
        // Process children without the tag
        for (final child in node.nodes) {
          _processNode(child, buffer, safeTagNames);
        }
      }
    }
  }

  String? _extractExcerpt(Document document, String content) {
    // Try meta description
    final metaDesc = document.querySelector('meta[name="description"]');
    if (metaDesc != null) {
      final desc = metaDesc.attributes['content'];
      if (desc != null && desc.isNotEmpty) return desc;
    }

    // Try Open Graph description
    final ogDesc = document.querySelector('meta[property="og:description"]');
    if (ogDesc != null) {
      final desc = ogDesc.attributes['content'];
      if (desc != null && desc.isNotEmpty) return desc;
    }

    // Extract from content
    final plainText = _htmlToPlainText(content);
    if (plainText.length > 200) {
      return '${plainText.substring(0, 197)}...';
    }

    return plainText.isNotEmpty ? plainText : null;
  }

  String? _extractImage(Document document) {
    // Try Open Graph image
    final ogImage = document.querySelector('meta[property="og:image"]');
    if (ogImage != null) {
      return ogImage.attributes['content'];
    }

    // Try Twitter image
    final twitterImage = document.querySelector('meta[name="twitter:image"]');
    if (twitterImage != null) {
      return twitterImage.attributes['content'];
    }

    // Try first significant image in article
    final images = document.querySelectorAll(
      'article img, .content img, main img',
    );
    for (final img in images) {
      final src = img.attributes['src'];
      if (src != null &&
          src.isNotEmpty &&
          !src.contains('avatar') &&
          !src.contains('icon')) {
        return src;
      }
    }

    return null;
  }

  String? _extractSiteName(Document document, String url) {
    // Try Open Graph site_name
    final ogSiteName = document.querySelector('meta[property="og:site_name"]');
    if (ogSiteName != null) {
      final name = ogSiteName.attributes['content'];
      if (name != null && name.isNotEmpty) return name;
    }

    // Extract from URL
    try {
      final uri = Uri.parse(url);
      return uri.host.replaceFirst('www.', '');
    } catch (_) {
      return null;
    }
  }

  DateTime? _extractPublishDate(Document document) {
    // Try article:published_time
    final published = document.querySelector(
      'meta[property="article:published_time"]',
    );
    if (published != null) {
      final content = published.attributes['content'];
      if (content != null) {
        return DateTime.tryParse(content);
      }
    }

    // Try time element
    final time = document.querySelector('time[datetime]');
    if (time != null) {
      final datetime = time.attributes['datetime'];
      if (datetime != null) {
        return DateTime.tryParse(datetime);
      }
    }

    return null;
  }

  int _countWords(String html) {
    final plainText = _htmlToPlainText(html);
    return plainText.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
  }

  String _htmlToPlainText(String html) {
    final document = html_parser.parse(html);
    return document.body?.text.trim() ?? '';
  }
}
