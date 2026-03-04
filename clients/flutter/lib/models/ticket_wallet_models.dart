import 'package:omsa_demo_app/models/purchase_models.dart';

class TicketPackage {
  final String packageId;
  final DateTime purchasedAt;
  final DateTime? lastSyncedAt;
  final List<TravelDocument> documents;
  final String? packageName;
  final String? packageDescription;
  final double? totalAmount;
  final String? currencyCode;
  final String? status;

  const TicketPackage({
    required this.packageId,
    required this.purchasedAt,
    required this.lastSyncedAt,
    required this.documents,
    required this.packageName,
    required this.packageDescription,
    required this.totalAmount,
    required this.currencyCode,
    required this.status,
  });

  factory TicketPackage.fromMap(Map<String, dynamic> map) {
    final packageId = map['packageId']?.toString() ?? '';
    if (packageId.isEmpty) {
      throw FormatException(
        'TicketPackage requires a non-empty packageId. '
        'Received: $map',
      );
    }

    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      return DateTime.tryParse(value.toString());
    }

    double? parseAmount(dynamic value) {
      if (value == null) {
        return null;
      }
      if (value is num) {
        return value.toDouble();
      }
      return double.tryParse(value.toString());
    }

    final purchasedAt = parseDate(map['purchasedAt']);
    if (purchasedAt == null) {
      throw FormatException(
        'TicketPackage "$packageId" has missing or malformed purchasedAt: '
        '${map['purchasedAt']}',
      );
    }

    final rawDocuments = map['documents'];
    final documents = <TravelDocument>[];
    if (rawDocuments is List) {
      for (final item in rawDocuments) {
        if (item is Map<String, dynamic>) {
          documents.add(TravelDocument.fromMap(item));
        } else if (item is Map) {
          documents.add(
            TravelDocument.fromMap(Map<String, dynamic>.from(item)),
          );
        }
      }
    }

    return TicketPackage(
      packageId: packageId,
      purchasedAt: purchasedAt,
      lastSyncedAt: parseDate(map['lastSyncedAt']),
      documents: documents,
      packageName: map['packageName']?.toString(),
      packageDescription: map['packageDescription']?.toString(),
      totalAmount: parseAmount(map['totalAmount']),
      currencyCode: map['currencyCode']?.toString(),
      status: map['status']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'packageId': packageId,
      'purchasedAt': purchasedAt.toUtc().toIso8601String(),
      if (lastSyncedAt != null)
        'lastSyncedAt': lastSyncedAt!.toUtc().toIso8601String(),
      if (packageName != null) 'packageName': packageName,
      if (packageDescription != null) 'packageDescription': packageDescription,
      if (totalAmount != null) 'totalAmount': totalAmount,
      if (currencyCode != null) 'currencyCode': currencyCode,
      if (status != null) 'status': status,
      'documents': documents.map((document) => document.toMap()).toList(),
    };
  }

  bool get hasDocuments => documents.isNotEmpty;

  TravelDocument? get primaryDocument {
    if (documents.isEmpty) return null;
    for (final document in documents) {
      if (document.isQrCode) return document;
    }
    for (final document in documents) {
      if (document.isDailyAnimation) return document;
    }
    return documents.first;
  }

  DateTime? get validFrom {
    DateTime? earliest;
    for (final document in documents) {
      final start = document.startValidity;
      if (start == null) continue;
      if (earliest == null || start.isBefore(earliest)) {
        earliest = start;
      }
    }
    return earliest;
  }

  DateTime? get validUntil {
    DateTime? latest;
    for (final document in documents) {
      final end = document.endValidity;
      if (end == null) continue;
      if (latest == null || end.isAfter(latest)) {
        latest = end;
      }
    }
    return latest;
  }
}
