import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omsa_demo_app/theme/wayfare_tokens.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/models/travel_models.dart';
import 'package:omsa_demo_app/providers/offer_selection_provider.dart';
import 'package:omsa_demo_app/screens/purchase_flow_screen.dart';
import 'package:omsa_icons/omsa_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OffersScreen extends StatelessWidget {
  final OfferCollection offers;

  const OffersScreen({super.key, required this.offers});

  void _handleNext(BuildContext context) {
    final provider = Provider.of<OfferSelectionProvider>(
      context,
      listen: false,
    );
    final selectedOffer = provider.selectedOffer;
    if (selectedOffer != null) {
      provider.clearSelection();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PurchaseFlowScreen(offer: selectedOffer),
        ),
      );
    }
  }

  Widget _buildOfferDetails(BuildContext context, Offer offer) {
    final summary = offer.properties.summary;
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (summary.description.isNotEmpty) ...[
          const SizedBox(height: 12),
          MarkdownBody(
            data: summary.description.replaceAll('\\n', '\n'),
            styleSheet: MarkdownStyleSheet(
              p: AppTypography.textMedium.copyWith(
                color: BaseLightTokens.textSubdued,
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

  @override
  Widget build(BuildContext context) {
    final selectedOffer = context.watch<OfferSelectionProvider>().selectedOffer;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select ticket',
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
      body: offers.offers.isEmpty
          ? Center(
              child: Text(
                'No offers found',
                style: AppTypography.textLarge.copyWith(
                  color: BaseLightTokens.textSubdued,
                ),
              ),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ).copyWith(top: 16, bottom: selectedOffer != null ? 112 : 16),
                  child: OmsaRadioPanelGroup<Offer>(
                    value: selectedOffer,
                    expandOnSelected: true,
                    onChanged: (value) {
                      final provider = Provider.of<OfferSelectionProvider>(
                        context,
                        listen: false,
                      );
                      provider.selectOffer(
                        selectedOffer == value ? null : value,
                      );
                    },
                    options: offers.offers
                        .map(
                          (offer) => OmsaRadioPanelOption<Offer>(
                            value: offer,
                            title: Text(offer.properties.summary.name),
                            secondaryLabel: Text(
                              '${offer.properties.price.amount.toInt()} ${offer.properties.price.currencyCode}',
                              style: AppTypography.textLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            children: _buildOfferDetails(context, offer),
                          ),
                        )
                        .toList(),
                  ),
                ),
                if (selectedOffer != null)
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 24,
                    child: OmsaButton(
                      variant: OmsaButtonVariant.success,
                      onPressed: () => _handleNext(context),
                      width: OmsaButtonWidth.fluid,
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
