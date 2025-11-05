import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';

class OmsaDropdownListColors {
  const OmsaDropdownListColors({
    required this.background,
    required this.border,
    required this.text,
    required this.itemBackground,
    required this.itemHoverBackground,
  });

  final Color background;
  final Color border;
  final Color text;
  final Color itemBackground;
  final Color itemHoverBackground;

  factory OmsaDropdownListColors.fromContext(
    BuildContext context, {
    OmsaComponentMode mode = OmsaComponentMode.standard,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    if (mode == OmsaComponentMode.contrast) {
      if (isLight) {
        return const OmsaDropdownListColors(
          background: ComponentLightTokens.formBasemenuFillDefault,
          border: ComponentLightTokens.formBasemenuBorder,
          text: ComponentLightTokens.formBasemenuText,
          itemBackground: ComponentLightTokens.formBasemenuFillDefault,
          itemHoverBackground: ComponentLightTokens.formBasemenuFillHover,
        );
      } else {
        return const OmsaDropdownListColors(
          background: ComponentDarkTokens.formBasemenuFillDefault,
          border: ComponentDarkTokens.formBasemenuBorder,
          text: ComponentDarkTokens.formBasemenuText,
          itemBackground: ComponentDarkTokens.formBasemenuFillDefault,
          itemHoverBackground: ComponentDarkTokens.formBasemenuFillHover,
        );
      }
    }

    // Standard mode
    if (isLight) {
      return const OmsaDropdownListColors(
        background: ComponentLightTokens.formBasemenuFillDefault,
        border: ComponentLightTokens.formBasemenuBorder,
        text: ComponentLightTokens.formBasemenuText,
        itemBackground: ComponentLightTokens.formBasemenuFillDefault,
        itemHoverBackground: ComponentLightTokens.formBasemenuFillHover,
      );
    } else {
      return const OmsaDropdownListColors(
        background: ComponentDarkTokens.formBasemenuFillDefault,
        border: ComponentDarkTokens.formBasemenuBorder,
        text: ComponentDarkTokens.formBasemenuText,
        itemBackground: ComponentDarkTokens.formBasemenuFillDefault,
        itemHoverBackground: ComponentDarkTokens.formBasemenuFillHover,
      );
    }
  }
}
