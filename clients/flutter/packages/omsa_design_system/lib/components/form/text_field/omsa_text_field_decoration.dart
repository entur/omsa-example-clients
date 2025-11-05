import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/app_dimensions.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/theme/app_typography.dart';
import 'package:omsa_design_system/components/form/text_field/omsa_text_field.dart';
import 'package:omsa_design_system/components/form/text_field/omsa_text_field_colors.dart';

/// Utility class for building TextField decorations
class OmsaTextFieldDecorationBuilder {
  OmsaTextFieldDecorationBuilder._();

  static double getLabelTop({
    required OmsaTextFieldSize size,
    required bool shouldFloat,
  }) {
    if (shouldFloat) {
      return size == OmsaTextFieldSize.medium ? 6.0 : 8.0;
    } else {
      return size == OmsaTextFieldSize.medium ? 16.0 : 12.0;
    }
  }

  static EdgeInsets getContentPadding(OmsaTextFieldSize size) {
    return EdgeInsets.only(
      top: size == OmsaTextFieldSize.medium ? 20.0 : 24.0,
      bottom: AppSpacing.spaceExtraSmall2,
    );
  }

  static InputDecoration buildDecoration({
    required OmsaTextFieldColors colors,
    required OmsaTextFieldSize size,
    required bool isFocused,
    String? hint,
  }) {
    final fontSize = size == OmsaTextFieldSize.medium
        ? AppTypography.fontSizesLarge
        : AppTypography.fontSizesExtraLarge2;

    final lineHeight = size == OmsaTextFieldSize.medium
        ? AppTypography.lineHeightsSmall
        : AppTypography.lineHeightsExtraLarge2;

    return InputDecoration(
      isDense: true,
      contentPadding: getContentPadding(size),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintText: isFocused ? hint : null,
      hintStyle: TextStyle(
        color: colors.label,
        fontSize: fontSize,
        height: lineHeight / fontSize,
      ),
      counterText: '',
    );
  }

  static BoxDecoration buildContainerDecoration({
    required OmsaTextFieldColors colors,
    required bool isFocused,
  }) {
    return BoxDecoration(
      color: colors.fill,
      borderRadius: AppDimensions.borderRadiusMedium,
      border: Border.all(
        color: colors.border,
        width: AppDimensions.borderWidthsMedium,
      ),
      boxShadow: isFocused
          ? [
              BoxShadow(
                color: colors.border,
                spreadRadius: 1.0,
                blurRadius: 0,
                offset: Offset.zero,
              ),
            ]
          : null,
    );
  }

  static TextStyle getTextStyle({
    required OmsaTextFieldColors colors,
    required OmsaTextFieldSize size,
  }) {
    final fontSize = size == OmsaTextFieldSize.medium
        ? AppTypography.fontSizesLarge
        : AppTypography.fontSizesExtraLarge2;

    final lineHeight = size == OmsaTextFieldSize.medium
        ? AppTypography.lineHeightsSmall
        : AppTypography.lineHeightsExtraLarge2;

    return TextStyle(
      color: colors.text,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      fontWeight: AppTypography.fontWeightsBody,
    );
  }

  static TextStyle getLabelStyle({
    required OmsaTextFieldColors colors,
    required OmsaTextFieldSize size,
    required bool shouldFloat,
  }) {
    final fontSize = shouldFloat
        ? AppTypography.fontSizesSmall
        : (size == OmsaTextFieldSize.medium
              ? AppTypography.fontSizesLarge
              : AppTypography.fontSizesExtraLarge2);

    final lineHeight = shouldFloat
        ? 1.0
        : (size == OmsaTextFieldSize.medium
              ? AppTypography.lineHeightsSmall / AppTypography.fontSizesLarge
              : AppTypography.lineHeightsExtraLarge2 /
                    AppTypography.fontSizesExtraLarge2);

    return TextStyle(
      color: colors.label,
      fontSize: fontSize,
      height: lineHeight,
      fontWeight: AppTypography.fontWeightsBody,
    );
  }

  static double getMinHeight(OmsaTextFieldSize size) {
    return size == OmsaTextFieldSize.medium ? 48.0 : 64.0;
  }
}
