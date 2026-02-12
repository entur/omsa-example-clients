import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:omsa_demo_app/models/purchase_models.dart';
import 'package:omsa_demo_app/models/ticket_wallet_models.dart';

class TicketWalletService {
  TicketWalletService._();

  static const String _storageKey = 'ticket_wallet_packages_v1';
  static final Logger _logger = Logger();

  static Future<List<TicketPackage>> getPackages() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.trim().isEmpty) {
      return <TicketPackage>[];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return <TicketPackage>[];
      }

      final packages = <TicketPackage>[];
      for (final item in decoded) {
        try {
          if (item is Map<String, dynamic>) {
            packages.add(TicketPackage.fromMap(item));
          } else if (item is Map) {
            packages.add(
              TicketPackage.fromMap(Map<String, dynamic>.from(item)),
            );
          }
        } on FormatException catch (e) {
          _logger.w('Skipping malformed ticket package: $e');
        }
      }

      packages.sort((a, b) => b.purchasedAt.compareTo(a.purchasedAt));
      return packages;
    } catch (error, stackTrace) {
      _logger.w(
        'Failed to parse ticket wallet cache, returning empty state.',
        error: error,
        stackTrace: stackTrace,
      );
      return <TicketPackage>[];
    }
  }

  static Future<TicketPackage?> getPackage(String packageId) async {
    final packages = await getPackages();
    for (final package in packages) {
      if (package.packageId == packageId) {
        return package;
      }
    }
    return null;
  }

  static Future<void> rememberPackage({
    required String packageId,
    DateTime? purchasedAt,
    String? packageName,
    String? packageDescription,
    double? totalAmount,
    String? currencyCode,
    String? status,
  }) async {
    if (packageId.trim().isEmpty) {
      return;
    }

    final packages = await getPackages();
    final index = packages.indexWhere((item) => item.packageId == packageId);
    if (index >= 0) {
      final existing = packages[index];
      final updated = TicketPackage(
        packageId: existing.packageId,
        purchasedAt: existing.purchasedAt,
        lastSyncedAt: existing.lastSyncedAt,
        documents: existing.documents,
        packageName: packageName ?? existing.packageName,
        packageDescription: packageDescription ?? existing.packageDescription,
        totalAmount: totalAmount ?? existing.totalAmount,
        currencyCode: currencyCode ?? existing.currencyCode,
        status: status ?? existing.status,
      );
      packages[index] = updated;
      await _writePackages(packages);
      return;
    }

    final now = DateTime.now().toUtc();
    packages.add(
      TicketPackage(
        packageId: packageId,
        purchasedAt: purchasedAt?.toUtc() ?? now,
        lastSyncedAt: null,
        documents: const [],
        packageName: packageName,
        packageDescription: packageDescription,
        totalAmount: totalAmount,
        currencyCode: currencyCode,
        status: status,
      ),
    );
    await _writePackages(packages);
  }

  static Future<void> upsertPackage({
    required String packageId,
    required List<TravelDocument> documents,
    DateTime? purchasedAt,
    String? packageName,
    String? packageDescription,
    double? totalAmount,
    String? currencyCode,
    String? status,
  }) async {
    if (packageId.trim().isEmpty) {
      return;
    }

    final packages = await getPackages();
    final index = packages.indexWhere((item) => item.packageId == packageId);
    final existing = index >= 0 ? packages[index] : null;
    final now = DateTime.now().toUtc();

    final package = TicketPackage(
      packageId: packageId,
      purchasedAt: purchasedAt?.toUtc() ?? existing?.purchasedAt ?? now,
      lastSyncedAt: now,
      documents: documents,
      packageName: packageName ?? existing?.packageName,
      packageDescription: packageDescription ?? existing?.packageDescription,
      totalAmount: totalAmount ?? existing?.totalAmount,
      currencyCode: currencyCode ?? existing?.currencyCode,
      status: status ?? existing?.status,
    );

    if (index >= 0) {
      packages[index] = package;
    } else {
      packages.add(package);
    }

    await _writePackages(packages);
  }

  static Future<void> _writePackages(List<TicketPackage> packages) async {
    packages.sort((a, b) => b.purchasedAt.compareTo(a.purchasedAt));
    final prefs = await SharedPreferences.getInstance();
    final payload = packages.map((package) => package.toMap()).toList();
    await prefs.setString(_storageKey, jsonEncode(payload));
  }
}
