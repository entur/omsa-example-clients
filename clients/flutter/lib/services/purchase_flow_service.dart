import 'package:logger/logger.dart';

import 'package:omsa_demo_app/models/purchase_models.dart';
import 'package:omsa_demo_app/models/travel_models.dart';
import 'package:omsa_demo_app/services/omsa_api_service.dart';
import 'package:omsa_demo_app/services/payment_service.dart';

class PurchaseFlowService {
  PurchaseFlowService._();

  static final Logger _logger = Logger();

  static Future<PurchaseInitiation> initiatePurchase({
    required Offer offer,
  }) async {
    _logger.i('Initiating purchase for offer: ${offer.id}');
    final response = await OmsaApiService.purchaseOffer(
      offerId: offer.id,
      timestamp: DateTime.now(),
    );

    final details = PurchaseInitiation.fromMap(
      response,
      fallbackAmount: offer.properties.price.amount,
      fallbackCurrency: offer.properties.price.currencyCode,
    );

    if (details.packageId.isEmpty) {
      throw Exception('Purchase did not return a package identifier.');
    }

    return details;
  }

  static Future<PaymentSession> createPayment({
    required PurchaseInitiation purchase,
    required String paymentType,
  }) async {
    final totalAmountString = purchase.totalAmount.toStringAsFixed(2);

    final response = await PaymentService.createPayment(
      orderId: purchase.packageId,
      orderVersion: purchase.orderVersion,
      totalAmount: totalAmountString,
      transactionAmount: totalAmountString,
      currency: purchase.currencyCode,
      paymentType: paymentType,
    );

    final session = PaymentSession.fromMap(response);

    if (session.paymentId == 0 || session.transactionId == 0) {
      throw Exception('Payment session missing identifiers.');
    }

    return session;
  }

  static Future<PaymentTerminalSession> startTerminal({
    required PaymentSession session,
    required String redirectUrl,
    String terminalLanguage = 'no_NO',
  }) async {
    final response = await PaymentService.startTerminalSession(
      paymentId: session.paymentId.toString(),
      transactionId: session.transactionId.toString(),
      redirectUrl: redirectUrl,
      terminalLanguage: terminalLanguage,
    );

    final terminal = PaymentTerminalSession.fromMap(response);

    if (terminal.terminalUri.isEmpty) {
      throw Exception('Terminal did not return a launch URL.');
    }

    return terminal;
  }

  static Future<PaymentCaptureResult> capturePayment({
    required PaymentSession session,
  }) async {
    final response = await PaymentService.captureTransaction(
      paymentId: session.paymentId.toString(),
      transactionId: session.transactionId.toString(),
    );

    return PaymentCaptureResult.fromMap(response);
  }

  static Future<ConfirmedPackage> confirmPackage({
    required PurchaseInitiation purchase,
  }) async {
    final response = await OmsaApiService.confirmPackage(
      packageId: purchase.packageId,
      timestamp: DateTime.now(),
    );

    final confirmation = ConfirmedPackage.fromMap(response);

    if (confirmation.packageId.isEmpty) {
      throw Exception('Package confirmation failed to return an id.');
    }

    return confirmation;
  }

  static Future<List<TravelDocument>> fetchTravelDocuments({
    required String packageId,
  }) async {
    final response = await OmsaApiService.fetchTravelDocuments(
      packageId: packageId,
    );

    if (response is Map<String, dynamic>) {
      final documents = response['travelDocuments'] as List<dynamic>? ?? [];
      return documents
          .map((doc) => TravelDocument.fromMap(doc as Map<String, dynamic>))
          .toList();
    } else if (response is List) {
      return response
          .map((doc) => TravelDocument.fromMap(doc as Map<String, dynamic>))
          .toList();
    }

    return [];
  }
}
