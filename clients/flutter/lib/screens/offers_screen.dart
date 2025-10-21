import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/models/travel_models.dart';
import 'package:omsa_demo_app/providers/offer_selection_provider.dart';
import 'package:omsa_demo_app/screens/purchase_flow_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: Text(
          'Select ticket',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: false,
      ),
      body: offers.offers.isEmpty
          ? Center(
              child: Text(
                'No offers found',
                style: AppTypography.textLarge.copyWith(
                  color: context.semanticColors.textSubdued,
                ),
              ),
            )
          : Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(top: 16, bottom: selectedOffer != null ? 112 : 16),
                  itemCount: offers.offers.length,
                  itemBuilder: (context, index) {
                    final offer = offers.offers[index];
                    return OfferCard(
                      offer: offer,
                      isSelected: selectedOffer == offer,
                    );
                  },
                ),
                if (selectedOffer != null)
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 24,
                    child: OmsaButton(
                      onPressed: () => _handleNext(context, ref),
                      isFullWidth: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${selectedOffer.properties.price.amount.toInt()} ${selectedOffer.properties.price.currencyCode}',
                            style: AppTypography.textLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Next',
                                style: AppTypography.textLarge.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
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
    final semanticColors = context.semanticColors;
    final price = offer.properties.price;
    final summary = offer.properties.summary;

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
            width: 2.0,
          ),
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
                      style: AppTypography.textLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      Text(
                        '${price.amount.toInt()} ${price.currencyCode}',
                        style: AppTypography.textLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outline,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Center(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ],
              ),

              ClipRect(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  heightFactor: isSelected ? 1.0 : 0.0,
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (summary.description.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        MarkdownBody(
                          data: summary.description.replaceAll('\\n', '\n'),
                          styleSheet: MarkdownStyleSheet(
                            p: AppTypography.textMedium.copyWith(
                              color: semanticColors.textSubdued,
                              height: 1.3,
                            ),
                            a: AppTypography.textMedium.copyWith(
                              color: theme.colorScheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTapLink: (text, href, title) {
                            if (href != null) {
                              launchUrl(Uri.parse(href));
                            }
                          },
                        ),
                      ],
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          OmsaChip(
                            label: Text(
                              summary.isRefundable ? 'Refundable' : 'Non-refundable',
                              style: AppTypography.textSmall,
                            ),
                            variant: OmsaChipVariant.filled,
                            color: summary.isRefundable
                                ? OmsaChipColor.success
                                : OmsaChipColor.warning,
                            icon: Icon(
                              summary.isRefundable ? Icons.check_circle : Icons.cancel,
                              size: 12,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                          ),
                          OmsaChip(
                            label: Text(
                              summary.isExchangeable
                                  ? 'Exchangeable'
                                  : 'Non-exchangeable',
                              style: AppTypography.textSmall,
                            ),
                            variant: OmsaChipVariant.filled,
                            color: summary.isExchangeable
                                ? OmsaChipColor.success
                                : OmsaChipColor.warning,
                            icon: Icon(
                              summary.isExchangeable ? Icons.swap_horiz : Icons.block,
                              size: 12,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
