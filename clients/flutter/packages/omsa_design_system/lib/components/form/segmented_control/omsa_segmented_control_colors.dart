import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/theme/app_shadows.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';

class OmsaSegmentedControlColors {
  const OmsaSegmentedControlColors({
    required this.containerBackground,
    required this.choiceBackground,
    required this.choiceBackgroundHover,
    required this.choiceBackgroundSelected,
    required this.choiceText,
    required this.choiceTextSelected,
    required this.focusShadows,
    required this.selectedShadows,
    required this.labelColor,
  });

  final Color containerBackground;
  final Color choiceBackground;
  final Color choiceBackgroundHover;
  final Color choiceBackgroundSelected;
  final Color choiceText;
  final Color choiceTextSelected;
  final List<BoxShadow> focusShadows;
  final List<BoxShadow> selectedShadows;
  final Color labelColor;

  factory OmsaSegmentedControlColors.fromContext(
    BuildContext context, {
    OmsaComponentMode mode = OmsaComponentMode.standard,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    if (mode == OmsaComponentMode.contrast) {
      if (isLight) {
        return const OmsaSegmentedControlColors(
          containerBackground:
              ComponentLightTokens.formSegmentedControlContrastBackground,
          choiceBackground:
              ComponentLightTokens.formSegmentedControlContrastFillUnselected,
          choiceBackgroundHover:
              ComponentLightTokens.formSegmentedControlContrastFillHover,
          choiceBackgroundSelected:
              ComponentLightTokens.formSegmentedControlContrastFillSelected,
          choiceText:
              ComponentLightTokens.formSegmentedControlContrastTextUnselected,
          choiceTextSelected:
              ComponentLightTokens.formSegmentedControlContrastTextSelected,
          focusShadows: AppShadows.shadowsFocusContrast,
          selectedShadows: AppShadows.shadowsBoxShadowContrast,
          labelColor: ComponentLightTokens.formBaseformContrastTextLabel,
        );
      }

      return const OmsaSegmentedControlColors(
        containerBackground:
            ComponentDarkTokens.formSegmentedControlContrastBackground,
        choiceBackground:
            ComponentDarkTokens.formSegmentedControlContrastFillUnselected,
        choiceBackgroundHover:
            ComponentDarkTokens.formSegmentedControlContrastFillHover,
        choiceBackgroundSelected:
            ComponentDarkTokens.formSegmentedControlContrastFillSelected,
        choiceText:
            ComponentDarkTokens.formSegmentedControlContrastTextUnselected,
        choiceTextSelected:
            ComponentDarkTokens.formSegmentedControlContrastTextSelected,
        focusShadows: AppShadows.shadowsFocusContrast,
        selectedShadows: AppShadows.shadowsBoxShadowContrast,
        labelColor: ComponentDarkTokens.formBaseformContrastTextLabel,
      );
    }

    if (isLight) {
      return const OmsaSegmentedControlColors(
        containerBackground:
            ComponentLightTokens.formSegmentedControlStandardBackground,
        choiceBackground:
            ComponentLightTokens.formSegmentedControlStandardFillUnselected,
        choiceBackgroundHover:
            ComponentLightTokens.formSegmentedControlStandardFillHover,
        choiceBackgroundSelected:
            ComponentLightTokens.formSegmentedControlStandardFillSelected,
        choiceText:
            ComponentLightTokens.formSegmentedControlStandardTextUnselected,
        choiceTextSelected:
            ComponentLightTokens.formSegmentedControlStandardTextSelected,
        focusShadows: AppShadows.shadowsFocus,
        selectedShadows: AppShadows.shadowsBoxShadow,
        labelColor: ComponentLightTokens.formBaseformStandardTextLabel,
      );
    }

    return const OmsaSegmentedControlColors(
      containerBackground:
          ComponentDarkTokens.formSegmentedControlStandardBackground,
      choiceBackground:
          ComponentDarkTokens.formSegmentedControlStandardFillUnselected,
      choiceBackgroundHover:
          ComponentDarkTokens.formSegmentedControlStandardFillHover,
      choiceBackgroundSelected:
          ComponentDarkTokens.formSegmentedControlStandardFillSelected,
      choiceText:
          ComponentDarkTokens.formSegmentedControlStandardTextUnselected,
      choiceTextSelected:
          ComponentDarkTokens.formSegmentedControlStandardTextSelected,
      focusShadows: AppShadows.shadowsFocus,
      selectedShadows: AppShadows.shadowsBoxShadow,
      labelColor: ComponentDarkTokens.formBaseformStandardTextLabel,
    );
  }
}
