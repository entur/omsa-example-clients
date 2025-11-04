import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/widgets/component_showcase.dart';

class ColorShowcase extends ComponentShowcase {
  const ColorShowcase({super.key});

  @override
  String get title => 'Colors';

  @override
  State<ColorShowcase> createState() => _ColorShowcaseState();
}

class _ColorShowcaseState extends State<ColorShowcase> {
  Widget _buildColorSwatch(String name, Color color) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            name,
            style: AppTypography.textSmall,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

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
          label: brightness == Brightness.light
              ? 'Base - Frame Colors (Light)'
              : 'Base - Frame Colors (Dark)',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: brightness == Brightness.light
                ? [
                    _buildColorSwatch('Default', BaseLightTokens.frameDefault),
                    _buildColorSwatch(
                      'Elevated',
                      BaseLightTokens.frameElevated,
                    ),
                    _buildColorSwatch(
                      'Contrast',
                      BaseLightTokens.frameContrast,
                    ),
                    _buildColorSwatch('Tint', BaseLightTokens.frameTint),
                    _buildColorSwatch('Subdued', BaseLightTokens.frameSubdued),
                  ]
                : [
                    _buildColorSwatch('Default', BaseDarkTokens.frameDefault),
                    _buildColorSwatch('Elevated', BaseDarkTokens.frameElevated),
                    _buildColorSwatch('Contrast', BaseDarkTokens.frameContrast),
                    _buildColorSwatch('Tint', BaseDarkTokens.frameTint),
                    _buildColorSwatch('Subdued', BaseDarkTokens.frameSubdued),
                  ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: brightness == Brightness.light
              ? 'Base - Text Colors (Light)'
              : 'Base - Text Colors (Dark)',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: brightness == Brightness.light
                ? [
                    _buildColorSwatch('Accent', BaseLightTokens.textAccent),
                    _buildColorSwatch('Light', BaseLightTokens.textLight),
                    _buildColorSwatch('Subdued', BaseLightTokens.textSubdued),
                    _buildColorSwatch('Disabled', BaseLightTokens.textDisabled),
                    _buildColorSwatch(
                      'Highlight',
                      BaseLightTokens.textHighlight,
                    ),
                  ]
                : [
                    _buildColorSwatch('Accent', BaseDarkTokens.textAccent),
                    _buildColorSwatch('Light', BaseDarkTokens.textLight),
                    _buildColorSwatch('Subdued', BaseDarkTokens.textSubdued),
                    _buildColorSwatch('Disabled', BaseDarkTokens.textDisabled),
                    _buildColorSwatch(
                      'Highlight',
                      BaseDarkTokens.textHighlight,
                    ),
                  ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: brightness == Brightness.light
              ? 'Base - Stroke Colors (Light)'
              : 'Base - Stroke Colors (Dark)',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: brightness == Brightness.light
                ? [
                    _buildColorSwatch('Default', BaseLightTokens.strokeDefault),
                    _buildColorSwatch(
                      'Contrast',
                      BaseLightTokens.strokeContrast,
                    ),
                    _buildColorSwatch('Light', BaseLightTokens.strokeLight),
                    _buildColorSwatch('Subdued', BaseLightTokens.strokeSubdued),
                    _buildColorSwatch(
                      'Highlight',
                      BaseLightTokens.strokeHighlight,
                    ),
                    _buildColorSwatch(
                      'Disabled',
                      BaseLightTokens.strokeDisabled,
                    ),
                  ]
                : [
                    _buildColorSwatch('Default', BaseDarkTokens.strokeDefault),
                    _buildColorSwatch(
                      'Contrast',
                      BaseDarkTokens.strokeContrast,
                    ),
                    _buildColorSwatch('Light', BaseDarkTokens.strokeLight),
                    _buildColorSwatch('Subdued', BaseDarkTokens.strokeSubdued),
                    _buildColorSwatch(
                      'Highlight',
                      BaseDarkTokens.strokeHighlight,
                    ),
                    _buildColorSwatch(
                      'Disabled',
                      BaseDarkTokens.strokeDisabled,
                    ),
                  ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Semantic - Status Colors',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildColorSwatch(
                'Success',
                SemanticColorTokens.fillSuccessContrast,
              ),
              _buildColorSwatch(
                'Success Deep',
                SemanticColorTokens.fillSuccessDeep,
              ),
              _buildColorSwatch(
                'Warning',
                SemanticColorTokens.fillWarningContrast,
              ),
              _buildColorSwatch(
                'Warning Deep',
                SemanticColorTokens.fillWarningDeep,
              ),
              _buildColorSwatch(
                'Negative',
                SemanticColorTokens.fillNegativeContrast,
              ),
              _buildColorSwatch(
                'Negative Deep',
                SemanticColorTokens.fillNegativeDeep,
              ),
              _buildColorSwatch(
                'Information',
                SemanticColorTokens.fillInformationContrast,
              ),
              _buildColorSwatch(
                'Info Deep',
                SemanticColorTokens.fillInformationDeep,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Transport - Mode Colors',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildColorSwatch('Bus', TransportColorTokens.standardBus),
              _buildColorSwatch('Train', TransportColorTokens.standardTrain),
              _buildColorSwatch('Metro', TransportColorTokens.standardMetro),
              _buildColorSwatch('Tram', TransportColorTokens.standardTram),
              _buildColorSwatch('Ferry', TransportColorTokens.standardFerry),
              _buildColorSwatch(
                'Bicycle',
                TransportColorTokens.standardBicycle,
              ),
              _buildColorSwatch('Walk', TransportColorTokens.standardWalk),
              _buildColorSwatch('Plane', TransportColorTokens.standardPlane),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Data Visualization Colors',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildColorSwatch('Azure', DataColorTokens.standardAzure),
              _buildColorSwatch('Blue', DataColorTokens.standardBlue),
              _buildColorSwatch('Coral', DataColorTokens.standardCoral),
              _buildColorSwatch('Jungle', DataColorTokens.standardJungle),
              _buildColorSwatch('Lavender', DataColorTokens.standardLavender),
              _buildColorSwatch('Lilac', DataColorTokens.standardLilac),
              _buildColorSwatch('Peach', DataColorTokens.standardPeach),
              _buildColorSwatch('Spring', DataColorTokens.standardSpring),
            ],
          ),
        ),
      ],
    );
  }
}
