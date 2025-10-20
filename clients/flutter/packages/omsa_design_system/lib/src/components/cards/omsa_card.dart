import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';

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
    final defaultPadding = const EdgeInsets.all(AppSpacing.spacing16);
    final defaultMargin = const EdgeInsets.symmetric(
      horizontal: AppSpacing.spacing16,
      vertical: AppSpacing.spacing8,
    );

    Widget card;

    switch (variant) {
      case OmsaCardVariant.elevated:
        card = Card(
          margin: margin ?? defaultMargin,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: padding ?? defaultPadding,
              child: child,
            ),
          ),
        );
        break;

      case OmsaCardVariant.filled:
        card = Card(
          margin: margin ?? defaultMargin,
          color: theme.colorScheme.surfaceContainerHighest,
          elevation: 0,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: padding ?? defaultPadding,
              child: child,
            ),
          ),
        );
        break;

      case OmsaCardVariant.outlined:
        card = Card(
          margin: margin ?? defaultMargin,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: theme.colorScheme.outline,
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: padding ?? defaultPadding,
              child: child,
            ),
          ),
        );
        break;
    }

    return card;
  }
}
