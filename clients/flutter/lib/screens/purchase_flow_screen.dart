import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:omsa_design_system/omsa_design_system.dart';

import 'package:omsa_demo_app/models/purchase_models.dart';
import 'package:omsa_demo_app/models/travel_models.dart';
import 'package:omsa_demo_app/services/purchase_flow_service.dart';
import 'package:omsa_demo_app/screens/ticket_screen.dart';

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

enum PaymentMethod { visa, vipps }

class _PurchaseFlowScreenState extends State<PurchaseFlowScreen> {
  FlowPhase _phase = FlowPhase.idle;
  bool _isProcessing = false;
  String? _error;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.visa;
  final TextEditingController _phoneController = TextEditingController();
  String? _phoneError;

  PurchaseInitiation? _purchase;
  PaymentSession? _payment;
  PaymentTerminalSession? _terminal;
  PaymentAppClaimSession? _appClaim;
  PaymentCaptureResult? _capture;
  ConfirmedPackage? _confirmation;
  List<TravelDocument> _documents = [];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  bool _isValidNorwegianPhone(String phone) {
    // Norwegian phone numbers are 8 digits
    final phoneRegex = RegExp(r'^\d{8}$');
    return phoneRegex.hasMatch(phone);
  }

  String? _validatePhoneNumber() {
    if (_selectedPaymentMethod == PaymentMethod.vipps) {
      final phone = _phoneController.text.trim();
      if (phone.isEmpty) {
        return 'Phone number is required for Vipps payments';
      }
      if (!_isValidNorwegianPhone(phone)) {
        return 'Please enter a valid 8-digit Norwegian phone number';
      }
    }
    return null;
  }

  Future<void> _startCheckout() async {
    final phoneValidationError = _validatePhoneNumber();
    if (phoneValidationError != null) {
      setState(() {
        _phoneError = phoneValidationError;
      });
      return;
    }

    setState(() {
      _isProcessing = true;
      _error = null;
      _phoneError = null;
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

      final paymentType = _selectedPaymentMethod == PaymentMethod.visa
          ? 'VISA'
          : 'VIPPS';
      final payment = await PurchaseFlowService.createPayment(
        purchase: purchase,
        paymentType: paymentType,
      );

      if (!mounted) return;

      if (_selectedPaymentMethod == PaymentMethod.visa) {
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
      } else {
        // Use the actual offer name for the Vipps payment description
        final offerName = widget.offer.properties.summary.name.isNotEmpty
            ? widget.offer.properties.summary.name
            : 'Travel ticket from Entur';

        final appClaim = await PurchaseFlowService.startAppClaim(
          session: payment,
          description: offerName,
          phoneNumber: _phoneController.text.trim(),
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
      // Only capture for VISA payments - VIPPS payments are auto-captured
      PaymentCaptureResult? capture;
      if (_selectedPaymentMethod == PaymentMethod.visa) {
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

  Widget _buildPaymentMethodSelector() {
    return OmsaCard(
      variant: OmsaCardVariant.elevated,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment method',
            style: AppTypography.textLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          RadioGroup<PaymentMethod>(
            groupValue: _selectedPaymentMethod,
            onChanged: _phase == FlowPhase.idle || _phase == FlowPhase.failed
                ? (PaymentMethod? value) {
                    if (value != null) {
                      setState(() {
                        _selectedPaymentMethod = value;
                        _phoneError = null; // Clear error when switching
                      });
                    }
                  }
                : (PaymentMethod? value) {},
            child: Row(
              children: [
                Expanded(
                  child: RadioListTile<PaymentMethod>(
                    title: const Text('Card (VISA)'),
                    value: PaymentMethod.visa,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: RadioListTile<PaymentMethod>(
                    title: const Text('Vipps'),
                    value: PaymentMethod.vipps,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
          if (_selectedPaymentMethod == PaymentMethod.vipps) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Phone number',
              style: AppTypography.textLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            OmsaTextField(
              controller: _phoneController,
              label: 'Phone number',
              hint: '12345678',
              keyboardType: TextInputType.phone,
              maxLength: 8,
              disabled: _phase != FlowPhase.idle && _phase != FlowPhase.failed,
              feedback: _phoneError,
              variant: _phoneError != null
                  ? OmsaTextFieldVariant.negative
                  : OmsaTextFieldVariant.none,
              onChanged: (value) {
                // Clear error when user starts typing
                if (_phoneError != null) {
                  setState(() {
                    _phoneError = null;
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              'Please enter the phone number you want to use for Vipps',
              style: TextStyle(
                color: BaseLightTokens.textSubdued,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOfferSummary() {
    final price = widget.offer.properties.price;
    final summary = widget.offer.properties.summary;

    return OmsaCard(
      variant: OmsaCardVariant.elevated,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            summary.name,
            style: AppTypography.textLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${price.amount.toStringAsFixed(2)} ${price.currencyCode}',
                style: AppTypography.textLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  OmsaActionChip(
                    size: OmsaChipSize.small,
                    label: Text(
                      summary.isRefundable ? 'Refundable' : 'Non-refundable',
                    ),
                    leadingIcon: Icon(
                      summary.isRefundable ? Icons.check_circle : Icons.cancel,
                      size: 16,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 4),
                  OmsaActionChip(
                    size: OmsaChipSize.small,
                    label: Text(
                      summary.isExchangeable
                          ? 'Exchangeable'
                          : 'Non-exchangeable',
                    ),
                    leadingIcon: Icon(
                      summary.isExchangeable ? Icons.swap_horiz : Icons.block,
                      size: 16,
                    ),
                    onPressed: () {},
                  ),
                ],
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
        ],
      ),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildOfferSummary(),
            const SizedBox(height: 16),
            _buildPaymentMethodSelector(),
            const SizedBox(height: 16),
            OmsaCard(
              variant: OmsaCardVariant.elevated,
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Progress',
                      style: AppTypography.textLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildStatusTile(
                    title: 'Purchase offer',
                    subtitle: _purchase != null
                        ? 'Package ID: ${_purchase!.packageId}'
                        : 'Create OMSA order',
                    completed: _purchase != null,
                    isActive:
                        _phase == FlowPhase.purchasing && _purchase == null,
                  ),
                  _buildStatusTile(
                    title: 'Create payment',
                    subtitle: _payment != null
                        ? 'Payment ID: ${_payment!.paymentId}'
                        : 'Prepare payment request',
                    completed: _payment != null,
                    isActive:
                        _phase == FlowPhase.purchasing && _payment == null,
                  ),
                  if (_selectedPaymentMethod == PaymentMethod.visa)
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
                    )
                  else
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
                    ),
                  if (_selectedPaymentMethod == PaymentMethod.visa)
                    _buildStatusTile(
                      title: 'Capture payment',
                      subtitle: _capture != null
                          ? 'Status: ${_capture!.status}'
                          : 'Confirm payment capture',
                      completed: _capture != null,
                      isActive:
                          _phase == FlowPhase.awaitingCapture &&
                          _capture == null,
                    )
                  else
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
                        _phase == FlowPhase.awaitingCapture &&
                        _documents.isEmpty,
                  ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                ],
              ),
            ),
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
