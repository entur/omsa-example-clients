import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/layout/badge/omsa_badge_enums.dart';
import 'package:omsa_design_system/theme/app_dimensions.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/theme/app_typography.dart';

class OmsaBadgeDimensions {
  const OmsaBadgeDimensions({
    required this.minWidth,
    required this.height,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.borderRadius,
    required this.borderWidth,
    required this.textStyle,
  });

  final double minWidth;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final double borderWidth;
  final TextStyle textStyle;

  static OmsaBadgeDimensions forType(OmsaBadgeType type) {
    switch (type) {
      case OmsaBadgeType.status:
        return const OmsaBadgeDimensions(
          minWidth: 24.0,
          height: 20.0,
          horizontalPadding: AppSpacing.spaceExtraSmall,
          verticalPadding: 0,
          borderRadius: AppDimensions.borderRadiusesMedium,
          borderWidth: AppDimensions.borderWidthsSmall,
          textStyle: AppTypography.textSmall,
        );
      case OmsaBadgeType.notification:
        return const OmsaBadgeDimensions(
          minWidth: AppSpacing.spaceLarge,
          height: AppSpacing.spaceLarge,
          horizontalPadding: AppSpacing.spaceExtraSmall2,
          verticalPadding: 0,
          borderRadius: 12.0,
          borderWidth: AppDimensions.borderWidthsSmall,
          textStyle: AppTypography.textSmall,
        );
      case OmsaBadgeType.bullet:
        return const OmsaBadgeDimensions(
          minWidth: 24.0,
          height: 24.0,
          horizontalPadding: AppSpacing.spaceSmall + 10.0,
          verticalPadding: 0,
          borderRadius: 0,
          borderWidth: 0,
          textStyle: AppTypography.textLarge,
        );
    }
  }

  static const double bulletSize = 10.0;

  static const double bulletLeftPadding = bulletSize + AppSpacing.spaceSmall;
}
