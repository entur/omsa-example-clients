import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';

/// Color configuration for checkboxes based on state and mode
class OmsaCheckboxColors {
  const OmsaCheckboxColors({
    required this.background,
    required this.border,
    required this.icon,
    required this.backgroundHover,
    required this.backgroundSelected,
    required this.backgroundSelectedHover,
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
  final Color backgroundSelectedHover;
  final Color backgroundDisabled;
  final Color borderDisabled;
  final Color iconDisabled;
  final Color text;
  final Color textDisabled;

  /// Create colors based on context and mode
  factory OmsaCheckboxColors.fromContext(
    BuildContext context, {
    OmsaComponentMode mode = OmsaComponentMode.standard,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    if (mode == OmsaComponentMode.contrast) {
      if (isLight) {
        return const OmsaCheckboxColors(
          background: ComponentLightTokens.formCheckboxContrastFillDefault,
          border: ComponentLightTokens.formCheckboxContrastBorder,
          icon: ComponentLightTokens.formCheckboxContrastIcon,
          backgroundHover: ComponentLightTokens.formCheckboxContrastFillHover,
          backgroundSelected:
              ComponentLightTokens.formCheckboxContrastFillSelected,
          backgroundSelectedHover:
              ComponentLightTokens.formCheckboxContrastFillSelectedHover,
          backgroundDisabled:
              ComponentLightTokens.formCheckboxContrastFillDisabled,
          borderDisabled:
              ComponentLightTokens.formCheckboxContrastBorderDisabled,
          iconDisabled: ComponentLightTokens.formCheckboxContrastIconDisabled,
          text: ComponentLightTokens.formCheckboxContrastText,
          textDisabled: ComponentLightTokens.formCheckboxContrastTextDisabled,
        );
      } else {
        return const OmsaCheckboxColors(
          background: ComponentDarkTokens.formCheckboxContrastFillDefault,
          border: ComponentDarkTokens.formCheckboxContrastBorder,
          icon: ComponentDarkTokens.formCheckboxContrastIcon,
          backgroundHover: ComponentDarkTokens.formCheckboxContrastFillHover,
          backgroundSelected:
              ComponentDarkTokens.formCheckboxContrastFillSelected,
          backgroundSelectedHover:
              ComponentDarkTokens.formCheckboxContrastFillSelectedHover,
          backgroundDisabled:
              ComponentDarkTokens.formCheckboxContrastFillDisabled,
          borderDisabled:
              ComponentDarkTokens.formCheckboxContrastBorderDisabled,
          iconDisabled: ComponentDarkTokens.formCheckboxContrastIconDisabled,
          text: ComponentDarkTokens.formCheckboxContrastText,
          textDisabled: ComponentDarkTokens.formCheckboxContrastTextDisabled,
        );
      }
    }

    // Standard mode
    if (isLight) {
      return const OmsaCheckboxColors(
        background: ComponentLightTokens.formCheckboxStandardFillDefault,
        border: ComponentLightTokens.formCheckboxStandardBorder,
        icon: ComponentLightTokens.formCheckboxStandardIcon,
        backgroundHover: ComponentLightTokens.formCheckboxStandardFillHover,
        backgroundSelected:
            ComponentLightTokens.formCheckboxStandardFillSelected,
        backgroundSelectedHover:
            ComponentLightTokens.formCheckboxStandardFillSelectedHover,
        backgroundDisabled:
            ComponentLightTokens.formCheckboxStandardFillDisabled,
        borderDisabled: ComponentLightTokens.formCheckboxStandardBorderDisabled,
        iconDisabled: ComponentLightTokens.formCheckboxStandardIconDisabled,
        text: ComponentLightTokens.formCheckboxStandardText,
        textDisabled: ComponentLightTokens.formCheckboxStandardTextDisabled,
      );
    } else {
      return const OmsaCheckboxColors(
        background: ComponentDarkTokens.formCheckboxStandardFillDefault,
        border: ComponentDarkTokens.formCheckboxStandardBorder,
        icon: ComponentDarkTokens.formCheckboxStandardIcon,
        backgroundHover: ComponentDarkTokens.formCheckboxStandardFillHover,
        backgroundSelected:
            ComponentDarkTokens.formCheckboxStandardFillSelected,
        backgroundSelectedHover:
            ComponentDarkTokens.formCheckboxStandardFillSelectedHover,
        backgroundDisabled:
            ComponentDarkTokens.formCheckboxStandardFillDisabled,
        borderDisabled: ComponentDarkTokens.formCheckboxStandardBorderDisabled,
        iconDisabled: ComponentDarkTokens.formCheckboxStandardIconDisabled,
        text: ComponentDarkTokens.formCheckboxStandardText,
        textDisabled: ComponentDarkTokens.formCheckboxStandardTextDisabled,
      );
    }
  }
}
