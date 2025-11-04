import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';

/// Base class for component showcases with automatic state management
abstract class ComponentShowcase extends StatefulWidget {
  const ComponentShowcase({super.key});

  String get title;
  String get description => '';
  IconData? get icon => null;
}

/// Helper widget to display a component example with label
class ComponentExample extends StatelessWidget {
  final String label;
  final Widget child;
  final OmsaComponentMode mode;
  final EdgeInsets? padding;

  const ComponentExample({
    super.key,
    required this.label,
    required this.child,
    this.mode = OmsaComponentMode.standard,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final backgroundColor = mode == OmsaComponentMode.contrast
        ? (brightness == Brightness.light
              ? BaseLightTokens.frameContrast
              : BaseDarkTokens.frameContrast)
        : (brightness == Brightness.light
              ? BaseLightTokens.frameElevated
              : BaseDarkTokens.frameDefault);

    final textColor = mode == OmsaComponentMode.contrast
        ? Colors.white
        : (brightness == Brightness.light
              ? BaseLightTokens.textAccent
              : BaseDarkTokens.textAccent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.textMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: brightness == Brightness.light
                  ? Colors.grey.shade300
                  : Colors.grey.shade700,
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}

/// Helper widget to display variants in a grid or row
class VariantShowcase extends StatelessWidget {
  final List<Widget> children;
  final Axis direction;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const VariantShowcase({
    super.key,
    required this.children,
    this.direction = Axis.horizontal,
    this.spacing = 16,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: children,
      );
    } else {
      return Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children:
            children
                .expand((child) => [child, SizedBox(height: spacing)])
                .toList()
              ..removeLast(),
      );
    }
  }
}
