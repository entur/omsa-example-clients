import 'dart:convert';
import 'dart:typed_data';

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

  TravelDocument({
    required this.id,
    required this.type,
    required this.travelDocumentType,
    required this.contentType,
    required this.base64Data,
    required this.startValidity,
    required this.endValidity,
    this.binaryPayload,
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
      ),
    );
  }

  bool get isDisplayableImage {
    if (_isQrCode) return false;
    return binaryPayload != null && binaryPayload!.isNotEmpty;
  }

  Uint8List? get displayableImageBytes {
    if (binaryPayload != null && binaryPayload!.isNotEmpty) {
      return binaryPayload;
    }
    return null;
  }

  bool get isDailyAnimation =>
      contentType.toLowerCase().contains('dailyanim') &&
      binaryPayload != null &&
      binaryPayload!.isNotEmpty;

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

  static Uint8List? _parseBinaryPayload(String base64Data) {
    if (base64Data.isEmpty) return null;
    try {
      return base64Decode(base64Data);
    } catch (_) {
      return null;
    }
  }

}
