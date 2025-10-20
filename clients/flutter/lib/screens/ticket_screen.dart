import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:omsa_design_system/omsa_design_system.dart';

import 'package:omsa_demo_app/models/purchase_models.dart';

class TicketScreen extends StatelessWidget {
  final List<TravelDocument> documents;
  final TravelDocument? primaryTicket;

  const TicketScreen({
    super.key,
    required this.documents,
    required this.primaryTicket,
  });

  @override
  Widget build(BuildContext context) {
    final displayTicket =
        primaryTicket ?? (documents.isNotEmpty ? documents.first : null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Travel Ticket'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: documents.isEmpty
            ? const Center(child: Text('No travel documents available'))
            : Column(
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
                                ),
                              if (displayTicket?.endValidity != null)
                                _buildValidityChip(
                                  'Valid until',
                                  displayTicket!.endValidity!,
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: OmsaCard(
                      variant: OmsaCardVariant.elevated,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Travel documents',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: ListView.separated(
                              itemCount: documents.length,
                              separatorBuilder: (context, _) => const Divider(),
                              itemBuilder: (context, index) {
                                final doc = documents[index];
                                return ListTile(
                                  leading: Icon(
                                    doc.isQrCode
                                        ? Icons.qr_code
                                        : doc.hasAnimationDetails
                                        ? Icons.movie
                                        : Icons.description,
                                  ),
                                  title: Text(doc.travelDocumentType),
                                  subtitle: Text(
                                    'Content: ${doc.contentType}',
                                    maxLines: 2,
                                  ),
                                  trailing: doc == displayTicket
                                      ? const OmsaChip(
                                          label: Text('Primary'),
                                          variant: OmsaChipVariant.filled,
                                          color: OmsaChipColor.primary,
                                        )
                                      : null,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TicketScreen(
                                          documents: documents,
                                          primaryTicket: doc,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildValidityChip(String label, DateTime value) {
    return OmsaChip(
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(
            value.toLocal().toString().substring(0, 16),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      variant: OmsaChipVariant.filled,
      color: OmsaChipColor.info,
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
    if (document == null) {
      return _placeholder(fallbackTypeLabel);
    }

    if (document!.isQrCode && document!.qrPayloadString != null) {
      return Column(
        children: [
          const Text(
            'Scan to travel',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: QrImageView(
              data: document!.qrPayloadString!,
              version: QrVersions.auto,
              size: 220,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      );
    }

    final bytes = document!.displayableImageBytes;
    if (bytes != null && bytes.isNotEmpty) {
      return Column(
        children: [
          const Text(
            'Travel token',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    OmsaChip(
                      label: Text('Key ${document!.animation!.keyVersion}'),
                      variant: OmsaChipVariant.outlined,
                      color: OmsaChipColor.neutral,
                    ),
                  if (document!.animation!.color != null)
                    OmsaChip(
                      label: Text('Color ${document!.animation!.color}'),
                      variant: OmsaChipVariant.outlined,
                      color: OmsaChipColor.neutral,
                    ),
                  if (document!.animation!.speed != null)
                    OmsaChip(
                      label: Text(
                        'Speed ${document!.animation!.speed?.toString()}',
                      ),
                      variant: OmsaChipVariant.outlined,
                      color: OmsaChipColor.neutral,
                    ),
                ],
              ),
            ),
        ],
      );
    }

    return _placeholder(fallbackTypeLabel);
  }

  Widget _placeholder(String label) {
    return Column(
      children: [
        const Icon(Icons.qr_code_2, size: 96, color: Colors.grey),
        const SizedBox(height: 12),
        Text('Ticket type: $label', textAlign: TextAlign.center),
      ],
    );
  }
}
