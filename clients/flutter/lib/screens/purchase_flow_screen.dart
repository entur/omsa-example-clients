import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';

import 'package:omsa_demo_app/models/purchase_models.dart';
import 'package:omsa_demo_app/models/travel_models.dart';
import 'package:omsa_demo_app/services/purchase_flow_service.dart';
import 'package:omsa_demo_app/screens/ticket_screen.dart';
import 'package:omsa_demo_app/theme/wayfare_tokens.dart';
import 'package:omsa_demo_app/widgets/payment_method_picker_drawer.dart';

class PurchaseFlowScreen extends StatefulWidget {
  final Offer offer;

  const PurchaseFlowScreen({super.key, required this.offer});

  @override
  State<PurchaseFlowScreen> createState() => _PurchaseFlowScreenState();
}

enum FlowPhase {
  idle,
  purchasing,
  terminalReady,
  appClaimReady,
  awaitingCapture,
  finished,
  failed,
}

class _PurchaseFlowScreenState extends State<PurchaseFlowScreen> {
  FlowPhase _phase = FlowPhase.idle;
  bool _isProcessing = false;
  String? _error;
  PaymentMethodSelection _paymentMethodSelection = const PaymentMethodSelection(
    method: PaymentMethodType.newCard,
  );

  PurchaseInitiation? _purchase;
  PaymentSession? _payment;
  PaymentTerminalSession? _terminal;
  PaymentAppClaimSession? _appClaim;
  PaymentCaptureResult? _capture;
  ConfirmedPackage? _confirmation;
  List<TravelDocument> _documents = [];

  Future<void> _startCheckout() async {
    setState(() {
      _isProcessing = true;
      _error = null;
      _phase = FlowPhase.purchasing;
      _purchase = null;
      _payment = null;
      _terminal = null;
      _appClaim = null;
      _capture = null;
      _confirmation = null;
      _documents = [];
    });

    try {
      final purchase = await PurchaseFlowService.initiatePurchase(
        offer: widget.offer,
      );

      final paymentType =
          _paymentMethodSelection.method == PaymentMethodType.vipps
          ? 'VIPPS'
          : 'VISA';
      final payment = await PurchaseFlowService.createPayment(
        purchase: purchase,
        paymentType: paymentType,
      );

      if (!mounted) return;

      if (_paymentMethodSelection.method == PaymentMethodType.vipps) {
        final offerName = widget.offer.properties.summary.name.isNotEmpty
            ? widget.offer.properties.summary.name
            : 'Travel ticket from Entur';

        final appClaim = await PurchaseFlowService.startAppClaim(
          session: payment,
          description: offerName,
          phoneNumber: _paymentMethodSelection.phoneNumber!,
          redirectUrl: 'https://entur.no',
        );

        if (!mounted) return;
        setState(() {
          _purchase = purchase;
          _payment = payment;
          _appClaim = appClaim;
          _phase = FlowPhase.appClaimReady;
          _isProcessing = false;
        });
      } else {
        final terminal = await PurchaseFlowService.startTerminal(
          session: payment,
          redirectUrl: 'https://entur.no',
        );

        if (!mounted) return;
        setState(() {
          _purchase = purchase;
          _payment = payment;
          _terminal = terminal;
          _phase = FlowPhase.terminalReady;
          _isProcessing = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _phase = FlowPhase.failed;
        _isProcessing = false;
      });
    }
  }

  Future<void> _openTerminal() async {
    final uri = _terminal?.terminalUri;
    if (uri == null || uri.isEmpty) return;

    final launchUri = Uri.parse(uri);
    if (!await launchUrl(launchUri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open payment terminal link')),
      );
    }
  }

  Future<void> _openAppClaim() async {
    final uri = _appClaim?.appClaimUri;
    if (uri == null || uri.isEmpty) return;

    final launchUri = Uri.parse(uri);
    if (!await launchUrl(launchUri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open VIPPS payment link')),
      );
    }
  }

  Future<void> _completePayment() async {
    if (_payment == null || _purchase == null) return;

    setState(() {
      _isProcessing = true;
      _error = null;
      _phase = FlowPhase.awaitingCapture;
    });

    try {
      // Only capture for card payments - VIPPS payments are auto-captured
      PaymentCaptureResult? capture;
      if (_paymentMethodSelection.method != PaymentMethodType.vipps) {
        capture = await PurchaseFlowService.capturePayment(session: _payment!);
      }

      final confirmation = await PurchaseFlowService.confirmPackage(
        purchase: _purchase!,
      );
      final documents = await PurchaseFlowService.fetchTravelDocuments(
        packageId: confirmation.packageId,
      );

      if (!mounted) return;
      setState(() {
        _capture = capture;
        _confirmation = confirmation;
        _documents = documents;
        _phase = FlowPhase.finished;
        _isProcessing = false;
      });

      if (documents.isNotEmpty) {
        final primaryTicket = _selectPrimaryTicket(documents);
        if (!mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TicketScreen(
              documents: documents,
              primaryTicket: primaryTicket,
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _phase = FlowPhase.failed;
        _isProcessing = false;
      });
    }
  }

  TravelDocument? _selectPrimaryTicket(List<TravelDocument> documents) {
    TravelDocument? qrDoc = documents.firstWhere(
      (doc) => doc.travelDocumentType.toUpperCase() == 'QRCODE',
      orElse: () => documents.first,
    );

    if (qrDoc.travelDocumentType.toUpperCase() != 'QRCODE') {
      qrDoc = documents.first;
    }

    return qrDoc;
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
        _phase == FlowPhase.idle || _phase == FlowPhase.failed;

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

  Widget _buildStatusTile({
    required String title,
    required String subtitle,
    required bool completed,
    bool isActive = false,
  }) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);

        final icon = completed
            ? Icons.check_circle
            : isActive
            ? Icons.timelapse
            : Icons.radio_button_unchecked;
        final color = completed
            ? Colors
                  .green // Success color for completed
            : isActive
            ? theme.colorScheme.primary
            : BaseLightTokens.shapeDisabled;

        return ListTile(
          leading: Icon(icon, color: color),
          title: Text(title),
          subtitle: Text(subtitle),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.brightnessOf(context) == Brightness.light;

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
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            Text(
              'Progress',
              style: AppTypography.textLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusTile(
                  title: 'Purchase offer',
                  subtitle: _purchase != null
                      ? 'Package ID: ${_purchase!.packageId}'
                      : 'Create OMSA order',
                  completed: _purchase != null,
                  isActive: _phase == FlowPhase.purchasing && _purchase == null,
                ),
                _buildStatusTile(
                  title: 'Create payment',
                  subtitle: _payment != null
                      ? 'Payment ID: ${_payment!.paymentId}'
                      : 'Prepare payment request',
                  completed: _payment != null,
                  isActive: _phase == FlowPhase.purchasing && _payment == null,
                ),
                if (_paymentMethodSelection.method == PaymentMethodType.vipps)
                  _buildStatusTile(
                    title: 'Open Vipps payment',
                    subtitle: _appClaim != null
                        ? 'Transaction ID: ${_appClaim!.transactionId}'
                        : 'Awaiting app-claim URL',
                    completed:
                        _appClaim != null &&
                        (_phase == FlowPhase.awaitingCapture ||
                            _phase == FlowPhase.finished),
                    isActive: _phase == FlowPhase.appClaimReady,
                  )
                else
                  _buildStatusTile(
                    title: 'Open payment terminal',
                    subtitle: _terminal != null
                        ? 'Transaction ID: ${_terminal!.transactionId}'
                        : 'Awaiting terminal URL',
                    completed:
                        _terminal != null &&
                        (_phase == FlowPhase.awaitingCapture ||
                            _phase == FlowPhase.finished),
                    isActive: _phase == FlowPhase.terminalReady,
                  ),
                if (_paymentMethodSelection.method == PaymentMethodType.vipps)
                  _buildStatusTile(
                    title: 'Payment confirmed',
                    subtitle:
                        _phase == FlowPhase.finished ||
                            _phase == FlowPhase.awaitingCapture
                        ? 'Auto-captured by Vipps'
                        : 'Waiting for Vipps confirmation',
                    completed:
                        _phase == FlowPhase.finished ||
                        _phase == FlowPhase.awaitingCapture,
                    isActive: false,
                  )
                else
                  _buildStatusTile(
                    title: 'Capture payment',
                    subtitle: _capture != null
                        ? 'Status: ${_capture!.status}'
                        : 'Confirm payment capture',
                    completed: _capture != null,
                    isActive:
                        _phase == FlowPhase.awaitingCapture && _capture == null,
                  ),
                _buildStatusTile(
                  title: 'Confirm package',
                  subtitle: _confirmation != null
                      ? 'Package ID: ${_confirmation!.packageId}'
                      : 'Finalize OMSA package',
                  completed: _confirmation != null,
                  isActive:
                      _phase == FlowPhase.awaitingCapture &&
                      _confirmation == null,
                ),
                _buildStatusTile(
                  title: 'Retrieve tickets',
                  subtitle: _documents.isNotEmpty
                      ? 'Received ${_documents.length} document(s)'
                      : 'Fetch travel documents',
                  completed: _documents.isNotEmpty,
                  isActive:
                      _phase == FlowPhase.awaitingCapture && _documents.isEmpty,
                ),
              ],
            ),
            if (_error != null) ...[
              const SizedBox(height: 16),
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
            if (_phase == FlowPhase.idle || _phase == FlowPhase.failed)
              OmsaButton(
                onPressed: _isProcessing ? null : _startCheckout,
                isLoading: _isProcessing,
                width: OmsaButtonWidth.fluid,
                leadingIcon: const Icon(Icons.shopping_cart_checkout),
                child: const Text('Purchase offer and prepare payment'),
              ),
            if (_phase == FlowPhase.terminalReady) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  'Complete the payment in the terminal, then manually switch back to this app to confirm your order.',
                  style: TextStyle(
                    color: BaseLightTokens.textSubdued,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: _isProcessing ? null : _openTerminal,
                width: OmsaButtonWidth.fluid,
                variant: OmsaButtonVariant.secondary,
                leadingIcon: const Icon(Icons.open_in_new),
                child: const Text('Open payment terminal'),
              ),
              const SizedBox(height: 12),
              OmsaButton(
                onPressed: _isProcessing ? null : _completePayment,
                isLoading: _isProcessing,
                width: OmsaButtonWidth.fluid,
                leadingIcon: const Icon(Icons.check),
                child: const Text('Capture payment and fetch ticket'),
              ),
              if (_terminal?.terminalUri.isNotEmpty ?? false) ...[
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _isProcessing ? null : _openTerminal,
                  child: Text(
                    _terminal!.terminalUri,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ],
            if (_phase == FlowPhase.appClaimReady) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  'Complete the payment in Vipps, then manually switch back to this app to confirm your order.',
                  style: TextStyle(
                    color: BaseLightTokens.textSubdued,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: _isProcessing ? null : _openAppClaim,
                width: OmsaButtonWidth.fluid,
                variant: OmsaButtonVariant.secondary,
                leadingIcon: const Icon(Icons.open_in_new),
                child: const Text('Open Vipps payment'),
              ),
              const SizedBox(height: 12),
              OmsaButton(
                onPressed: _isProcessing ? null : _completePayment,
                isLoading: _isProcessing,
                width: OmsaButtonWidth.fluid,
                leadingIcon: const Icon(Icons.check),
                child: const Text('Confirm order and fetch ticket'),
              ),
              if (_appClaim?.appClaimUri.isNotEmpty ?? false) ...[
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _isProcessing ? null : _openAppClaim,
                  child: Text(
                    _appClaim!.appClaimUri,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ],
            if (_phase == FlowPhase.finished)
              OmsaButton(
                onPressed: () {
                  if (_documents.isEmpty) return;
                  final doc = _selectPrimaryTicket(_documents);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TicketScreen(
                        documents: _documents,
                        primaryTicket: doc,
                      ),
                    ),
                  );
                },
                width: OmsaButtonWidth.fluid,
                leadingIcon: const Icon(Icons.qr_code),
                child: const Text('View ticket'),
              ),
          ],
        ),
      ),
    );
  }
}
