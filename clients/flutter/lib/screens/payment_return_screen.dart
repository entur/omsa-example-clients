import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:omsa_demo_app/models/purchase_models.dart';
import 'package:omsa_demo_app/services/purchase_flow_service.dart';

class PaymentReturnScreen extends StatefulWidget {
  const PaymentReturnScreen({super.key});

  @override
  State<PaymentReturnScreen> createState() => _PaymentReturnScreenState();
}

class _PaymentReturnScreenState extends State<PaymentReturnScreen> {
  @override
  void initState() {
    super.initState();
    _handlePaymentReturn();
  }

  Future<void> _handlePaymentReturn() async {
    final prefs = await SharedPreferences.getInstance();
    final pendingPaymentId = prefs.getString('pending_payment_id');
    final pendingTransactionId = prefs.getString('pending_transaction_id');
    final pendingPackageId = prefs.getString('pending_package_id');
    final pendingPaymentType = prefs.getString('pending_payment_type');
    final pendingOrderVersion = prefs.getString('pending_order_version');
    final pendingTotalAmount = prefs.getString('pending_total_amount');
    final pendingCurrencyCode = prefs.getString('pending_currency_code');

    debugPrint(
      'PaymentReturn: paymentId=$pendingPaymentId, transactionId=$pendingTransactionId, packageId=$pendingPackageId, type=$pendingPaymentType',
    );

    if (pendingPaymentId == null ||
        pendingPackageId == null ||
        pendingTransactionId == null ||
        pendingOrderVersion == null ||
        pendingTotalAmount == null ||
        pendingCurrencyCode == null) {
      // No pending payment, go home
      debugPrint('PaymentReturn: No pending payment found, navigating to home');
      if (!mounted) return;
      context.go('/');
      return;
    }

    try {
      debugPrint('PaymentReturn: Starting payment completion');
      final paymentIdInt = int.parse(pendingPaymentId);
      final transactionIdInt = int.parse(pendingTransactionId);
      final purchase = PurchaseInitiation(
        packageId: pendingPackageId,
        orderVersion: int.parse(pendingOrderVersion),
        totalAmount: double.parse(pendingTotalAmount),
        currencyCode: pendingCurrencyCode,
      );
      final payment = PaymentSession(
        paymentId: paymentIdInt,
        transactionId: transactionIdInt,
        totalAmount: pendingTotalAmount,
        currency: pendingCurrencyCode,
        status: 'UNKNOWN',
      );

      if (pendingPaymentType == 'VIPPS') {
        debugPrint('PaymentReturn: Skipping capture for Vipps app-claim');
      } else {
        debugPrint('PaymentReturn: Capturing card payment');
        await PurchaseFlowService.capturePayment(session: payment);
        debugPrint('PaymentReturn: Card payment captured');
      }
      await PurchaseFlowService.waitForCaptureCompletion(session: payment);

      debugPrint('PaymentReturn: Confirming package with retry');
      final confirmation = await PurchaseFlowService.confirmPackageWithRetry(
        purchase: purchase,
      );
      debugPrint('PaymentReturn: Package confirmed: ${confirmation.packageId}');

      // Clear pending payment state
      await prefs.remove('pending_payment_id');
      await prefs.remove('pending_transaction_id');
      await prefs.remove('pending_package_id');
      await prefs.remove('pending_payment_type');
      await prefs.remove('pending_order_version');
      await prefs.remove('pending_total_amount');
      await prefs.remove('pending_currency_code');

      if (!mounted) return;

      // Navigate to confirmation screen.
      debugPrint('PaymentReturn: Navigating to confirmation screen');
      final encodedPackageId = Uri.encodeComponent(confirmation.packageId);
      context.pushReplacement('/purchase-confirmation/$encodedPackageId');
    } catch (e) {
      debugPrint('PaymentReturn: Error completing payment: $e');
      // Clear pending payment on error
      await prefs.remove('pending_payment_id');
      await prefs.remove('pending_transaction_id');
      await prefs.remove('pending_package_id');
      await prefs.remove('pending_payment_type');
      await prefs.remove('pending_order_version');
      await prefs.remove('pending_total_amount');
      await prefs.remove('pending_currency_code');

      if (!mounted) return;

      // Show error and go home
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to complete payment: $e')));
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(
              'Completing your payment...',
              style: AppTypography.textLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
