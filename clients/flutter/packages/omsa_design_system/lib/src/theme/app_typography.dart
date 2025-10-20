import 'package:flutter/material.dart';

/// Typography system for the OMSA Design System
class AppTypography {
  AppTypography._();

  // Font families - can be updated when design specs are ready
  static const String _fontFamily = 'Roboto';

  // Font Sizes
  /// 10px - Extra small font size
  static const double fontSizesExtraSmall = 10.0;

  /// 12px - Small font size
  static const double fontSizesSmall = 12.0;

  /// 14px - Medium font size
  static const double fontSizesMedium = 14.0;

  /// 16px - Large font size
  static const double fontSizesLarge = 16.0;

  /// 20px - Extra large font size
  static const double fontSizesExtraLarge = 20.0;

  /// 24px - Extra large font size (variant 2)
  static const double fontSizesExtraLarge2 = 24.0;

  /// 28px - Extra large font size (variant 3)
  static const double fontSizesExtraLarge3 = 28.0;

  /// 32px - Extra large font size (variant 4)
  static const double fontSizesExtraLarge4 = 32.0;

  /// 40px - Extra large font size (variant 5)
  static const double fontSizesExtraLarge5 = 40.0;

  // Line Heights
  /// 14px - Extra small line height
  static const double lineHeightsExtraSmall = 14.0;

  /// 16px - Small line height
  static const double lineHeightsSmall = 16.0;

  /// 20px - Medium line height
  static const double lineHeightsMedium = 20.0;

  /// 22px - Large line height
  static const double lineHeightsLarge = 22.0;

  /// 24px - Extra large line height
  static const double lineHeightsExtraLarge = 24.0;

  /// 28px - Extra large line height (variant 2)
  static const double lineHeightsExtraLarge2 = 28.0;

  /// 30px - Extra large line height (variant 3)
  static const double lineHeightsExtraLarge3 = 30.0;

  /// 36px - Extra large line height (variant 4)
  static const double lineHeightsExtraLarge4 = 36.0;

  /// 42px - Extra large line height (variant 5)
  static const double lineHeightsExtraLarge5 = 42.0;

  /// 48px - Extra large line height (variant 6)
  static const double lineHeightsExtraLarge6 = 48.0;

  /// 60px - Extra large line height (variant 7)
  static const double lineHeightsExtraLarge7 = 60.0;

  // Font Weights
  /// 500 - Body text weight
  static const FontWeight fontWeightsBody = FontWeight.w500;

  /// 600 - Heading text weight
  static const FontWeight fontWeightsHeading = FontWeight.w600;

  // Text Styles
  // Built using the design system's font sizes, line heights, and weights

  /// Extra Small Text - 10px / 14px line height
  static const TextStyle textExtraSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizesExtraSmall,
    height: lineHeightsExtraSmall / fontSizesExtraSmall,
    fontWeight: fontWeightsBody,
  );

  /// Small Text - 12px / 16px line height
  static const TextStyle textSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizesSmall,
    height: lineHeightsSmall / fontSizesSmall,
    fontWeight: fontWeightsBody,
  );

  /// Medium Text (Body) - 14px / 20px line height
  static const TextStyle textMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizesMedium,
    height: lineHeightsMedium / fontSizesMedium,
    fontWeight: fontWeightsBody,
  );

  /// Large Text - 16px / 22px line height
  static const TextStyle textLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizesLarge,
    height: lineHeightsLarge / fontSizesLarge,
    fontWeight: fontWeightsBody,
  );

  /// Extra Large Text - 20px / 24px line height
  static const TextStyle textExtraLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizesExtraLarge,
    height: lineHeightsExtraLarge / fontSizesExtraLarge,
    fontWeight: fontWeightsBody,
  );

  /// Heading Extra Large 2 - 24px / 28px line height
  static const TextStyle headingExtraLarge2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizesExtraLarge2,
    height: lineHeightsExtraLarge2 / fontSizesExtraLarge2,
    fontWeight: fontWeightsHeading,
  );

  /// Heading Extra Large 3 - 28px / 30px line height
  static const TextStyle headingExtraLarge3 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizesExtraLarge3,
    height: lineHeightsExtraLarge3 / fontSizesExtraLarge3,
    fontWeight: fontWeightsHeading,
  );

  /// Heading Extra Large 4 - 32px / 36px line height
  static const TextStyle headingExtraLarge4 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizesExtraLarge4,
    height: lineHeightsExtraLarge4 / fontSizesExtraLarge4,
    fontWeight: fontWeightsHeading,
  );

  /// Heading Extra Large 5 - 40px / 42px line height
  static const TextStyle headingExtraLarge5 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizesExtraLarge5,
    height: lineHeightsExtraLarge5 / fontSizesExtraLarge5,
    fontWeight: fontWeightsHeading,
  );

  // Material 3 compatible mappings for theme integration
  /// Maps to Material 3's displayLarge
  static const TextStyle displayLarge = headingExtraLarge5;

  /// Maps to Material 3's displayMedium
  static const TextStyle displayMedium = headingExtraLarge4;

  /// Maps to Material 3's displaySmall
  static const TextStyle displaySmall = headingExtraLarge3;

  /// Maps to Material 3's headlineLarge
  static const TextStyle headlineLarge = headingExtraLarge4;

  /// Maps to Material 3's headlineMedium
  static const TextStyle headlineMedium = headingExtraLarge3;

  /// Maps to Material 3's headlineSmall
  static const TextStyle headlineSmall = headingExtraLarge2;

  /// Maps to Material 3's titleLarge
  static const TextStyle titleLarge = textExtraLarge;

  /// Maps to Material 3's titleMedium
  static const TextStyle titleMedium = textLarge;

  /// Maps to Material 3's titleSmall
  static const TextStyle titleSmall = textMedium;

  /// Maps to Material 3's bodyLarge
  static const TextStyle bodyLarge = textLarge;

  /// Maps to Material 3's bodyMedium
  static const TextStyle bodyMedium = textMedium;

  /// Maps to Material 3's bodySmall
  static const TextStyle bodySmall = textSmall;

  /// Maps to Material 3's labelLarge
  static const TextStyle labelLarge = textMedium;

  /// Maps to Material 3's labelMedium
  static const TextStyle labelMedium = textSmall;

  /// Maps to Material 3's labelSmall
  static const TextStyle labelSmall = textExtraSmall;
}
