import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/layout/badge/omsa_badge_enums.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';

class OmsaBadgeColors {
  const OmsaBadgeColors({
    required this.background,
    required this.text,
    this.border,
    this.bullet,
  });

  final Color background;
  final Color text;
  final Color? border;
  final Color? bullet;

  factory OmsaBadgeColors.fromContext(
    BuildContext context, {
    required OmsaBadgeVariant variant,
    OmsaComponentMode mode = OmsaComponentMode.standard,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    // Normalize deprecated variants
    final effectiveVariant = _normalizeVariant(variant);

    if (mode == OmsaComponentMode.contrast) {
      return isLight
          ? _createLightContrastColors(effectiveVariant)
          : _createDarkContrastColors(effectiveVariant);
    }

    // Standard mode
    return isLight
        ? _createLightStandardColors(effectiveVariant)
        : _createDarkStandardColors(effectiveVariant);
  }

  static OmsaBadgeVariant _normalizeVariant(OmsaBadgeVariant variant) {
    switch (variant) {
      case OmsaBadgeVariant.info:
        return OmsaBadgeVariant.information;
      case OmsaBadgeVariant.danger:
        return OmsaBadgeVariant.negative;
      default:
        return variant;
    }
  }

  static OmsaBadgeColors _createLightStandardColors(OmsaBadgeVariant variant) {
    switch (variant) {
      case OmsaBadgeVariant.primary:
        return const OmsaBadgeColors(
          background: ComponentLightTokens.layoutBadgePrimaryStandardFill,
          text: ComponentLightTokens.layoutBadgePrimaryStandardText,
          bullet: ComponentLightTokens.layoutBadgePrimaryStandardBullet,
        );
      case OmsaBadgeVariant.neutral:
        return const OmsaBadgeColors(
          background: ComponentLightTokens.layoutBadgeNeutralStandardFill,
          text: ComponentLightTokens.layoutBadgeNeutralStandardText,
          border: ComponentLightTokens.layoutBadgeNeutralStandardBorder,
          bullet: ComponentLightTokens.layoutBadgeNeutralStandardBullet,
        );
      case OmsaBadgeVariant.success:
        return const OmsaBadgeColors(
          background: ComponentLightTokens.layoutBadgeSuccessStandardFill,
          text: ComponentLightTokens.layoutBadgeSuccessStandardText,
          border: ComponentLightTokens.layoutBadgeSuccessStandardBorder,
          bullet: ComponentLightTokens.layoutBadgeSuccessStandardBullet,
        );
      case OmsaBadgeVariant.warning:
        return const OmsaBadgeColors(
          background: ComponentLightTokens.layoutBadgeWarningStandardFill,
          text: ComponentLightTokens.layoutBadgeWarningStandardText,
          border: ComponentLightTokens.layoutBadgeWarningStandardBorder,
          bullet: ComponentLightTokens.layoutBadgeWarningStandardBullet,
        );
      case OmsaBadgeVariant.negative:
        return const OmsaBadgeColors(
          background: ComponentLightTokens.layoutBadgeNegativeStandardFill,
          text: ComponentLightTokens.layoutBadgeNegativeStandardText,
          border: ComponentLightTokens.layoutBadgeNegativeStandardBorder,
          bullet: ComponentLightTokens.layoutBadgeNegativeStandardBullet,
        );
      case OmsaBadgeVariant.information:
        return const OmsaBadgeColors(
          background: ComponentLightTokens.layoutBadgeInformationStandardFill,
          text: ComponentLightTokens.layoutBadgeInformationStandardText,
          border: ComponentLightTokens.layoutBadgeInformationStandardBorder,
          bullet: ComponentLightTokens.layoutBadgeInformationStandardBullet,
        );
      default:
        return _createLightStandardColors(OmsaBadgeVariant.primary);
    }
  }

  static OmsaBadgeColors _createDarkStandardColors(OmsaBadgeVariant variant) {
    switch (variant) {
      case OmsaBadgeVariant.primary:
        return const OmsaBadgeColors(
          background: ComponentDarkTokens.layoutBadgePrimaryStandardFill,
          text: ComponentDarkTokens.layoutBadgePrimaryStandardText,
          bullet: ComponentDarkTokens.layoutBadgePrimaryStandardBullet,
        );
      case OmsaBadgeVariant.neutral:
        return const OmsaBadgeColors(
          background: ComponentDarkTokens.layoutBadgeNeutralStandardFill,
          text: ComponentDarkTokens.layoutBadgeNeutralStandardText,
          border: ComponentDarkTokens.layoutBadgeNeutralStandardBorder,
          bullet: ComponentDarkTokens.layoutBadgeNeutralStandardBullet,
        );
      case OmsaBadgeVariant.success:
        return const OmsaBadgeColors(
          background: ComponentDarkTokens.layoutBadgeSuccessStandardFill,
          text: ComponentDarkTokens.layoutBadgeSuccessStandardText,
          border: ComponentDarkTokens.layoutBadgeSuccessStandardBorder,
          bullet: ComponentDarkTokens.layoutBadgeSuccessStandardBullet,
        );
      case OmsaBadgeVariant.warning:
        return const OmsaBadgeColors(
          background: ComponentDarkTokens.layoutBadgeWarningStandardFill,
          text: ComponentDarkTokens.layoutBadgeWarningStandardText,
          border: ComponentDarkTokens.layoutBadgeWarningStandardBorder,
          bullet: ComponentDarkTokens.layoutBadgeWarningStandardBullet,
        );
      case OmsaBadgeVariant.negative:
        return const OmsaBadgeColors(
          background: ComponentDarkTokens.layoutBadgeNegativeStandardFill,
          text: ComponentDarkTokens.layoutBadgeNegativeStandardText,
          border: ComponentDarkTokens.layoutBadgeNegativeStandardBorder,
          bullet: ComponentDarkTokens.layoutBadgeNegativeStandardBullet,
        );
      case OmsaBadgeVariant.information:
        return const OmsaBadgeColors(
          background: ComponentDarkTokens.layoutBadgeInformationStandardFill,
          text: ComponentDarkTokens.layoutBadgeInformationStandardText,
          border: ComponentDarkTokens.layoutBadgeInformationStandardBorder,
          bullet: ComponentDarkTokens.layoutBadgeInformationStandardBullet,
        );
      default:
        return _createDarkStandardColors(OmsaBadgeVariant.primary);
    }
  }

  static OmsaBadgeColors _createLightContrastColors(OmsaBadgeVariant variant) {
    switch (variant) {
      case OmsaBadgeVariant.primary:
        return const OmsaBadgeColors(
          background: ComponentLightTokens.layoutBadgePrimaryContrastFill,
          text: ComponentLightTokens.layoutBadgePrimaryContrastText,
          bullet: ComponentLightTokens.layoutBadgePrimaryContrastBullet,
        );
      case OmsaBadgeVariant.neutral:
        return const OmsaBadgeColors(
          background: ComponentLightTokens.layoutBadgeNeutralContrastFill,
          text: ComponentLightTokens.layoutBadgeNeutralContrastText,
          border: ComponentLightTokens.layoutBadgeNeutralContrastBorder,
          bullet: ComponentLightTokens.layoutBadgeNeutralContrastBullet,
        );
      case OmsaBadgeVariant.success:
        return const OmsaBadgeColors(
          background: ComponentLightTokens.layoutBadgeSuccessContrastFill,
          text: ComponentLightTokens.layoutBadgeSuccessContrastText,
          border: ComponentLightTokens.layoutBadgeSuccessContrastBorder,
          bullet: ComponentLightTokens.layoutBadgeSuccessContrastBullet,
        );
      case OmsaBadgeVariant.warning:
        return const OmsaBadgeColors(
          background: ComponentLightTokens.layoutBadgeWarningContrastFill,
          text: ComponentLightTokens.layoutBadgeWarningContrastText,
          border: ComponentLightTokens.layoutBadgeWarningContrastBorder,
          bullet: ComponentLightTokens.layoutBadgeWarningContrastBullet,
        );
      case OmsaBadgeVariant.negative:
        return const OmsaBadgeColors(
          background: ComponentLightTokens.layoutBadgeNegativeContrastFill,
          text: ComponentLightTokens.layoutBadgeNegativeContrastText,
          border: ComponentLightTokens.layoutBadgeNegativeContrastBorder,
          bullet: ComponentLightTokens.layoutBadgeNegativeContrastBullet,
        );
      case OmsaBadgeVariant.information:
        return const OmsaBadgeColors(
          background: ComponentLightTokens.layoutBadgeInformationContrastFill,
          text: ComponentLightTokens.layoutBadgeInformationContrastText,
          border: ComponentLightTokens.layoutBadgeInformationContrastBorder,
          bullet: ComponentLightTokens.layoutBadgeInformationContrastBullet,
        );
      default:
        return _createLightContrastColors(OmsaBadgeVariant.primary);
    }
  }

  static OmsaBadgeColors _createDarkContrastColors(OmsaBadgeVariant variant) {
    switch (variant) {
      case OmsaBadgeVariant.primary:
        return const OmsaBadgeColors(
          background: ComponentDarkTokens.layoutBadgePrimaryContrastFill,
          text: ComponentDarkTokens.layoutBadgePrimaryContrastText,
          bullet: ComponentDarkTokens.layoutBadgePrimaryContrastBullet,
        );
      case OmsaBadgeVariant.neutral:
        return const OmsaBadgeColors(
          background: ComponentDarkTokens.layoutBadgeNeutralContrastFill,
          text: ComponentDarkTokens.layoutBadgeNeutralContrastText,
          border: ComponentDarkTokens.layoutBadgeNeutralContrastBorder,
          bullet: ComponentDarkTokens.layoutBadgeNeutralContrastBullet,
        );
      case OmsaBadgeVariant.success:
        return const OmsaBadgeColors(
          background: ComponentDarkTokens.layoutBadgeSuccessContrastFill,
          text: ComponentDarkTokens.layoutBadgeSuccessContrastText,
          border: ComponentDarkTokens.layoutBadgeSuccessContrastBorder,
          bullet: ComponentDarkTokens.layoutBadgeSuccessContrastBullet,
        );
      case OmsaBadgeVariant.warning:
        return const OmsaBadgeColors(
          background: ComponentDarkTokens.layoutBadgeWarningContrastFill,
          text: ComponentDarkTokens.layoutBadgeWarningContrastText,
          border: ComponentDarkTokens.layoutBadgeWarningContrastBorder,
          bullet: ComponentDarkTokens.layoutBadgeWarningContrastBullet,
        );
      case OmsaBadgeVariant.negative:
        return const OmsaBadgeColors(
          background: ComponentDarkTokens.layoutBadgeNegativeContrastFill,
          text: ComponentDarkTokens.layoutBadgeNegativeContrastText,
          border: ComponentDarkTokens.layoutBadgeNegativeContrastBorder,
          bullet: ComponentDarkTokens.layoutBadgeNegativeContrastBullet,
        );
      case OmsaBadgeVariant.information:
        return const OmsaBadgeColors(
          background: ComponentDarkTokens.layoutBadgeInformationContrastFill,
          text: ComponentDarkTokens.layoutBadgeInformationContrastText,
          border: ComponentDarkTokens.layoutBadgeInformationContrastBorder,
          bullet: ComponentDarkTokens.layoutBadgeInformationContrastBullet,
        );
      default:
        return _createDarkContrastColors(OmsaBadgeVariant.primary);
    }
  }
}
