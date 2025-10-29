import 'package:flutter/material.dart';

/// Button component colors for the OMSA Design System
/// Derived from the EDS button CSS styles
class AppButtonColors extends ThemeExtension<AppButtonColors> {
  const AppButtonColors({
    // Primary variant
    required this.primaryBackground,
    required this.primaryText,
    required this.primaryBackgroundHover,
    required this.primaryBackgroundActive,
    // Secondary variant
    required this.secondaryBackground,
    required this.secondaryText,
    required this.secondaryTextActive,
    required this.secondaryBackgroundHover,
    required this.secondaryBackgroundActive,
    required this.secondaryBorder,
    required this.secondaryBorderActive,
    // Success variant
    required this.successBackground,
    required this.successText,
    required this.successBackgroundHover,
    required this.successBackgroundActive,
    required this.successBorder,
    // Negative variant
    required this.negativeBackground,
    required this.negativeText,
    required this.negativeTextActive,
    required this.negativeBackgroundHover,
    required this.negativeBackgroundActive,
    required this.negativeBorder,
    // Disabled state
    required this.disabledFill,
    required this.disabledText,
    // Focus
    required this.focusOutline,
  });

  // Primary variant
  final Color primaryBackground;
  final Color primaryText;
  final Color primaryBackgroundHover;
  final Color primaryBackgroundActive;

  // Secondary variant
  final Color secondaryBackground;
  final Color secondaryText;
  final Color secondaryTextActive;
  final Color secondaryBackgroundHover;
  final Color secondaryBackgroundActive;
  final Color secondaryBorder;
  final Color secondaryBorderActive;

  // Success variant
  final Color successBackground;
  final Color successText;
  final Color successBackgroundHover;
  final Color successBackgroundActive;
  final Color successBorder;

  // Negative variant
  final Color negativeBackground;
  final Color negativeText;
  final Color negativeTextActive;
  final Color negativeBackgroundHover;
  final Color negativeBackgroundActive;
  final Color negativeBorder;

  // Disabled state
  final Color disabledFill;
  final Color disabledText;

  // Focus
  final Color focusOutline;

  /// Standard (light mode) button colors
  static const AppButtonColors standard = AppButtonColors(
    // Primary
    primaryBackground: Color(0xFF181C56), // --components-button-primary-standard-default: #181c56
    primaryText: Color(0xFFFFFFFF), // --components-button-primary-standard-text: #fff
    primaryBackgroundHover: Color(0xFF393D79), // --components-button-primary-standard-hover: #393d79
    primaryBackgroundActive: Color(0xFF11143C), // --components-button-primary-standard-active: #11143c
    // Secondary - transparent background with border
    secondaryBackground: Color(0x00FFFFFF), // --components-button-secondary-standard-default: hsla(0,0%,100%,0) = transparent
    secondaryText: Color(0xFF181C56), // --components-button-secondary-standard-text: #181c56
    secondaryTextActive: Color(0xFF181C56), // --components-button-secondary-standard-text-active: #181c56
    secondaryBackgroundHover: Color(0xFFD9DDF2), // --components-button-secondary-standard-hover: #d9ddf2
    secondaryBackgroundActive: Color(0xFFAEB7E2), // --components-button-secondary-standard-active: #aeb7e2
    secondaryBorder: Color(0xFF8284AB), // --components-button-secondary-standard-border: #8284ab
    secondaryBorderActive: Color(0xFF181C56), // --components-button-secondary-standard-border-active: #181c56
    // Success
    successBackground: Color(0xFF5AC39A), // --components-button-success-standard-default: #5ac39a
    successText: Color(0xFF181C56), // --components-button-success-standard-text: #181c56
    successBackgroundHover: Color(0xFF9CD9C2), // --components-button-success-standard-hover: #9cd9c2
    successBackgroundActive: Color(0xFF37AB83), // --components-button-success-standard-active: #37ab83
    successBorder: Color(0x00000000), // --components-button-success-standard-border: hsla(0,0%,100%,0) = transparent
    // Negative - transparent background with border
    negativeBackground: Color(0x00FFFFFF), // --components-button-negative-standard-default: hsla(0,0%,100%,0) = transparent
    negativeText: Color(0xFFD31B1B), // --components-button-negative-standard-text: #d31b1b
    negativeTextActive: Color(0xFF08091C), // --components-button-negative-standard-text-active: #08091c
    negativeBackgroundHover: Color(0xFFFFCECE), // --components-button-negative-standard-hover: #ffcece
    negativeBackgroundActive: Color(0xFFD31B1B), // --components-button-negative-standard-active: #d31b1b
    negativeBorder: Color(0xFFD31B1B), // --components-button-negative-standard-border: #d31b1b
    // Disabled
    disabledFill: Color(0xFFD9DAE8), // --components-button-disabled-standard-fill
    disabledText: Color(0xFF6E6F73), // --components-button-disabled-standard-text-disabled
    // Focus
    focusOutline: Color(0xFF181C56), // --basecolors-stroke-focus-standard
  );

  /// Contrast (dark mode) button colors
  static const AppButtonColors contrast = AppButtonColors(
    // Primary
    primaryBackground: Color(0xFFAEB7E2), // --components-button-primary-contrast-default: #aeb7e2
    primaryText: Color(0xFF181C56), // --components-button-primary-contrast-text: #181c56
    primaryBackgroundHover: Color(0xFFC7CDEB), // --components-button-primary-contrast-hover: #c7cdeb
    primaryBackgroundActive: Color(0xFF8794D4), // --components-button-primary-contrast-active: #8794d4
    // Secondary - transparent background with border
    secondaryBackground: Color(0x00FFFFFF), // --components-button-secondary-contrast-default: hsla(0,0%,100%,0) = transparent
    secondaryText: Color(0xFFFFFFFF), // --components-button-secondary-contrast-text: #fff
    secondaryTextActive: Color(0xFF181C56), // --components-button-secondary-contrast-text-active: #181c56
    secondaryBackgroundHover: Color(0xFF626493), // --components-button-secondary-contrast-hover: #626493
    secondaryBackgroundActive: Color(0xFF8794D4), // --components-button-secondary-contrast-active: #8794d4
    secondaryBorder: Color(0xFF8284AB), // --components-button-secondary-contrast-border: #8284ab
    secondaryBorderActive: Color(0x00FFFFFF), // --components-button-secondary-contrast-border-active: hsla(0,0%,100%,0) = transparent
    // Success
    successBackground: Color(0xFF5AC39A), // --components-button-success-contrast-default: #5ac39a
    successText: Color(0xFF181C56), // --components-button-success-contrast-text: #181c56
    successBackgroundHover: Color(0xFF9CD9C2), // --components-button-success-contrast-hover: #9cd9c2
    successBackgroundActive: Color(0xFF37AB83), // --components-button-success-contrast-active: #37ab83
    successBorder: Color(0x00000000), // --components-button-success-contrast-border: hsla(0,0%,100%,0) = transparent
    // Negative - transparent background with border
    negativeBackground: Color(0x00FFFFFF), // --components-button-negative-contrast-default: hsla(0,0%,100%,0) = transparent
    negativeText: Color(0xFFFF9494), // --components-button-negative-contrast-text: #ff9494
    negativeTextActive: Color(0xFF181C56), // --components-button-negative-contrast-text-active: #181c56
    negativeBackgroundHover: Color(0x33FF9494), // --components-button-negative-contrast-hover: hsla(0,100%,79%,.2)
    negativeBackgroundActive: Color(0xFFFF9494), // --components-button-negative-contrast-active: #ff9494
    negativeBorder: Color(0xFFFF9494), // --components-button-negative-contrast-border: #ff9494
    // Disabled
    disabledFill: Color(0xFF2D2E3E), // --components-button-disabled-contrast-fill
    disabledText: Color(0xFFB6B8BA), // --components-button-disabled-contrast-text-disabled
    // Focus
    focusOutline: Color(0xFFAEB7E2), // --basecolors-stroke-focus-contrast
  );

  @override
  ThemeExtension<AppButtonColors> copyWith({
    Color? primaryBackground,
    Color? primaryText,
    Color? primaryBackgroundHover,
    Color? primaryBackgroundActive,
    Color? secondaryBackground,
    Color? secondaryText,
    Color? secondaryTextActive,
    Color? secondaryBackgroundHover,
    Color? secondaryBackgroundActive,
    Color? secondaryBorder,
    Color? secondaryBorderActive,
    Color? successBackground,
    Color? successText,
    Color? successBackgroundHover,
    Color? successBackgroundActive,
    Color? successBorder,
    Color? negativeBackground,
    Color? negativeText,
    Color? negativeTextActive,
    Color? negativeBackgroundHover,
    Color? negativeBackgroundActive,
    Color? negativeBorder,
    Color? disabledFill,
    Color? disabledText,
    Color? focusOutline,
  }) {
    return AppButtonColors(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      primaryText: primaryText ?? this.primaryText,
      primaryBackgroundHover: primaryBackgroundHover ?? this.primaryBackgroundHover,
      primaryBackgroundActive: primaryBackgroundActive ?? this.primaryBackgroundActive,
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
      secondaryText: secondaryText ?? this.secondaryText,
      secondaryTextActive: secondaryTextActive ?? this.secondaryTextActive,
      secondaryBackgroundHover: secondaryBackgroundHover ?? this.secondaryBackgroundHover,
      secondaryBackgroundActive: secondaryBackgroundActive ?? this.secondaryBackgroundActive,
      secondaryBorder: secondaryBorder ?? this.secondaryBorder,
      secondaryBorderActive: secondaryBorderActive ?? this.secondaryBorderActive,
      successBackground: successBackground ?? this.successBackground,
      successText: successText ?? this.successText,
      successBackgroundHover: successBackgroundHover ?? this.successBackgroundHover,
      successBackgroundActive: successBackgroundActive ?? this.successBackgroundActive,
      successBorder: successBorder ?? this.successBorder,
      negativeBackground: negativeBackground ?? this.negativeBackground,
      negativeText: negativeText ?? this.negativeText,
      negativeTextActive: negativeTextActive ?? this.negativeTextActive,
      negativeBackgroundHover: negativeBackgroundHover ?? this.negativeBackgroundHover,
      negativeBackgroundActive: negativeBackgroundActive ?? this.negativeBackgroundActive,
      negativeBorder: negativeBorder ?? this.negativeBorder,
      disabledFill: disabledFill ?? this.disabledFill,
      disabledText: disabledText ?? this.disabledText,
      focusOutline: focusOutline ?? this.focusOutline,
    );
  }

  @override
  ThemeExtension<AppButtonColors> lerp(
    ThemeExtension<AppButtonColors>? other,
    double t,
  ) {
    if (other is! AppButtonColors) return this;
    return AppButtonColors(
      primaryBackground: Color.lerp(primaryBackground, other.primaryBackground, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      primaryBackgroundHover: Color.lerp(primaryBackgroundHover, other.primaryBackgroundHover, t)!,
      primaryBackgroundActive: Color.lerp(primaryBackgroundActive, other.primaryBackgroundActive, t)!,
      secondaryBackground: Color.lerp(secondaryBackground, other.secondaryBackground, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      secondaryTextActive: Color.lerp(secondaryTextActive, other.secondaryTextActive, t)!,
      secondaryBackgroundHover: Color.lerp(secondaryBackgroundHover, other.secondaryBackgroundHover, t)!,
      secondaryBackgroundActive: Color.lerp(secondaryBackgroundActive, other.secondaryBackgroundActive, t)!,
      secondaryBorder: Color.lerp(secondaryBorder, other.secondaryBorder, t)!,
      secondaryBorderActive: Color.lerp(secondaryBorderActive, other.secondaryBorderActive, t)!,
      successBackground: Color.lerp(successBackground, other.successBackground, t)!,
      successText: Color.lerp(successText, other.successText, t)!,
      successBackgroundHover: Color.lerp(successBackgroundHover, other.successBackgroundHover, t)!,
      successBackgroundActive: Color.lerp(successBackgroundActive, other.successBackgroundActive, t)!,
      successBorder: Color.lerp(successBorder, other.successBorder, t)!,
      negativeBackground: Color.lerp(negativeBackground, other.negativeBackground, t)!,
      negativeText: Color.lerp(negativeText, other.negativeText, t)!,
      negativeTextActive: Color.lerp(negativeTextActive, other.negativeTextActive, t)!,
      negativeBackgroundHover: Color.lerp(negativeBackgroundHover, other.negativeBackgroundHover, t)!,
      negativeBackgroundActive: Color.lerp(negativeBackgroundActive, other.negativeBackgroundActive, t)!,
      negativeBorder: Color.lerp(negativeBorder, other.negativeBorder, t)!,
      disabledFill: Color.lerp(disabledFill, other.disabledFill, t)!,
      disabledText: Color.lerp(disabledText, other.disabledText, t)!,
      focusOutline: Color.lerp(focusOutline, other.focusOutline, t)!,
    );
  }
}
