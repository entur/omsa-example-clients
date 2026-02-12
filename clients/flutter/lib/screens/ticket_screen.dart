import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:omsa_design_system/omsa_design_system.dart';

import 'package:omsa_demo_app/models/purchase_models.dart';
import 'package:omsa_demo_app/services/purchase_flow_service.dart';

class TicketScreen extends StatefulWidget {
  final String packageId;

  const TicketScreen({super.key, required this.packageId});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  bool _isLoading = true;
  String? _error;
  List<TravelDocument> _documents = const [];
  String? _selectedDocumentId;

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  Future<void> _loadDocuments() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final documents = await PurchaseFlowService.fetchTravelDocuments(
        packageId: widget.packageId,
      );
      if (!mounted) return;
      setState(() {
        _documents = documents;
        _selectedDocumentId = _selectPrimaryDocument(documents)?.id;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = 'Failed to load travel documents: $e';
      });
    }
  }

  TravelDocument? _selectedDocument() {
    if (_documents.isEmpty) return null;
    if (_selectedDocumentId != null) {
      for (final document in _documents) {
        if (document.id == _selectedDocumentId) {
          return document;
        }
      }
    }
    return _selectPrimaryDocument(_documents);
  }

  TravelDocument? _selectPrimaryDocument(List<TravelDocument> documents) {
    if (documents.isEmpty) return null;
    for (final document in documents) {
      if (document.isQrCode) return document;
    }
    return documents.first;
  }

  @override
  Widget build(BuildContext context) {
    final displayTicket = _selectedDocument();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Travel Ticket'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? _buildErrorState(context)
          : _documents.isEmpty
          ? const Center(child: Text('No travel documents available'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OmsaCard(
                    variant: OmsaCardVariant.elevated,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _TicketVisual(
                          document: displayTicket,
                          fallbackTypeLabel:
                              displayTicket?.travelDocumentType ?? 'Unknown',
                        ),
                        if (displayTicket?.startValidity != null ||
                            displayTicket?.endValidity != null) ...[
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              if (displayTicket?.startValidity != null)
                                _buildValidityChip(
                                  'Valid from',
                                  displayTicket!.startValidity!,
                                  context: context,
                                ),
                              if (displayTicket?.endValidity != null)
                                _buildValidityChip(
                                  'Valid until',
                                  displayTicket!.endValidity!,
                                  context: context,
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_documents.length > 1)
                    OmsaCard(
                      variant: OmsaCardVariant.elevated,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Travel documents',
                            style: AppTypography.textLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ..._documents.asMap().entries.map((entry) {
                            final index = entry.key;
                            final doc = entry.value;
                            final isPrimary = doc.id == displayTicket?.id;
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (index > 0) const Divider(),
                                InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    setState(() {
                                      _selectedDocumentId = doc.id;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          doc.isQrCode
                                              ? Icons.qr_code
                                              : doc.hasAnimationDetails
                                              ? Icons.movie
                                              : Icons.description,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(doc.travelDocumentType),
                                              const SizedBox(height: 2),
                                              Text(
                                                'Content: ${doc.contentType}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (isPrimary) ...[
                                          const SizedBox(width: 12),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  context.tokens.frameSubdued,
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                            ),
                                            child: const Text('Primary'),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 56,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: AppTypography.textMedium,
            ),
            const SizedBox(height: 16),
            OmsaButton(
              onPressed: _loadDocuments,
              width: OmsaButtonWidth.fluid,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidityChip(
    String label,
    DateTime value, {
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: context.tokens.frameElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.tokens.strokeSubdued),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: AppTypography.textSmall),
          const SizedBox(height: 2),
          Text(
            value.toLocal().toString().substring(0, 16),
            style: AppTypography.textSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketVisual extends StatelessWidget {
  final TravelDocument? document;
  final String fallbackTypeLabel;

  const _TicketVisual({
    required this.document,
    required this.fallbackTypeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (document == null) {
      return _placeholder(context, fallbackTypeLabel);
    }

    if (document!.isQrCode && document!.qrPayloadString != null) {
      return Column(
        children: [
          Text(
            'Scan to travel',
            style: AppTypography.textLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: BaseLightTokens.frameElevated,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: QrImageView(
              data: document!.qrPayloadString!,
              version: QrVersions.auto,
              size: 220,
              backgroundColor: BaseLightTokens.frameElevated,
            ),
          ),
        ],
      );
    }

    final bytes = document!.displayableImageBytes;
    if (bytes != null && bytes.isNotEmpty) {
      return Column(
        children: [
          Text(
            'Travel token',
            style: AppTypography.textLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(bytes, fit: BoxFit.contain, height: 240),
          ),
          if (document!.hasAnimationDetails && document!.animation != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  if (document!.animation!.keyVersion != null)
                    OmsaActionChip(
                      size: OmsaChipSize.small,
                      label: Text('Key ${document!.animation!.keyVersion}'),
                      onPressed: () {},
                    ),
                  if (document!.animation!.color != null)
                    OmsaActionChip(
                      size: OmsaChipSize.small,
                      label: Text('Color ${document!.animation!.color}'),
                      onPressed: () {},
                    ),
                  if (document!.animation!.speed != null)
                    OmsaActionChip(
                      size: OmsaChipSize.small,
                      label: Text(
                        'Speed ${document!.animation!.speed?.toString()}',
                      ),
                      onPressed: () {},
                    ),
                ],
              ),
            ),
        ],
      );
    }

    return _placeholder(context, fallbackTypeLabel);
  }

  Widget _placeholder(BuildContext context, String label) {
    return Column(
      children: [
        Icon(Icons.qr_code_2, size: 96, color: BaseLightTokens.shapeDisabled),
        const SizedBox(height: 12),
        Text('Ticket type: $label', textAlign: TextAlign.center),
      ],
    );
  }
}
