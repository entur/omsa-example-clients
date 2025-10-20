import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/models/travel_models.dart';
import 'package:omsa_demo_app/screens/purchase_flow_screen.dart';

class OffersScreen extends StatelessWidget {
  final OfferCollection offers;

  const OffersScreen({super.key, required this.offers});

  void _handleSelect(BuildContext context, Offer offer) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PurchaseFlowScreen(offer: offer)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Offers'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: offers.offers.isEmpty
          ? const Center(
              child: Text(
                'No offers found',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.confirmation_number,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${offers.numberReturned} offers found',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: offers.offers.length,
                    itemBuilder: (context, index) {
                      final offer = offers.offers[index];
                      return OfferCard(
                        offer: offer,
                        onSelect: () => _handleSelect(context, offer),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final Offer offer;
  final VoidCallback onSelect;

  const OfferCard({super.key, required this.offer, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final price = offer.properties.price;
    final summary = offer.properties.summary;
    final products = offer.properties.products;

    return OmsaCard(
      variant: OmsaCardVariant.elevated,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with name and price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  summary.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${price.amount.toInt()} ${price.currencyCode}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),

          if (summary.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              summary.description.replaceAll('\\n', '\n'),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.3,
              ),
            ),
          ],

          // Product information
          if (products.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Product Details:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 4),
            ...products.map(
              (product) => Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        product.productName,
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Offer features
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OmsaChip(
                label: Text(
                  summary.isRefundable ? 'Refundable' : 'Non-refundable',
                ),
                variant: OmsaChipVariant.filled,
                color: summary.isRefundable
                    ? OmsaChipColor.success
                    : OmsaChipColor.warning,
                icon: Icon(
                  summary.isRefundable ? Icons.check_circle : Icons.cancel,
                  size: 14,
                ),
              ),
              OmsaChip(
                label: Text(
                  summary.isExchangeable ? 'Exchangeable' : 'Non-exchangeable',
                ),
                variant: OmsaChipVariant.filled,
                color: summary.isExchangeable
                    ? OmsaChipColor.success
                    : OmsaChipColor.warning,
                icon: Icon(
                  summary.isExchangeable ? Icons.swap_horiz : Icons.block,
                  size: 14,
                ),
              ),
            ],
          ),

          // Select button
          const SizedBox(height: 16),
          OmsaButton(
            onPressed: onSelect,
            isFullWidth: true,
            child: const Text('Select This Offer'),
          ),
        ],
      ),
    );
  }
}
