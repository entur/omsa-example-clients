import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';

class OmsaSwitchColors {
  final Color trackColorTrue;
  final Color trackColorFalse;
  final Color thumbColor;
  final Color iconColorTrue;
  final Color iconColorFalse;
  final Color textColor;

  const OmsaSwitchColors({
    required this.trackColorTrue,
    required this.trackColorFalse,
    required this.thumbColor,
    required this.iconColorTrue,
    required this.iconColorFalse,
    required this.textColor,
  });

  factory OmsaSwitchColors.fromContext(
    BuildContext context, {
    OmsaComponentMode mode = OmsaComponentMode.standard,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    if (mode == OmsaComponentMode.contrast) {
      if (isLight) {
        return const OmsaSwitchColors(
          trackColorTrue: ComponentLightTokens.formSwitchContrastFillTrue,
          trackColorFalse: ComponentLightTokens.formSwitchContrastFillFalse,
          thumbColor: ComponentLightTokens.formSwitchContrastSwitch,
          iconColorTrue: ComponentLightTokens.formSwitchContrastIconTrue,
          iconColorFalse: ComponentLightTokens.formSwitchContrastIconFalse,
          textColor: ComponentLightTokens.formSwitchContrastText,
        );
      } else {
        return const OmsaSwitchColors(
          trackColorTrue: ComponentDarkTokens.formSwitchContrastFillTrue,
          trackColorFalse: ComponentDarkTokens.formSwitchContrastFillFalse,
          thumbColor: ComponentDarkTokens.formSwitchContrastSwitch,
          iconColorTrue: ComponentDarkTokens.formSwitchContrastIconTrue,
          iconColorFalse: ComponentDarkTokens.formSwitchContrastIconFalse,
          textColor: ComponentDarkTokens.formSwitchContrastText,
        );
      }
    }

    if (isLight) {
      return const OmsaSwitchColors(
        trackColorTrue: ComponentLightTokens.formSwitchStandardFillTrue,
        trackColorFalse: ComponentLightTokens.formSwitchStandardFillFalse,
        thumbColor: ComponentLightTokens.formSwitchStandardSwitch,
        iconColorTrue: ComponentLightTokens.formSwitchStandardIconTrue,
        iconColorFalse: ComponentLightTokens.formSwitchStandardIconFalse,
        textColor: ComponentLightTokens.formSwitchStandardText,
      );
    } else {
      return const OmsaSwitchColors(
        trackColorTrue: ComponentDarkTokens.formSwitchStandardFillTrue,
        trackColorFalse: ComponentDarkTokens.formSwitchStandardFillFalse,
        thumbColor: ComponentDarkTokens.formSwitchStandardSwitch,
        iconColorTrue: ComponentDarkTokens.formSwitchStandardIconTrue,
        iconColorFalse: ComponentDarkTokens.formSwitchStandardIconFalse,
        textColor: ComponentDarkTokens.formSwitchStandardText,
      );
    }
  }
}
