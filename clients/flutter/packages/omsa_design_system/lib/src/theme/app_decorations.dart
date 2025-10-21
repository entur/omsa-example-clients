import 'package:flutter/material.dart';
import 'package:omsa_design_system/src/theme/app_dimensions.dart';
import 'package:omsa_design_system/src/theme/app_shadows.dart';

/// Pre-configured BoxDecoration helpers for common UI patterns
/// Combines border radii, shadows, and other styling from the design system
class AppDecorations {
  AppDecorations._();

  /// Card decoration with standard elevation shadow and medium border radius
  static BoxDecoration card({Color? color}) => BoxDecoration(
    color: color,
    borderRadius: AppDimensions.borderRadiusMedium,
    boxShadow: AppShadows.shadowsCardShadow,
  );

  /// Card decoration with hover state (elevated shadow)
  static BoxDecoration cardHover({Color? color}) => BoxDecoration(
    color: color,
    borderRadius: AppDimensions.borderRadiusMedium,
    boxShadow: AppShadows.shadowsCardShadowHover,
  );

  /// Card decoration with contrast shadow (uses primary color)
  static BoxDecoration cardContrast({Color? color}) => BoxDecoration(
    color: color,
    borderRadius: AppDimensions.borderRadiusMedium,
    boxShadow: AppShadows.shadowsCardShadowContrast,
  );

  /// Card decoration with contrast hover shadow
  static BoxDecoration cardContrastHover({Color? color}) => BoxDecoration(
    color: color,
    borderRadius: AppDimensions.borderRadiusMedium,
    boxShadow: AppShadows.shadowsCardShadowHoverContrast,
  );

  /// Box with standard drop shadow and large border radius
  static BoxDecoration box({Color? color}) => BoxDecoration(
    color: color,
    borderRadius: AppDimensions.borderRadiusLarge,
    boxShadow: AppShadows.shadowsBoxShadow,
  );

  /// Box with contrast shadow
  static BoxDecoration boxContrast({Color? color}) => BoxDecoration(
    color: color,
    borderRadius: AppDimensions.borderRadiusLarge,
    boxShadow: AppShadows.shadowsBoxShadowContrast,
  );

  /// Outlined container with border and large radius
  static BoxDecoration outlined({
    required Color borderColor,
    Color? backgroundColor,
    double? borderWidth,
  }) => BoxDecoration(
    color: backgroundColor,
    borderRadius: AppDimensions.borderRadiusLarge,
    border: Border.all(
      color: borderColor,
      width: borderWidth ?? AppDimensions.borderWidthsDefault,
    ),
  );

  /// Rounded container with large radius (no border, no shadow)
  static BoxDecoration rounded({Color? color}) => BoxDecoration(
    color: color,
    borderRadius: AppDimensions.borderRadiusLarge,
  );

  /// Rounded container with medium radius
  static BoxDecoration roundedMedium({Color? color}) => BoxDecoration(
    color: color,
    borderRadius: AppDimensions.borderRadiusMedium,
  );

  /// Container with focus indicator (ring shadow)
  static BoxDecoration focused({Color? color}) => BoxDecoration(
    color: color,
    borderRadius: AppDimensions.borderRadiusLarge,
    boxShadow: AppShadows.shadowsFocus,
  );

  /// Container with contrast focus indicator
  static BoxDecoration focusedContrast({Color? color}) => BoxDecoration(
    color: color,
    borderRadius: AppDimensions.borderRadiusLarge,
    boxShadow: AppShadows.shadowsFocusContrast,
  );

  /// Rounded top corners only (useful for modal/sheet tops)
  static BoxDecoration roundedTop({Color? color}) => BoxDecoration(
    color: color,
    borderRadius: AppDimensions.borderRadiusLargeTop,
  );

  /// Rounded bottom corners only (useful for modal/sheet bottoms)
  static BoxDecoration roundedBottom({Color? color}) => BoxDecoration(
    color: color,
    borderRadius: AppDimensions.borderRadiusLargeBottom,
  );
}
