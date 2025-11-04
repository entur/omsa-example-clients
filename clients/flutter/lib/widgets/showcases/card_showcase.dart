import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/widgets/component_showcase.dart';

class CardShowcase extends ComponentShowcase {
  const CardShowcase({super.key});

  @override
  String get title => 'Cards';

  @override
  State<CardShowcase> createState() => _CardShowcaseState();
}

class _CardShowcaseState extends State<CardShowcase> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTypography.displaySmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Basic Cards',
          child: VariantShowcase(
            direction: Axis.vertical,
            children: [
              OmsaCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Card Title', style: AppTypography.headlineMedium),
                      const SizedBox(height: 8),
                      Text(
                        'This is a basic card with some content inside.',
                        style: AppTypography.textMedium,
                      ),
                    ],
                  ),
                ),
              ),
              OmsaCard(
                variant: OmsaCardVariant.elevated,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Elevated Card',
                        style: AppTypography.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This card has elevation for more visual hierarchy.',
                        style: AppTypography.textMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Interactive Cards',
          child: VariantShowcase(
            direction: Axis.vertical,
            children: [
              OmsaCard(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.star, size: 32),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Clickable Card',
                              style: AppTypography.headlineMedium,
                            ),
                            const SizedBox(height: 4),
                            Text('Tap me!', style: AppTypography.textMedium),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
