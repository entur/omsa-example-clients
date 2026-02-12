import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
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
  static final Logger _logger = Logger();
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
    final pendingPackageName = prefs.getString('pending_package_name');
    final pendingPackageDescription = prefs.getString(
      'pending_package_description',
    );

    _logger.d(
      'PaymentReturn: paymentId=$pendingPaymentId, transactionId=$pendingTransactionId, packageId=$pendingPackageId, type=$pendingPaymentType',
    );

    if (pendingPaymentId == null ||
        pendingPackageId == null ||
        pendingTransactionId == null ||
        pendingOrderVersion == null ||
        pendingTotalAmount == null ||
        pendingCurrencyCode == null) {
      // No pending payment, go home
      _logger.i('PaymentReturn: No pending payment found, navigating to home');
      if (!mounted) return;
      context.go('/');
      return;
    }

    try {
      _logger.i('PaymentReturn: Starting payment completion');
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
        _logger.i('PaymentReturn: Vipps flow detected, skipping capture call');
      } else {
        _logger.i('PaymentReturn: Capturing card payment');
        await PurchaseFlowService.capturePayment(session: payment);
        _logger.i('PaymentReturn: Card payment captured');
      }
      await PurchaseFlowService.waitForCaptureCompletion(
        session: payment,
        maxAttempts: pendingPaymentType == 'VIPPS' ? 60 : 15,
      );

      _logger.i('PaymentReturn: Confirming package with retry');
      final confirmation = await PurchaseFlowService.confirmPackageWithRetry(
        purchase: purchase,
      );
      _logger.i('PaymentReturn: Package confirmed: ${confirmation.packageId}');
      await PurchaseFlowService.cacheConfirmedPackage(
        packageId: confirmation.packageId,
        packageName: pendingPackageName,
        packageDescription: pendingPackageDescription,
        totalAmount: double.tryParse(pendingTotalAmount),
        currencyCode: pendingCurrencyCode,
        status: confirmation.status,
      );

      // Clear pending payment state
      await prefs.remove('pending_payment_id');
      await prefs.remove('pending_transaction_id');
      await prefs.remove('pending_package_id');
      await prefs.remove('pending_payment_type');
      await prefs.remove('pending_order_version');
      await prefs.remove('pending_total_amount');
      await prefs.remove('pending_currency_code');
      await prefs.remove('pending_package_name');
      await prefs.remove('pending_package_description');

      if (!mounted) return;

      // Navigate to confirmation screen.
      _logger.i('PaymentReturn: Navigating to tickets');
      context.go('/tickets');
    } on PaymentPendingException catch (e) {
      _logger.w('PaymentReturn: Payment still pending', error: e);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment still processing. Please try again.')),
      );
      context.go('/');
    } catch (e) {
      _logger.e('PaymentReturn: Error completing payment', error: e);
      if (e is PaymentFailedException) {
        await prefs.remove('pending_payment_id');
        await prefs.remove('pending_transaction_id');
        await prefs.remove('pending_package_id');
        await prefs.remove('pending_payment_type');
        await prefs.remove('pending_order_version');
        await prefs.remove('pending_total_amount');
        await prefs.remove('pending_currency_code');
        await prefs.remove('pending_package_name');
        await prefs.remove('pending_package_description');
      }

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
