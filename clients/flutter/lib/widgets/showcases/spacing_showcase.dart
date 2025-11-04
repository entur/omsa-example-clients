import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/widgets/component_showcase.dart';

class SpacingShowcase extends ComponentShowcase {
  const SpacingShowcase({super.key});

  @override
  String get title => 'Spacing';

  @override
  State<SpacingShowcase> createState() => _SpacingShowcaseState();
}

class _SpacingShowcaseState extends State<SpacingShowcase> {
  Widget _buildSpacingExample(String label, double spacing) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(label, style: AppTypography.textMedium),
          ),
          Container(
            width: spacing == 0 ? 1 : spacing,
            height: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

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
          label: 'Spacing Scale',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSpacingExample('None (0px)', AppSpacing.spaceNone),
              _buildSpacingExample(
                'Extra Small 2 (4px)',
                AppSpacing.spaceExtraSmall2,
              ),
              _buildSpacingExample(
                'Extra Small (8px)',
                AppSpacing.spaceExtraSmall,
              ),
              _buildSpacingExample('Small (12px)', AppSpacing.spaceSmall),
              _buildSpacingExample('Medium (16px)', AppSpacing.spaceMedium),
              _buildSpacingExample('Large (24px)', AppSpacing.spaceLarge),
              _buildSpacingExample(
                'Extra Large (32px)',
                AppSpacing.spaceExtraLarge,
              ),
              _buildSpacingExample(
                'Extra Large 2 (40px)',
                AppSpacing.spaceExtraLarge2,
              ),
              _buildSpacingExample(
                'Extra Large 3 (48px)',
                AppSpacing.spaceExtraLarge3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
