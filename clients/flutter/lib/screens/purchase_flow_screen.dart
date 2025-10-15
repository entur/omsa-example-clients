import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:omsa_demo_app/models/purchase_models.dart';
import 'package:omsa_demo_app/models/travel_models.dart';
import 'package:omsa_demo_app/services/purchase_flow_service.dart';
import 'ticket_screen.dart';

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
  awaitingCapture,
  finished,
  failed,
}

class _PurchaseFlowScreenState extends State<PurchaseFlowScreen> {
  FlowPhase _phase = FlowPhase.idle;
  bool _isProcessing = false;
  String? _error;

  PurchaseInitiation? _purchase;
  PaymentSession? _payment;
  PaymentTerminalSession? _terminal;
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
      _capture = null;
      _confirmation = null;
      _documents = [];
    });

    try {
      final purchase = await PurchaseFlowService.initiatePurchase(
        offer: widget.offer,
      );
      final payment = await PurchaseFlowService.createPayment(
        purchase: purchase,
        paymentType: 'VISA',
      );
      final terminal = await PurchaseFlowService.startTerminal(
        session: payment,
        redirectUrl: 'https://example.com/payment/return',
      );

      if (!mounted) return;
      setState(() {
        _purchase = purchase;
        _payment = payment;
        _terminal = terminal;
        _phase = FlowPhase.terminalReady;
        _isProcessing = false;
      });
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

  Future<void> _completePayment() async {
    if (_payment == null || _purchase == null) return;

    setState(() {
      _isProcessing = true;
      _error = null;
      _phase = FlowPhase.awaitingCapture;
    });

    try {
      final capture = await PurchaseFlowService.capturePayment(
        session: _payment!,
      );
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

  Widget _buildOfferSummary() {
    final price = widget.offer.properties.price;
    final summary = widget.offer.properties.summary;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              summary.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${price.amount.toStringAsFixed(2)} ${price.currencyCode}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildPill(
                      summary.isRefundable ? 'Refundable' : 'Non-refundable',
                      summary.isRefundable ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(height: 4),
                    _buildPill(
                      summary.isExchangeable
                          ? 'Exchangeable'
                          : 'Non-exchangeable',
                      summary.isExchangeable ? Colors.green : Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
            if (summary.description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                summary.description.replaceAll('\\n', '\n'),
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStatusTile({
    required String title,
    required String subtitle,
    required bool completed,
    bool isActive = false,
  }) {
    final icon = completed
        ? Icons.check_circle
        : isActive
            ? Icons.timelapse
            : Icons.radio_button_unchecked;
    final color = completed
        ? Colors.green
        : isActive
            ? Colors.blue
            : Colors.grey;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildOfferSummary(),
            const SizedBox(height: 16),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Progress',
                      style: TextStyle(
                        fontSize: 18,
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
                  _buildStatusTile(
                    title: 'Open payment terminal',
                    subtitle: _terminal != null
                        ? 'Transaction ID: ${_terminal!.transactionId}'
                        : 'Awaiting terminal URL',
                    completed: _terminal != null &&
                        (_phase == FlowPhase.awaitingCapture ||
                            _phase == FlowPhase.finished),
                    isActive: _phase == FlowPhase.terminalReady,
                  ),
                  _buildStatusTile(
                    title: 'Capture payment',
                    subtitle: _capture != null
                        ? 'Status: ${_capture!.status}'
                        : 'Confirm payment capture',
                    completed: _capture != null,
                    isActive: _phase == FlowPhase.awaitingCapture &&
                        _capture == null,
                  ),
                  _buildStatusTile(
                    title: 'Confirm package',
                    subtitle: _confirmation != null
                        ? 'Package ID: ${_confirmation!.packageId}'
                        : 'Finalize OMSA package',
                    completed: _confirmation != null,
                    isActive: _phase == FlowPhase.awaitingCapture &&
                        _confirmation == null,
                  ),
                  _buildStatusTile(
                    title: 'Retrieve tickets',
                    subtitle: _documents.isNotEmpty
                        ? 'Received ${_documents.length} document(s)'
                        : 'Fetch travel documents',
                    completed: _documents.isNotEmpty,
                    isActive: _phase == FlowPhase.awaitingCapture &&
                        _documents.isEmpty,
                  ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (_phase == FlowPhase.idle || _phase == FlowPhase.failed)
              ElevatedButton.icon(
                onPressed: _isProcessing ? null : _startCheckout,
                icon: _isProcessing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.shopping_cart_checkout),
                label: const Text('Purchase offer and prepare payment'),
              ),
            if (_phase == FlowPhase.terminalReady) ...[
              ElevatedButton.icon(
                onPressed: _isProcessing ? null : _openTerminal,
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open payment terminal'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _isProcessing ? null : _completePayment,
                icon: _isProcessing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.check),
                label: const Text('Capture payment and fetch ticket'),
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
            if (_phase == FlowPhase.finished)
              ElevatedButton.icon(
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
                icon: const Icon(Icons.qr_code),
                label: const Text('View ticket'),
              ),
          ],
        ),
      ),
    );
  }
}
