import 'package:dio/dio.dart';

/// Service for fetching web content.
class WebFetcher {
  final Dio _dio;

  WebFetcher({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 30),
              headers: {
                'User-Agent':
                    'Mozilla/5.0 (compatible; StashIt/1.0; +https://stashit.app)',
                'Accept':
                    'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
              },
            ));

  /// Fetches HTML content from a URL.
  Future<String> fetchHtml(String url) async {
    try {
      final response = await _dio.get<String>(
        url,
        options: Options(responseType: ResponseType.plain),
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      }

      throw FetchException('Failed to fetch: HTTP ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw FetchException('Connection timeout');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw FetchException('Response timeout');
      }
      throw FetchException(e.message ?? 'Network error');
    }
  }

  /// Downloads an image and returns bytes.
  Future<List<int>> fetchImage(String url) async {
    try {
      final response = await _dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      }

      throw FetchException('Failed to fetch image: HTTP ${response.statusCode}');
    } on DioException catch (e) {
      throw FetchException(e.message ?? 'Failed to fetch image');
    }
  }
}

class FetchException implements Exception {
  final String message;
  FetchException(this.message);

  @override
  String toString() => message;
}
