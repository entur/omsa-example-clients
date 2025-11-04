import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/widgets/component_showcase.dart';

class TypographyShowcase extends ComponentShowcase {
  const TypographyShowcase({super.key});

  @override
  String get title => 'Typography';

  @override
  State<TypographyShowcase> createState() => _TypographyShowcaseState();
}

class _TypographyShowcaseState extends State<TypographyShowcase> {
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
          label: 'Text Styles',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Display Large', style: AppTypography.displayLarge),
              const SizedBox(height: 8),
              Text('Display Medium', style: AppTypography.displayMedium),
              const SizedBox(height: 8),
              Text('Display Small', style: AppTypography.displaySmall),
              const SizedBox(height: 16),
              Text('Headline Large', style: AppTypography.headlineLarge),
              const SizedBox(height: 8),
              Text('Headline Medium', style: AppTypography.headlineMedium),
              const SizedBox(height: 8),
              Text('Headline Small', style: AppTypography.headlineSmall),
              const SizedBox(height: 16),
              Text('Text Large', style: AppTypography.textLarge),
              const SizedBox(height: 8),
              Text('Text Medium', style: AppTypography.textMedium),
              const SizedBox(height: 8),
              Text('Text Small', style: AppTypography.textSmall),
            ],
          ),
        ),
      ],
    );
  }
}
