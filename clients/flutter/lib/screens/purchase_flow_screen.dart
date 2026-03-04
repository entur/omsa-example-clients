import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';

import 'package:omsa_demo_app/models/purchase_models.dart';
import 'package:omsa_demo_app/models/travel_models.dart';
import 'package:omsa_demo_app/services/purchase_flow_service.dart';
import 'package:omsa_demo_app/theme/wayfare_tokens.dart';
import 'package:omsa_demo_app/widgets/payment_method_picker_drawer.dart';

class PurchaseFlowScreen extends StatefulWidget {
  final Offer offer;

  const PurchaseFlowScreen({super.key, required this.offer});

  @override
  State<PurchaseFlowScreen> createState() => _PurchaseFlowScreenState();
}

enum FlowPhase {
  selectingPayment, // User is choosing payment method
  processing, // Backend calls happening
  awaitingPayment, // External payment app/terminal opened
  completing, // Final confirmation
  success, // Done
  failed,
}

class _PurchaseFlowScreenState extends State<PurchaseFlowScreen>
    with WidgetsBindingObserver {
  static final Logger _logger = Logger();
  FlowPhase _phase = FlowPhase.selectingPayment;
  String? _error;
  PaymentMethodSelection _paymentMethodSelection = const PaymentMethodSelection(
    method: PaymentMethodType.newCard,
  );

  PurchaseInitiation? _purchase;
  PaymentSession? _payment;
  PaymentTerminalSession? _terminal;
  PaymentAppClaimSession? _appClaim;

  bool _hasLaunchedPayment = false;
  bool _hasReturnedFromPayment = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _savePendingPayment(
    int paymentId,
    int transactionId,
    String packageId,
    String paymentType,
    int orderVersion,
    double totalAmount,
    String currencyCode,
    String packageName,
    String packageDescription,
  ) async {
    _logger.d(
      'Saving pending payment: paymentId=$paymentId, transactionId=$transactionId, packageId=$packageId, type=$paymentType',
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pending_payment_id', paymentId.toString());
    await prefs.setString('pending_transaction_id', transactionId.toString());
    await prefs.setString('pending_package_id', packageId);
    await prefs.setString('pending_payment_type', paymentType);
    await prefs.setString('pending_order_version', orderVersion.toString());
    await prefs.setString('pending_total_amount', totalAmount.toString());
    await prefs.setString('pending_currency_code', currencyCode);
    await prefs.setString('pending_package_name', packageName);
    await prefs.setString('pending_package_description', packageDescription);
    _logger.d('Pending payment saved successfully');
  }

  Future<void> _clearPendingPayment() async {
    final prefs = await SharedPreferences.getInstance();
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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Detect return from external payment app but don't auto-complete.
    // For Vipps this can resume before the downstream payment state is ready.
    if (state == AppLifecycleState.resumed &&
        _phase == FlowPhase.awaitingPayment &&
        _hasLaunchedPayment &&
        !_hasReturnedFromPayment) {
      _hasReturnedFromPayment = true;
    }
  }

  Future<void> _startPurchaseFlow() async {
    setState(() {
      _phase = FlowPhase.processing;
      _error = null;
    });

    try {
      // Step 1: Initiate purchase
      final purchase = await PurchaseFlowService.initiatePurchase(
        offer: widget.offer,
      );

      // Step 2: Create payment
      final paymentType =
          _paymentMethodSelection.method == PaymentMethodType.vipps
          ? 'VIPPS'
          : 'VISA';
      final payment = await PurchaseFlowService.createPayment(
        purchase: purchase,
        paymentType: paymentType,
      );

      if (!mounted) return;

      // Step 3: Start terminal or app claim
      if (_paymentMethodSelection.method == PaymentMethodType.vipps) {
        final offerName = widget.offer.properties.summary.name.isNotEmpty
            ? widget.offer.properties.summary.name
            : 'Travel ticket from Entur';

        final appClaim = await PurchaseFlowService.startAppClaim(
          session: payment,
          description: offerName,
          phoneNumber: _paymentMethodSelection.phoneNumber!,
          redirectUrl: 'wayfareapp://payment-return',
        );

        if (!mounted) return;
        setState(() {
          _purchase = purchase;
          _payment = payment;
          _appClaim = appClaim;
          _phase = FlowPhase.awaitingPayment;
        });

        // Save state in case app is killed
        await _savePendingPayment(
          payment.paymentId,
          appClaim.transactionId,
          purchase.packageId,
          'VIPPS',
          purchase.orderVersion,
          purchase.totalAmount,
          purchase.currencyCode,
          widget.offer.properties.summary.name,
          widget.offer.properties.summary.description,
        );

        // Auto-launch Vipps
        _launchAppClaim();
      } else {
        final terminal = await PurchaseFlowService.startTerminal(
          session: payment,
          redirectUrl: 'wayfareapp://payment-return',
        );

        if (!mounted) return;
        setState(() {
          _purchase = purchase;
          _payment = payment;
          _terminal = terminal;
          _phase = FlowPhase.awaitingPayment;
        });

        // Save state in case app is killed
        await _savePendingPayment(
          payment.paymentId,
          terminal.transactionId,
          purchase.packageId,
          'VISA',
          purchase.orderVersion,
          purchase.totalAmount,
          purchase.currencyCode,
          widget.offer.properties.summary.name,
          widget.offer.properties.summary.description,
        );

        // Auto-launch payment terminal
        _launchTerminal();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _phase = FlowPhase.failed;
      });
    }
  }

  Future<void> _launchTerminal() async {
    final uri = _terminal?.terminalUri;
    if (uri == null || uri.isEmpty) return;

    _hasLaunchedPayment = true;
    final launchUri = Uri.parse(uri);
    if (!await launchUrl(launchUri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not open payment terminal';
        _phase = FlowPhase.failed;
      });
    }
  }

  Future<void> _launchAppClaim() async {
    final uri = _appClaim?.appClaimUri;
    if (uri == null || uri.isEmpty) return;

    _hasLaunchedPayment = true;
    final launchUri = Uri.parse(uri);
    if (!await launchUrl(launchUri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not open Vipps payment';
        _phase = FlowPhase.failed;
      });
    }
  }

  Future<void> _completePayment() async {
    final payment = _payment;
    final purchase = _purchase;
    if (payment == null || purchase == null) return;

    setState(() {
      _phase = FlowPhase.completing;
      _error = null;
    });

    try {
      if (_paymentMethodSelection.method == PaymentMethodType.vipps) {
        // Vipps app-claim capture is handled asynchronously by the provider.
        // Poll transaction state only.
      } else {
        await PurchaseFlowService.capturePayment(session: payment);
      }
      await PurchaseFlowService.waitForCaptureCompletion(
        session: payment,
        maxAttempts: _paymentMethodSelection.method == PaymentMethodType.vipps
            ? 60
            : 15,
      );

      final confirmation = await PurchaseFlowService.confirmPackageWithRetry(
        purchase: purchase,
      );
      await PurchaseFlowService.cacheConfirmedPackage(
        packageId: confirmation.packageId,
        packageName: widget.offer.properties.summary.name,
        packageDescription: widget.offer.properties.summary.description,
        totalAmount: purchase.totalAmount,
        currencyCode: purchase.currencyCode,
        status: confirmation.status,
      );

      if (!mounted) return;
      setState(() {
        _phase = FlowPhase.success;
      });

      // Clear pending payment state
      await _clearPendingPayment();

      if (!mounted) return;
      context.go('/tickets');
    } on PaymentPendingException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _phase = FlowPhase.awaitingPayment;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _phase = FlowPhase.failed;
      });
      final isTerminalFailure = e is PaymentFailedException;
      if (isTerminalFailure) {
        await _clearPendingPayment();
      }
    }
  }

  String _getPaymentMethodLabel() {
    switch (_paymentMethodSelection.method) {
      case PaymentMethodType.newCard:
        return 'New card';
      case PaymentMethodType.savedCard:
        return 'Saved card (VISA ••1234)';
      case PaymentMethodType.vipps:
        return 'Vipps';
    }
  }

  String _getPaymentMethodSubtitle() {
    switch (_paymentMethodSelection.method) {
      case PaymentMethodType.newCard:
        return 'Pay with a new credit or debit card';
      case PaymentMethodType.savedCard:
        return 'VISA ending in 1234';
      case PaymentMethodType.vipps:
        return _paymentMethodSelection.phoneNumber != null
            ? 'Phone: ${_paymentMethodSelection.phoneNumber}'
            : 'Pay with your Vipps account';
    }
  }

  Future<void> _openPaymentMethodPicker() async {
    final result = await PaymentMethodPickerDrawer.show(
      context,
      initialSelection: _paymentMethodSelection,
    );
    if (result != null) {
      setState(() {
        _paymentMethodSelection = result;
      });
    }
  }

  Widget _buildPaymentMethodSelector() {
    final bool isEnabled =
        _phase == FlowPhase.selectingPayment || _phase == FlowPhase.failed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment method',
          style: AppTypography.textLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: context.tokens.strokeSubdued, width: 1),
          ),
          title: Text(_getPaymentMethodLabel()),
          subtitle: Text(_getPaymentMethodSubtitle()),
          trailing: Icon(
            Icons.chevron_right,
            color: context.tokens.textSubdued,
          ),
          onTap: isEnabled ? _openPaymentMethodPicker : null,
          enabled: isEnabled,
        ),
      ],
    );
  }

  Widget _buildOfferSummary(bool isLight) {
    final price = widget.offer.properties.price;
    final summary = widget.offer.properties.summary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              summary.name,
              style: AppTypography.textLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${price.amount.toStringAsFixed(2)} ${price.currencyCode}',
              style: AppTypography.textLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (summary.description.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            summary.description.replaceAll('\\n', '\n'),
            style: TextStyle(color: BaseLightTokens.textSubdued),
          ),
        ],
        const SizedBox(height: 12),
        Row(
          children: [
            OmsaActionChip(
              size: OmsaChipSize.small,
              label: Text(
                summary.isRefundable ? 'Refundable' : 'Non-refundable',
                style: AppTypography.textSmall,
              ),
              leadingIcon: summary.isRefundable
                  ? OmsaIcons.ValidationSuccessFilled(
                      color: SemanticColorTokens.fillSuccessDeep,
                    )
                  : OmsaIcons.ValidationExclamationFilled(
                      color: SemanticColorTokens.fillWarningDeep,
                    ),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            OmsaActionChip(
              size: OmsaChipSize.small,
              label: Text(
                summary.isExchangeable ? 'Exchangeable' : 'Non-exchangeable',
                style: AppTypography.textSmall,
              ),
              leadingIcon: summary.isExchangeable
                  ? OmsaIcons.ValidationSuccessFilled(
                      color: SemanticColorTokens.fillSuccessDeep,
                    )
                  : OmsaIcons.ValidationExclamationFilled(
                      color: SemanticColorTokens.fillWarningDeep,
                    ),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        isLight
            ? SvgPicture.asset("assets/wayfare_logo_solid.svg", width: 80)
            : SvgPicture.asset("assets/wayfare_logo_filled.svg", width: 80),
      ],
    );
  }

  Widget _buildLoadingScreen(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          Text(
            message,
            style: AppTypography.textLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.brightnessOf(context) == Brightness.light;

    // Show different screens based on phase
    if (_phase == FlowPhase.processing) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Processing',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: _buildLoadingScreen('Preparing your payment...'),
      );
    }

    if (_phase == FlowPhase.awaitingPayment) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Payment',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.payment,
                  size: 80,
                  color: context.wayfareTokens.brandPrimary,
                ),
                const SizedBox(height: 24),
                Text(
                  _paymentMethodSelection.method == PaymentMethodType.vipps
                      ? 'Complete payment in Vipps'
                      : 'Complete payment in terminal',
                  style: AppTypography.headingExtraLarge2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Return to this app when you\'re done',
                  style: TextStyle(color: BaseLightTokens.textSubdued),
                  textAlign: TextAlign.center,
                ),
                if (_error != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                OmsaButton(
                  onPressed:
                      _paymentMethodSelection.method == PaymentMethodType.vipps
                      ? _launchAppClaim
                      : _launchTerminal,
                  width: OmsaButtonWidth.fluid,
                  variant: OmsaButtonVariant.secondary,
                  leadingIcon: const Icon(Icons.open_in_new),
                  child: Text(
                    _paymentMethodSelection.method == PaymentMethodType.vipps
                        ? 'Reopen Vipps'
                        : 'Reopen terminal',
                  ),
                ),
                const SizedBox(height: 16),
                OmsaButton(
                  onPressed: _completePayment,
                  width: OmsaButtonWidth.fluid,
                  leadingIcon: const Icon(Icons.check),
                  child: const Text('I\'ve completed payment'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_phase == FlowPhase.completing) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Finalizing',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: _buildLoadingScreen('Fetching your ticket...'),
      );
    }

    // Main checkout screen (selectingPayment or failed)
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        leading: IconButton(
          icon: OmsaIcons.BackArrow(
            size: 20,
            color: context.wayfareTokens.brandPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 2,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(top: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildOfferSummary(isLight),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            _buildPaymentMethodSelector(),
            if (_error != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ],
            const SizedBox(height: 24),
            OmsaButton(
              onPressed: _startPurchaseFlow,
              width: OmsaButtonWidth.fluid,
              leadingIcon: const Icon(Icons.shopping_cart_checkout),
              child: const Text('Pay now'),
            ),
          ],
        ),
      ),
    );
  }
}
