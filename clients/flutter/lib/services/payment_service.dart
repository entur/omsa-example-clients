import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:omsa_demo_app/config.dart';

class PaymentService {
  static final Logger _logger = Logger();

  static String get _apiBaseUrl {
    return bffBaseUrl.endsWith('/')
        ? bffBaseUrl.substring(0, bffBaseUrl.length - 1)
        : bffBaseUrl;
  }

  static Uri _resolve(String path) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$_apiBaseUrl$normalizedPath');
  }

  static Future<Map<String, dynamic>> _postJson({
    required Uri url,
    required Map<String, dynamic> body,
  }) async {
    _logger.i('POST $url');
    _logger.d('Request body: ${jsonEncode(body)}');

    try {
      final response = await http.post(
        url,
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      _logger.i('Response ${response.statusCode} from $url');
      _logger.d('Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body.isNotEmpty
            ? jsonDecode(response.body) as Map<String, dynamic>
            : <String, dynamic>{};
      }

      throw Exception(
        'Request to $url failed: ${response.statusCode} - ${response.body}',
      );
    } catch (e) {
      _logger.e('Network error calling $url: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> _put({
    required Uri url,
  }) async {
    _logger.i('PUT $url');

    try {
      final response = await http.put(
        url,
        headers: const {
          'Accept': 'application/json',
        },
      );

      _logger.i('Response ${response.statusCode} from $url');
      _logger.d('Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body.isNotEmpty
            ? jsonDecode(response.body) as Map<String, dynamic>
            : <String, dynamic>{};
      }

      throw Exception(
        'Request to $url failed: ${response.statusCode} - ${response.body}',
      );
    } catch (e) {
      _logger.e('Network error calling $url: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> createPayment({
    required String orderId,
    required int orderVersion,
    required String totalAmount,
    required String transactionAmount,
    required String currency,
    required String paymentType,
  }) {
    final url = _resolve('/payments');
    final payload = {
      'orderId': orderId,
      'orderVersion': orderVersion,
      'totalAmount': totalAmount,
      'transaction': {
        'amount': transactionAmount,
        'currency': currency,
        'paymentType': paymentType,
      },
    };

    return _postJson(url: url, body: payload);
  }

  static Future<Map<String, dynamic>> startTerminalSession({
    required String paymentId,
    required String transactionId,
    required String redirectUrl,
    required String terminalLanguage,
  }) {
    final url = _resolve(
      '/payments/$paymentId/transactions/$transactionId/terminal',
    );
    final payload = {
      'redirectUrl': redirectUrl,
      'terminalLanguage': terminalLanguage,
    };

    return _postJson(url: url, body: payload);
  }

  static Future<Map<String, dynamic>> captureTransaction({
    required String paymentId,
    required String transactionId,
  }) {
    final url = _resolve(
      '/payments/$paymentId/transactions/$transactionId/capture',
    );
    return _put(url: url);
  }
}
