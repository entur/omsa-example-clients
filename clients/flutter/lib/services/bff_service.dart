import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:omsa_demo_app/config.dart';

class BffService {
  static final Logger _logger = Logger();

  static String get _apiBase {
    return bffBaseUrl.endsWith('/')
        ? bffBaseUrl.substring(0, bffBaseUrl.length - 1)
        : bffBaseUrl;
  }

  static String get _serviceBase {
    const suffix = '/api/v1';
    final base = _apiBase;
    if (base.endsWith(suffix)) {
      return base.substring(0, base.length - suffix.length);
    }
    return base;
  }

  static bool get isConfigured => bffBaseUrl.isNotEmpty;

  static Uri _serviceUri(String path) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$_serviceBase$normalizedPath');
  }

  static Future<bool> checkBackendHealth() async {
    final url = _serviceUri('/health');
    _logger.i('Checking BFF health at $url');

    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode != 200) {
        _logger.e('BFF health check failed: ${response.statusCode}');
        return false;
      }

      final payload = jsonDecode(response.body);
      _logger.d('BFF health payload: $payload');
      return payload['status'] == 'ok' || payload['status'] == 'degraded';
    } catch (e) {
      _logger.e('BFF health check error: $e');
      return false;
    }
  }
}
