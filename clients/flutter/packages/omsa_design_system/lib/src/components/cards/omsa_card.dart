import 'package:flutter/material.dart';
import 'package:omsa_design_system/src/theme/app_spacing.dart';
import 'package:omsa_design_system/src/theme/app_dimensions.dart';
import 'package:omsa_design_system/src/theme/app_decorations.dart';

/// Card variant types for the OMSA Design System
enum OmsaCardVariant {
  elevated,
  filled,
  outlined,
}

/// A customizable card component following OMSA Design System guidelines
class OmsaCard extends StatelessWidget {
  const OmsaCard({
    super.key,
    required this.child,
    this.variant = OmsaCardVariant.elevated,
    this.onTap,
    this.padding,
    this.margin,
  });

  final Widget child;
  final OmsaCardVariant variant;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const defaultPadding = EdgeInsets.all(AppSpacing.spaceMedium);
    const defaultMargin = EdgeInsets.symmetric(
      horizontal: AppSpacing.spaceMedium,
      vertical: AppSpacing.spaceExtraSmall,
    );

    Widget card;

    switch (variant) {
      case OmsaCardVariant.elevated:
        card = Container(
          margin: margin ?? defaultMargin,
          decoration: AppDecorations.card(),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: AppDimensions.borderRadiusMedium,
              child: Padding(
                padding: padding ?? defaultPadding,
                child: child,
              ),
            ),
          ),
        );
        break;

      case OmsaCardVariant.filled:
        card = Container(
          margin: margin ?? defaultMargin,
          decoration: AppDecorations.roundedMedium(
            color: theme.colorScheme.surfaceContainerHighest,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: AppDimensions.borderRadiusMedium,
              child: Padding(
                padding: padding ?? defaultPadding,
                child: child,
              ),
            ),
          ),
        );
        break;

      case OmsaCardVariant.outlined:
        card = Container(
          margin: margin ?? defaultMargin,
          decoration: AppDecorations.outlined(
            borderColor: theme.colorScheme.outline,
            borderWidth: AppDimensions.borderWidthsSmall,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: AppDimensions.borderRadiusLarge,
              child: Padding(
                padding: padding ?? defaultPadding,
                child: child,
              ),
            ),
          ),
        );
        break;
    }

    return card;
  }
}
