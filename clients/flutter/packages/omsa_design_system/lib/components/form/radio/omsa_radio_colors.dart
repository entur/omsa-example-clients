import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';

/// Color configuration for radio buttons based on state and mode
class OmsaRadioColors {
  const OmsaRadioColors({
    required this.background,
    required this.border,
    required this.icon,
    required this.backgroundHover,
    required this.backgroundSelected,
    required this.backgroundDisabled,
    required this.borderDisabled,
    required this.iconDisabled,
    required this.text,
    required this.textDisabled,
  });

  final Color background;
  final Color border;
  final Color icon;
  final Color backgroundHover;
  final Color backgroundSelected;
  final Color backgroundDisabled;
  final Color borderDisabled;
  final Color iconDisabled;
  final Color text;
  final Color textDisabled;

  /// Create colors based on context and mode
  factory OmsaRadioColors.fromContext(
    BuildContext context, {
    OmsaComponentMode mode = OmsaComponentMode.standard,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    if (mode == OmsaComponentMode.contrast) {
      if (isLight) {
        return const OmsaRadioColors(
          background: ComponentLightTokens.formRadioContrastFillDefault,
          border: ComponentLightTokens.formRadioContrastBorder,
          icon: ComponentLightTokens.formRadioContrastIcon,
          backgroundHover: ComponentLightTokens.formRadioContrastFillHover,
          backgroundSelected:
              ComponentLightTokens.formRadioContrastFillSelected,
          backgroundDisabled:
              ComponentLightTokens.formRadioContrastFillDisabled,
          borderDisabled: ComponentLightTokens.formRadioContrastBorderDisabled,
          iconDisabled: ComponentLightTokens.formRadioContrastIconDisabled,
          text: ComponentLightTokens.formRadioContrastText,
          textDisabled: ComponentLightTokens.formRadioContrastTextDisabled,
        );
      } else {
        return const OmsaRadioColors(
          background: ComponentDarkTokens.formRadioContrastFillDefault,
          border: ComponentDarkTokens.formRadioContrastBorder,
          icon: ComponentDarkTokens.formRadioContrastIcon,
          backgroundHover: ComponentDarkTokens.formRadioContrastFillHover,
          backgroundSelected: ComponentDarkTokens.formRadioContrastFillSelected,
          backgroundDisabled: ComponentDarkTokens.formRadioContrastFillDisabled,
          borderDisabled: ComponentDarkTokens.formRadioContrastBorderDisabled,
          iconDisabled: ComponentDarkTokens.formRadioContrastIconDisabled,
          text: ComponentDarkTokens.formRadioContrastText,
          textDisabled: ComponentDarkTokens.formRadioContrastTextDisabled,
        );
      }
    }

    // Standard mode
    if (isLight) {
      return const OmsaRadioColors(
        background: ComponentLightTokens.formRadioStandardFillDefault,
        border: ComponentLightTokens.formRadioStandardBorder,
        icon: ComponentLightTokens.formRadioStandardIcon,
        backgroundHover: ComponentLightTokens.formRadioStandardFillHover,
        backgroundSelected: ComponentLightTokens.formRadioStandardFillSelected,
        backgroundDisabled: ComponentLightTokens.formRadioStandardFillDisabled,
        borderDisabled: ComponentLightTokens.formRadioStandardBorderDisabled,
        iconDisabled: ComponentLightTokens.formRadioStandardIconDisabled,
        text: ComponentLightTokens.formRadioStandardText,
        textDisabled: ComponentLightTokens.formRadioStandardTextDisabled,
      );
    } else {
      return const OmsaRadioColors(
        background: ComponentDarkTokens.formRadioStandardFillDefault,
        border: ComponentDarkTokens.formRadioStandardBorder,
        icon: ComponentDarkTokens.formRadioStandardIcon,
        backgroundHover: ComponentDarkTokens.formRadioStandardFillHover,
        backgroundSelected: ComponentDarkTokens.formRadioStandardFillSelected,
        backgroundDisabled: ComponentDarkTokens.formRadioStandardFillDisabled,
        borderDisabled: ComponentDarkTokens.formRadioStandardBorderDisabled,
        iconDisabled: ComponentDarkTokens.formRadioStandardIconDisabled,
        text: ComponentDarkTokens.formRadioStandardText,
        textDisabled: ComponentDarkTokens.formRadioStandardTextDisabled,
      );
    }
  }
}
