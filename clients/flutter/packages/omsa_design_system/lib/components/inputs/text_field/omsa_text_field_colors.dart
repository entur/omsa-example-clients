import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/inputs/text_field/omsa_text_field.dart';

/// Colors for text field component based on theme, mode, and state
class OmsaTextFieldColors {
  const OmsaTextFieldColors({
    required this.border,
    required this.borderInteractive,
    required this.fill,
    required this.text,
    required this.label,
    required this.icon,
  });

  final Color border;
  final Color borderInteractive;
  final Color fill;
  final Color text;
  final Color label;
  final Color icon;

  factory OmsaTextFieldColors.fromContext(
    BuildContext context, {
    required OmsaComponentMode mode,
    required OmsaTextFieldVariant variant,
    required bool disabled,
    required bool readOnly,
    required bool isFocused,
    required bool isHovered,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;
    final isStandard = mode == OmsaComponentMode.standard;

    final Color borderDefault;
    final Color borderInteractive;
    final Color borderSuccess;
    final Color borderNegative;
    final Color fillDefault;
    final Color fillDisabled;
    final Color fillReadOnly;
    final Color textContent;
    final Color textLabel;
    final Color textDisabled;
    final Color icon;

    if (isLight) {
      if (isStandard) {
        borderDefault = ComponentLightTokens.formBaseformStandardBorderDefault;
        borderInteractive =
            ComponentLightTokens.formBaseformStandardBorderInteractive;
        borderSuccess = ComponentLightTokens.formBaseformStandardBorderSuccess;
        borderNegative =
            ComponentLightTokens.formBaseformStandardBorderNegative;
        fillDefault = ComponentLightTokens.formBaseformStandardFillDefault;
        fillDisabled = ComponentLightTokens.formBaseformStandardFillDisabled;
        fillReadOnly = ComponentLightTokens.formBaseformStandardFillReadOnly;
        textContent = ComponentLightTokens.formBaseformStandardTextContent;
        textLabel = ComponentLightTokens.formBaseformStandardTextLabel;
        textDisabled = ComponentLightTokens.formBaseformStandardTextdisabled;
        icon = ComponentLightTokens.formBaseformStandardIcon;
      } else {
        borderDefault = ComponentLightTokens.formBaseformContrastBorderDefault;
        borderInteractive =
            ComponentLightTokens.formBaseformContrastBorderInteractive;
        borderSuccess = ComponentLightTokens.formBaseformContrastBorderSuccess;
        borderNegative =
            ComponentLightTokens.formBaseformContrastBorderNegative;
        fillDefault = ComponentLightTokens.formBaseformContrastFillDefault;
        fillDisabled = ComponentLightTokens.formBaseformContrastFillDisabled;
        fillReadOnly = ComponentLightTokens.formBaseformContrastFillReadOnly;
        textContent = ComponentLightTokens.formBaseformContrastTextContent;
        textLabel = ComponentLightTokens.formBaseformContrastTextLabel;
        textDisabled = ComponentLightTokens.formBaseformContrastTextdisabled;
        icon = ComponentLightTokens.formBaseformContrastIcon;
      }
    } else {
      if (isStandard) {
        borderDefault = ComponentDarkTokens.formBaseformStandardBorderDefault;
        borderInteractive =
            ComponentDarkTokens.formBaseformStandardBorderInteractive;
        borderSuccess = ComponentDarkTokens.formBaseformStandardBorderSuccess;
        borderNegative = ComponentDarkTokens.formBaseformStandardBorderNegative;
        fillDefault = ComponentDarkTokens.formBaseformStandardFillDefault;
        fillDisabled = ComponentDarkTokens.formBaseformStandardFillDisabled;
        fillReadOnly = ComponentDarkTokens.formBaseformStandardFillReadOnly;
        textContent = ComponentDarkTokens.formBaseformStandardTextContent;
        textLabel = ComponentDarkTokens.formBaseformStandardTextLabel;
        textDisabled = ComponentDarkTokens.formBaseformStandardTextdisabled;
        icon = ComponentDarkTokens.formBaseformStandardIcon;
      } else {
        borderDefault = ComponentDarkTokens.formBaseformContrastBorderDefault;
        borderInteractive =
            ComponentDarkTokens.formBaseformContrastBorderInteractive;
        borderSuccess = ComponentDarkTokens.formBaseformContrastBorderSuccess;
        borderNegative = ComponentDarkTokens.formBaseformContrastBorderNegative;
        fillDefault = ComponentDarkTokens.formBaseformContrastFillDefault;
        fillDisabled = ComponentDarkTokens.formBaseformContrastFillDisabled;
        fillReadOnly = ComponentDarkTokens.formBaseformContrastFillReadOnly;
        textContent = ComponentDarkTokens.formBaseformContrastTextContent;
        textLabel = ComponentDarkTokens.formBaseformContrastTextLabel;
        textDisabled = ComponentDarkTokens.formBaseformContrastTextdisabled;
        icon = ComponentDarkTokens.formBaseformContrastIcon;
      }
    }

    Color borderColor;
    if (disabled || readOnly) {
      borderColor = Colors.transparent;
    } else if (variant == OmsaTextFieldVariant.success) {
      borderColor = borderSuccess;
    } else if (variant == OmsaTextFieldVariant.negative) {
      borderColor = borderNegative;
    } else if (isFocused || isHovered) {
      borderColor = borderInteractive;
    } else {
      borderColor = borderDefault;
    }

    final fillColor = disabled
        ? fillDisabled
        : readOnly
        ? fillReadOnly
        : fillDefault;

    final textColor = disabled ? textDisabled : textContent;

    return OmsaTextFieldColors(
      border: borderColor,
      borderInteractive: borderInteractive,
      fill: fillColor,
      text: textColor,
      label: disabled ? textDisabled : textLabel,
      icon: icon,
    );
  }
}
