import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences keys for pending payment state.
///
/// Used by both [PurchaseFlowScreen] and [PaymentReturnScreen] to persist
/// and restore payment state across app restarts.
class PendingPaymentKeys {
  PendingPaymentKeys._();

  static const paymentId = 'pending_payment_id';
  static const transactionId = 'pending_transaction_id';
  static const packageId = 'pending_package_id';
  static const paymentType = 'pending_payment_type';
  static const orderVersion = 'pending_order_version';
  static const totalAmount = 'pending_total_amount';
  static const currencyCode = 'pending_currency_code';
  static const packageName = 'pending_package_name';
  static const packageDescription = 'pending_package_description';

  static const _allKeys = [
    paymentId,
    transactionId,
    packageId,
    paymentType,
    orderVersion,
    totalAmount,
    currencyCode,
    packageName,
    packageDescription,
  ];

  static Future<void> clear(SharedPreferences prefs) async {
    for (final key in _allKeys) {
      await prefs.remove(key);
    }
  }
}
