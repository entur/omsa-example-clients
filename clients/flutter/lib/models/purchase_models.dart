import 'dart:convert';
import 'dart:typed_data';

class TravelAnimation {
  final Uint8List imageBytes;
  final String? keyVersion;
  final String? color;
  final int? speed;

  TravelAnimation({
    required this.imageBytes,
    this.keyVersion,
    this.color,
    this.speed,
  });

  factory TravelAnimation.fromPayload(String payload) {
    final normalized = payload.trim();
    String jsonString = normalized;
    if (normalized.startsWith('{') && normalized.contains("'")) {
      jsonString = normalized.replaceAll("'", '"');
    }
    final Map<String, dynamic> data =
        json.decode(jsonString) as Map<String, dynamic>;
    final imageField = data['image']?.toString() ?? '';
    return TravelAnimation(
      imageBytes: imageField.isNotEmpty
          ? base64Decode(imageField)
          : Uint8List(0),
      keyVersion: data['keyVersion']?.toString(),
      color: data['color']?.toString(),
      speed: data['speed'] is num ? (data['speed'] as num).toInt() : null,
    );
  }
}

class PurchaseInitiation {
  final String packageId;
  final int orderVersion;
  final double totalAmount;
  final String currencyCode;

  PurchaseInitiation({
    required this.packageId,
    required this.orderVersion,
    required this.totalAmount,
    required this.currencyCode,
  });

  factory PurchaseInitiation.fromMap(
    Map<String, dynamic> map, {
    required double fallbackAmount,
    required String fallbackCurrency,
  }) {
    final price = map['price'] as Map<String, dynamic>? ?? {};
    final amount = (price['amount'] is num)
        ? (price['amount'] as num).toDouble()
        : fallbackAmount;
    final currency = price['currencyCode'] as String? ?? fallbackCurrency;

    final orderObject = map['order'];
    final derivedIdCandidate = orderObject is Map<String, dynamic>
        ? orderObject['id']
        : null;
    final packageId =
        (map['id'] ?? map['packageId'] ?? map['orderId'] ?? derivedIdCandidate)
            ?.toString() ??
        '';
    final orderVersionCandidate =
        map['orderVersion'] ??
        (orderObject is Map<String, dynamic>
            ? (orderObject['version'] ?? orderObject['orderVersion'])
            : null);
    final orderVersion = orderVersionCandidate is num
        ? orderVersionCandidate.toInt()
        : int.tryParse(orderVersionCandidate?.toString() ?? '') ?? 1;

    return PurchaseInitiation(
      packageId: packageId,
      orderVersion: orderVersion,
      totalAmount: amount,
      currencyCode: currency,
    );
  }
}

class PaymentSession {
  final int paymentId;
  final int transactionId;
  final String totalAmount;
  final String currency;
  final String status;

  PaymentSession({
    required this.paymentId,
    required this.transactionId,
    required this.totalAmount,
    required this.currency,
    required this.status,
  });

  factory PaymentSession.fromMap(Map<String, dynamic> map) {
    final history = map['transactionHistory'] as List<dynamic>? ?? [];
    final primary = history.isNotEmpty
        ? history.first as Map<String, dynamic>
        : {};
    final transactionId = primary['transactionId'] is num
        ? (primary['transactionId'] as num).toInt()
        : int.tryParse(primary['transactionId']?.toString() ?? '') ?? 0;

    return PaymentSession(
      paymentId: map['paymentId'] is num
          ? (map['paymentId'] as num).toInt()
          : int.tryParse(map['paymentId']?.toString() ?? '0') ?? 0,
      transactionId: transactionId,
      totalAmount: (map['totalAmount'] ?? primary['amount'] ?? '0.00')
          .toString(),
      currency: (map['currency'] ?? primary['currency'] ?? 'NOK').toString(),
      status: (primary['status'] ?? map['status'] ?? 'UNKNOWN').toString(),
    );
  }
}

class PaymentTerminalSession {
  final int paymentId;
  final int transactionId;
  final String terminalUri;

  PaymentTerminalSession({
    required this.paymentId,
    required this.transactionId,
    required this.terminalUri,
  });

  factory PaymentTerminalSession.fromMap(Map<String, dynamic> map) {
    return PaymentTerminalSession(
      paymentId: map['paymentId'] is num
          ? (map['paymentId'] as num).toInt()
          : int.tryParse(map['paymentId']?.toString() ?? '0') ?? 0,
      transactionId: map['transactionId'] is num
          ? (map['transactionId'] as num).toInt()
          : int.tryParse(map['transactionId']?.toString() ?? '0') ?? 0,
      terminalUri: map['terminalUri']?.toString() ?? '',
    );
  }
}

class PaymentAppClaimSession {
  final int paymentId;
  final int transactionId;
  final String appClaimUri;

  PaymentAppClaimSession({
    required this.paymentId,
    required this.transactionId,
    required this.appClaimUri,
  });

  factory PaymentAppClaimSession.fromMap(Map<String, dynamic> map) {
    return PaymentAppClaimSession(
      paymentId: map['paymentId'] is num
          ? (map['paymentId'] as num).toInt()
          : int.tryParse(map['paymentId']?.toString() ?? '0') ?? 0,
      transactionId: map['transactionId'] is num
          ? (map['transactionId'] as num).toInt()
          : int.tryParse(map['transactionId']?.toString() ?? '0') ?? 0,
      appClaimUri: map['appClaimUrl']?.toString() ?? '',
    );
  }
}

class PaymentCaptureResult {
  final String status;

  PaymentCaptureResult({required this.status});

  factory PaymentCaptureResult.fromMap(Map<String, dynamic> map) {
    final history = map['transactionHistory'] as List<dynamic>? ?? [];
    final primary = history.isNotEmpty
        ? history.first as Map<String, dynamic>
        : {};
    return PaymentCaptureResult(
      status: (primary['status'] ?? map['status'] ?? 'UNKNOWN').toString(),
    );
  }
}

class ConfirmedPackage {
  final String packageId;
  final String status;

  ConfirmedPackage({required this.packageId, required this.status});

  factory ConfirmedPackage.fromMap(Map<String, dynamic> map) {
    final id = map['id']?.toString() ?? map['packageId']?.toString() ?? '';
    final status = map['status']?.toString() ?? 'UNKNOWN';

    return ConfirmedPackage(packageId: id, status: status);
  }
}

class TravelDocument {
  final String id;
  final String type;
  final String travelDocumentType;
  final String contentType;
  final String base64Data;
  final DateTime? startValidity;
  final DateTime? endValidity;
  final Uint8List? binaryPayload;
  final TravelAnimation? animation;

  TravelDocument({
    required this.id,
    required this.type,
    required this.travelDocumentType,
    required this.contentType,
    required this.base64Data,
    required this.startValidity,
    required this.endValidity,
    this.binaryPayload,
    this.animation,
  });

  factory TravelDocument.fromMap(Map<String, dynamic> map) {
    final properties = map['properties'] as Map<String, dynamic>? ?? {};
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      return DateTime.tryParse(value.toString());
    }

    return TravelDocument(
      id: map['id']?.toString() ?? '',
      type: properties['type']?.toString() ?? map['type']?.toString() ?? '',
      travelDocumentType: properties['travelDocumentType']?.toString() ?? '',
      contentType: properties['contentType']?.toString() ?? '',
      base64Data: properties['base64']?.toString() ?? '',
      startValidity: parseDate(properties['startvalidity']),
      endValidity: parseDate(properties['endvalidity']),
      binaryPayload: _parseBinaryPayload(
        properties['base64']?.toString() ?? '',
        properties['travelDocumentType']?.toString() ?? '',
        properties['contentType']?.toString() ?? '',
      ),
      animation: _parseAnimation(
        properties['base64']?.toString() ?? '',
        properties['contentType']?.toString() ?? '',
      ),
    );
  }

  bool get isDisplayableImage {
    if (_isAnimation) {
      return animation?.imageBytes.isNotEmpty ?? false;
    }
    if (_isQrCode) {
      return false;
    }
    return contentType.contains('png') || contentType.contains('jpeg');
  }

  Uint8List? get displayableImageBytes {
    if (_isAnimation) {
      final bytes = animation?.imageBytes;
      if (bytes != null && bytes.isNotEmpty) {
        return bytes;
      }
    }
    if (contentType.contains('png') || contentType.contains('jpeg')) {
      return binaryPayload;
    }
    return null;
  }

  bool get hasAnimationDetails => animation != null;

  bool get isDailyAnimation => _isAnimation;

  bool get _isAnimation =>
      contentType.toLowerCase().contains('dailyanim') && animation != null;

  bool get _isQrCode => travelDocumentType.toUpperCase() == 'QRCODE';

  bool get isQrCode => _isQrCode;

  String? get qrPayloadString {
    if (!_isQrCode) return null;
    return base64Data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'properties': {
        'type': type,
        'travelDocumentType': travelDocumentType,
        'contentType': contentType,
        'base64': base64Data,
        if (startValidity != null)
          'startvalidity': startValidity!.toUtc().toIso8601String(),
        if (endValidity != null)
          'endvalidity': endValidity!.toUtc().toIso8601String(),
      },
    };
  }

  static Uint8List? _parseBinaryPayload(
    String base64Data,
    String travelDocumentType,
    String contentType,
  ) {
    if (base64Data.isEmpty) return null;
    try {
      if (contentType.toLowerCase().contains('dailyanim')) {
        final decoded = utf8.decode(base64Decode(base64Data));
        final normalized = decoded.contains("'")
            ? decoded.replaceAll("'", '"')
            : decoded;
        final Map<String, dynamic> jsonData =
            json.decode(normalized) as Map<String, dynamic>;
        final imageBase64 = jsonData['image']?.toString() ?? '';
        if (imageBase64.isNotEmpty) {
          return base64Decode(imageBase64);
        }
        return null;
      }
      return base64Decode(base64Data);
    } catch (_) {
      return null;
    }
  }

  static TravelAnimation? _parseAnimation(
    String base64Data,
    String contentType,
  ) {
    if (!contentType.toLowerCase().contains('dailyanim')) return null;
    if (base64Data.isEmpty) return null;
    try {
      final raw = utf8.decode(base64Decode(base64Data));
      return TravelAnimation.fromPayload(raw);
    } catch (_) {
      return null;
    }
  }
}
