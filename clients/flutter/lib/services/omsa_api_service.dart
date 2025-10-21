import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:omsa_demo_app/models/travel_models.dart';
import 'package:omsa_demo_app/config.dart';

class OmsaApiService {
  static final Logger _logger = Logger();
  static final Uuid _uuid = Uuid();
  static String get _apiBaseUrl {
    return bffBaseUrl.endsWith('/')
        ? bffBaseUrl.substring(0, bffBaseUrl.length - 1)
        : bffBaseUrl;
  }

  static Uri _resolveApi(String path) {
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
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
      throw Exception(
        'Request to $url failed: ${response.statusCode} - ${response.body}',
      );
    } catch (e) {
      _logger.e('Network error calling $url: $e');
      rethrow;
    }
  }

  static Future<dynamic> _getJson({required Uri url}) async {
    _logger.i('GET $url');

    try {
      final response = await http.get(
        url,
        headers: const {'Accept': 'application/json'},
      );

      _logger.i('Response ${response.statusCode} from $url');
      _logger.d('Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) {
          return <String, dynamic>{};
        }
        return jsonDecode(response.body);
      }
      throw Exception(
        'Request to $url failed: ${response.statusCode} - ${response.body}',
      );
    } catch (e) {
      _logger.e('Network error calling $url: $e');
      rethrow;
    }
  }

  static Future<OfferCollection> searchOffers({
    required String fromZoneId,
    required String toZoneId,
    required DateTime startTime,
    required DateTime endTime,
    int travelerAge = 30,
  }) async {
    final searchRequest = SearchOfferRequest(
      inputs: SearchOfferInputs(
        type: 'search_offer',
        timestamp: DateTime.now().toUtc().toIso8601String(),
        specification: SearchSpecification(
          from: Place(placeId: fromZoneId),
          to: Place(placeId: toZoneId),
          startTime: startTime.toUtc().toIso8601String(),
          endTime: endTime.toUtc().toIso8601String(),
        ),
        travellers: [
          Traveller(
            type: 'individual_traveller',
            id: _generateTravellerUuid(),
            age: travelerAge,
          ),
        ],
      ),
    );

    final url = _resolveApi('/processes/search-offers/execute');
    final responseBody = await _postJson(
      url: url,
      body: searchRequest.toJson(),
    );
    _logger.i('Successfully parsed offer collection from BFF');
    return OfferCollection.fromJson(responseBody);
  }

  static Future<Map<String, dynamic>> purchaseOffer({
    required String offerId,
    DateTime? timestamp,
    String? successUri,
  }) async {
    final url = _resolveApi('/processes/purchase-offers/execute');
    final resolvedSuccessUri = successUri ?? 'https://example.com';
    final payload = <String, dynamic>{
      'inputs': {
        'type': 'purchase_offers',
        if (timestamp != null) 'timestamp': timestamp.toUtc().toIso8601String(),
        'offerIds': [offerId],
      },
      'subscriber': {'successUri': resolvedSuccessUri},
    };

    return _postJson(url: url, body: payload);
  }

  static Future<Map<String, dynamic>> confirmPackage({
    required String packageId,
    DateTime? timestamp,
  }) async {
    final url = _resolveApi('/processes/confirm-package/execute');
    final payload = <String, dynamic>{
      'inputs': {
        'packageId': packageId,
        'type': 'package_input',
        if (timestamp != null) 'timestamp': timestamp.toUtc().toIso8601String(),
      },
    };

    return _postJson(url: url, body: payload);
  }

  static Future<dynamic> fetchTravelDocuments({
    required String packageId,
  }) async {
    final url = _resolveApi(
      '/collections/travel-documents/items?packageId=$packageId',
    );
    return _getJson(url: url);
  }

  static String _generateTravellerUuid() {
    return _uuid.v4();
  }
}
