import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/models/travel_models.dart';
import 'package:omsa_demo_app/providers/offer_selection_provider.dart';
import 'package:omsa_demo_app/screens/purchase_flow_screen.dart';

class OffersScreen extends ConsumerWidget {
  final OfferCollection offers;

  const OffersScreen({super.key, required this.offers});

  void _handleNext(BuildContext context, WidgetRef ref) {
    final selectedOffer = ref.read(selectedOfferProvider);
    if (selectedOffer != null) {
      ref.read(selectedOfferProvider.notifier).state = null;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PurchaseFlowScreen(offer: selectedOffer),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOffer = ref.watch(selectedOfferProvider);

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
                    padding: const EdgeInsets.symmetric(horizontal: 16)
                        .copyWith(bottom: 80),
                    itemCount: offers.offers.length,
                    itemBuilder: (context, index) {
                      final offer = offers.offers[index];
                      return OfferCard(
                        offer: offer,
                        isSelected: selectedOffer == offer,
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: selectedOffer != null
          ? FloatingActionButton.extended(
              onPressed: () => _handleNext(context, ref),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next'),
            )
          : null,
    );
  }
}

class OfferCard extends ConsumerWidget {
  final Offer offer;
  final bool isSelected;

  const OfferCard({
    super.key,
    required this.offer,
    required this.isSelected,
  });

  void _handleTap(WidgetRef ref) {
    final currentSelection = ref.read(selectedOfferProvider);
    ref.read(selectedOfferProvider.notifier).state =
        currentSelection == offer ? null : offer;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final price = offer.properties.price;
    final summary = offer.properties.summary;
    final products = offer.properties.products;

    return GestureDetector(
      onTap: () => _handleTap(ref),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: AppDimensions.borderRadiusMedium,
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant,
            width: isSelected ? 2.0 : AppDimensions.borderWidthsSmall,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                    spreadRadius: 0,
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  ),
                  ...AppShadows.shadowsCardShadow,
                ]
              : AppShadows.shadowsCardShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  Row(
                    children: [
                      if (isSelected)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.check_circle,
                            color: theme.colorScheme.primary,
                            size: 24,
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '${price.amount.toInt()} ${price.currencyCode}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
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
                            color: theme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            product.productName,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

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
                      summary.isExchangeable
                          ? 'Exchangeable'
                          : 'Non-exchangeable',
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
            ],
          ),
        ),
      ),
    );
  }
}
