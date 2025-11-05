import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';

/// Color configuration for tags based on mode
class OmsaTagColors {
  const OmsaTagColors({required this.background, required this.text});

  final Color background;
  final Color text;

  factory OmsaTagColors.fromContext(
    BuildContext context, {
    OmsaComponentMode mode = OmsaComponentMode.standard,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    if (mode == OmsaComponentMode.contrast) {
      if (isLight) {
        return const OmsaTagColors(
          background: ComponentLightTokens.layoutBadgeTagContrastFill,
          text: ComponentLightTokens.layoutBadgeTagContrastText,
        );
      } else {
        return const OmsaTagColors(
          background: ComponentDarkTokens.layoutBadgeTagContrastFill,
          text: ComponentDarkTokens.layoutBadgeTagContrastText,
        );
      }
    }

    // Standard mode
    if (isLight) {
      return const OmsaTagColors(
        background: ComponentLightTokens.layoutBadgeTagStandardFill,
        text: ComponentLightTokens.layoutBadgeTagStandardText,
      );
    } else {
      return const OmsaTagColors(
        background: ComponentDarkTokens.layoutBadgeTagStandardFill,
        text: ComponentDarkTokens.layoutBadgeTagStandardText,
      );
    }
  }
}
