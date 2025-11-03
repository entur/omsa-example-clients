import 'package:omsa_design_system/theme/app_dimensions.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';

/// Dimension tokens for the segmented control component
class OmsaSegmentedControlDimensions {
  OmsaSegmentedControlDimensions._();

  static const double containerBorderRadius = AppDimensions.borderRadiusesLarge;
  static const double choiceBorderRadius = AppDimensions.borderRadiusesMedium;
  static const double choiceSpacing = AppSpacing.spaceExtraSmall2;
  static const double labelSpacing = AppSpacing.spaceExtraSmall2;

  static const double mediumHeight = AppSpacing.spaceLarge;
  static const double largeHeight = AppSpacing.spaceExtraLarge2;

  static const double mediumVerticalPadding = AppSpacing.spaceExtraSmall2 / 2;
  static const double largeVerticalPadding = AppSpacing.spaceExtraSmall;
  static const double horizontalPadding = AppSpacing.spaceSmall;

  static const Duration animationDuration = Duration(milliseconds: 150);
}
