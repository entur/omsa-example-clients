import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/theme/tokens/base_color_tokens.dart';
import 'package:omsa_design_system/theme/tokens/base_tokens.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';

enum ChipState { defaultState, hovered, pressed, selected, disabled }

/// Color configuration for chips based on state and mode
class OmsaChipColors {
  const OmsaChipColors({
    required this.backgroundDefault,
    required this.backgroundHover,
    required this.backgroundActive,
    required this.border,
    required this.borderDisabled,
    required this.textUnselected,
    required this.textSelected,
    required this.textDisabled,
    required this.iconUnselected,
    required this.iconSelected,
    required this.iconDisabled,
    required this.focus,
  });

  final Color backgroundDefault;
  final Color backgroundHover;
  final Color backgroundActive;
  final Color border;
  final Color borderDisabled;
  final Color textUnselected;
  final Color textSelected;
  final Color textDisabled;
  final Color iconUnselected;
  final Color iconSelected;
  final Color iconDisabled;
  final Color focus;

  /// Create colors based on context and mode
  factory OmsaChipColors.fromContext(
    BuildContext context, {
    OmsaComponentMode mode = OmsaComponentMode.standard,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;
    final tokens = BaseTokens.from(brightness);

    if (mode == OmsaComponentMode.contrast) {
      if (isLight) {
        return OmsaChipColors(
          backgroundDefault: ComponentLightTokens.chipContrastDefault,
          backgroundHover: ComponentLightTokens.chipContrastHover,
          backgroundActive: ComponentLightTokens.chipContrastActive,
          border: ComponentLightTokens.chipContrastBorder,
          borderDisabled: ComponentLightTokens.chipContrastBorderDisabled,
          textUnselected: ComponentLightTokens.chipContrastTextUnselected,
          textSelected: ComponentLightTokens.chipContrastTextSelected,
          textDisabled: ComponentLightTokens.chipContrastTextDisabled,
          iconUnselected: ComponentLightTokens.chipContrastIconUnselected,
          iconSelected: ComponentLightTokens.chipContrastIconSelected,
          iconDisabled: ComponentLightTokens.chipContrastIconDisabled,
          focus: tokens.strokeFocusContrast,
        );
      } else {
        return OmsaChipColors(
          backgroundDefault: ComponentDarkTokens.chipContrastDefault,
          backgroundHover: ComponentDarkTokens.chipContrastHover,
          backgroundActive: ComponentDarkTokens.chipContrastActive,
          border: ComponentDarkTokens.chipContrastBorder,
          borderDisabled: ComponentDarkTokens.chipContrastBorderDisabled,
          textUnselected: ComponentDarkTokens.chipContrastTextUnselected,
          textSelected: ComponentDarkTokens.chipContrastTextSelected,
          textDisabled: ComponentDarkTokens.chipContrastTextDisabled,
          iconUnselected: ComponentDarkTokens.chipContrastIconUnselected,
          iconSelected: ComponentDarkTokens.chipContrastIconSelected,
          iconDisabled: ComponentDarkTokens.chipContrastIconDisabled,
          focus: tokens.strokeFocusContrast,
        );
      }
    }

    // Standard mode
    if (isLight) {
      return OmsaChipColors(
        backgroundDefault: ComponentLightTokens.chipStandardDefault,
        backgroundHover: ComponentLightTokens.chipStandardHover,
        backgroundActive: ComponentLightTokens.chipStandardActive,
        border: ComponentLightTokens.chipStandardBorder,
        borderDisabled: ComponentLightTokens.chipStandardBorderDisabled,
        textUnselected: ComponentLightTokens.chipStandardTextUnselected,
        textSelected: ComponentLightTokens.chipStandardTextSelected,
        textDisabled: ComponentLightTokens.chipStandardTextDisabled,
        iconUnselected: ComponentLightTokens.chipStandardIconUnselected,
        iconSelected: ComponentLightTokens.chipStandardIconSelected,
        iconDisabled: ComponentLightTokens.chipStandardIconDisabled,
        focus: tokens.strokeFocusStandard,
      );
    } else {
      return OmsaChipColors(
        backgroundDefault: ComponentDarkTokens.chipStandardDefault,
        backgroundHover: ComponentDarkTokens.chipStandardHover,
        backgroundActive: ComponentDarkTokens.chipStandardActive,
        border: ComponentDarkTokens.chipStandardBorder,
        borderDisabled: ComponentDarkTokens.chipStandardBorderDisabled,
        textUnselected: ComponentDarkTokens.chipStandardTextUnselected,
        textSelected: ComponentDarkTokens.chipStandardTextSelected,
        textDisabled: ComponentDarkTokens.chipStandardTextDisabled,
        iconUnselected: ComponentDarkTokens.chipStandardIconUnselected,
        iconSelected: ComponentDarkTokens.chipStandardIconSelected,
        iconDisabled: ComponentDarkTokens.chipStandardIconDisabled,
        focus: tokens.strokeFocusStandard,
      );
    }
  }
}
