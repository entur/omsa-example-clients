import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';

/// Color configuration for input panels based on state and mode
class OmsaInputPanelColors {
  const OmsaInputPanelColors({
    required this.background,
    required this.border,
    required this.text,
    required this.backgroundSelected,
    required this.borderSelected,
    required this.backgroundHover,
    required this.backgroundDisabled,
    required this.borderDisabled,
    required this.textDisabled,
  });

  final Color background;
  final Color border;
  final Color text;
  final Color backgroundSelected;
  final Color borderSelected;
  final Color backgroundHover;
  final Color backgroundDisabled;
  final Color borderDisabled;
  final Color textDisabled;

  /// Create colors based on context, mode, and state
  factory OmsaInputPanelColors.fromContext(
    BuildContext context, {
    OmsaComponentMode mode = OmsaComponentMode.standard,
    bool disabled = false,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    if (mode == OmsaComponentMode.contrast) {
      if (isLight) {
        return const OmsaInputPanelColors(
          background: ComponentLightTokens.formBasepanelContrastFillDefault,
          border: ComponentLightTokens.formBasepanelContrastBorderDefault,
          text: ComponentLightTokens.formBasepanelContrastTextAccent,
          backgroundSelected:
              ComponentLightTokens.formBasepanelContrastFillSelected,
          borderSelected:
              ComponentLightTokens.formBasepanelContrastBorderSelected,
          backgroundHover: ComponentLightTokens.formBasepanelContrastFillHover,
          backgroundDisabled:
              ComponentLightTokens.formBasepanelContrastFillDisabled,
          borderDisabled:
              ComponentLightTokens.formBasepanelContrastBorderDisabled,
          textDisabled: ComponentLightTokens.formBasepanelContrastTextDisabled,
        );
      } else {
        return const OmsaInputPanelColors(
          background: ComponentDarkTokens.formBasepanelContrastFillDefault,
          border: ComponentDarkTokens.formBasepanelContrastBorderDefault,
          text: ComponentDarkTokens.formBasepanelContrastTextAccent,
          backgroundSelected:
              ComponentDarkTokens.formBasepanelContrastFillSelected,
          borderSelected:
              ComponentDarkTokens.formBasepanelContrastBorderSelected,
          backgroundHover: ComponentDarkTokens.formBasepanelContrastFillHover,
          backgroundDisabled:
              ComponentDarkTokens.formBasepanelContrastFillDisabled,
          borderDisabled:
              ComponentDarkTokens.formBasepanelContrastBorderDisabled,
          textDisabled: ComponentDarkTokens.formBasepanelContrastTextDisabled,
        );
      }
    }

    // Standard mode
    if (isLight) {
      return const OmsaInputPanelColors(
        background: ComponentLightTokens.formBasepanelStandardFillDefault,
        border: ComponentLightTokens.formBasepanelStandardBorderDefault,
        text: ComponentLightTokens.formBasepanelStandardTextAccent,
        backgroundSelected:
            ComponentLightTokens.formBasepanelStandardFillSelected,
        borderSelected:
            ComponentLightTokens.formBasepanelStandardBorderSelected,
        backgroundHover: ComponentLightTokens.formBasepanelStandardFillHover,
        backgroundDisabled:
            ComponentLightTokens.formBasepanelStandardFillDisabled,
        borderDisabled:
            ComponentLightTokens.formBasepanelStandardBorderDisabled,
        textDisabled: ComponentLightTokens.formBasepanelStandardTextDisabled,
      );
    } else {
      return const OmsaInputPanelColors(
        background: ComponentDarkTokens.formBasepanelStandardFillDefault,
        border: ComponentDarkTokens.formBasepanelStandardBorderDefault,
        text: ComponentDarkTokens.formBasepanelStandardTextAccent,
        backgroundSelected:
            ComponentDarkTokens.formBasepanelStandardFillSelected,
        borderSelected: ComponentDarkTokens.formBasepanelStandardBorderSelected,
        backgroundHover: ComponentDarkTokens.formBasepanelStandardFillHover,
        backgroundDisabled:
            ComponentDarkTokens.formBasepanelStandardFillDisabled,
        borderDisabled: ComponentDarkTokens.formBasepanelStandardBorderDisabled,
        textDisabled: ComponentDarkTokens.formBasepanelStandardTextDisabled,
      );
    }
  }
}
