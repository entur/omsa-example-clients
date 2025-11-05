import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/theme/app_typography.dart';

/// Dimensions for the OmsaTag component
class OmsaTagDimensions {
  const OmsaTagDimensions({
    required this.minWidth,
    required this.height,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.iconSpacing,
    required this.textStyle,
  });

  final double minWidth;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double iconSpacing;
  final TextStyle textStyle;

  static const OmsaTagDimensions standard = OmsaTagDimensions(
    minWidth: AppSpacing.spaceExtraLarge,
    height: AppSpacing.spaceLarge,
    horizontalPadding: AppSpacing.spaceSmall,
    verticalPadding: AppSpacing.spaceExtraSmall2,
    iconSpacing: AppSpacing.spaceExtraSmall,
    textStyle: AppTypography.textMedium,
  );

  static const OmsaTagDimensions compact = OmsaTagDimensions(
    minWidth: AppSpacing.spaceExtraLarge,
    height: 24.0,
    horizontalPadding: AppSpacing.spaceExtraSmall,
    verticalPadding: AppSpacing.spaceExtraSmall2 / 2,
    iconSpacing: AppSpacing.spaceExtraSmall2,
    textStyle: AppTypography.textSmall,
  );
}
