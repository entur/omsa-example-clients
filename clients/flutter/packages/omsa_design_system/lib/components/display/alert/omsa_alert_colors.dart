import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';

enum OmsaAlertVariant { success, information, warning, negative }

enum OmsaAlertSize { banner, toast, small }

enum OmsaAlertWidth { fluid, fitContent }

class OmsaAlertColors {
  final Color fillColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;

  const OmsaAlertColors({
    required this.fillColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
  });

  factory OmsaAlertColors.fromContext(
    BuildContext context, {
    required OmsaAlertVariant variant,
    required OmsaAlertSize size,
    OmsaComponentMode mode = OmsaComponentMode.standard,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;
    final isToast = size == OmsaAlertSize.toast;

    if (isLight) {
      return _getLightColors(variant, mode, isToast);
    } else {
      return _getDarkColors(variant, mode, isToast);
    }
  }

  static OmsaAlertColors _getLightColors(
    OmsaAlertVariant variant,
    OmsaComponentMode mode,
    bool isToast,
  ) {
    if (mode == OmsaComponentMode.contrast) {
      switch (variant) {
        case OmsaAlertVariant.success:
          return OmsaAlertColors(
            fillColor: isToast
                ? ComponentLightTokens.alertAlertBoxSuccessContrastFillToast
                : ComponentLightTokens.alertAlertBoxSuccessContrastFillDefault,
            borderColor:
                ComponentLightTokens.alertAlertBoxSuccessContrastBorder,
            iconColor: isToast
                ? ComponentLightTokens.alertAlertBoxSuccessContrastIconToast
                : ComponentLightTokens.alertAlertBoxSuccessContrastIconDefault,
            textColor: isToast
                ? ComponentLightTokens.alertAlertBoxSuccessContrastTextToast
                : ComponentLightTokens.alertAlertBoxSuccessContrastTextDefault,
          );
        case OmsaAlertVariant.information:
          return OmsaAlertColors(
            fillColor: isToast
                ? ComponentLightTokens.alertAlertBoxInformationContrastFillToast
                : ComponentLightTokens
                      .alertAlertBoxInformationContrastFillDefault,
            borderColor:
                ComponentLightTokens.alertAlertBoxInformationContrastBorder,
            iconColor: isToast
                ? ComponentLightTokens.alertAlertBoxInformationContrastIconToast
                : ComponentLightTokens
                      .alertAlertBoxInformationContrastIconDefault,
            textColor: isToast
                ? ComponentLightTokens.alertAlertBoxInformationContrastTextToast
                : ComponentLightTokens
                      .alertAlertBoxInformationContrastTextDefault,
          );
        case OmsaAlertVariant.warning:
          return OmsaAlertColors(
            fillColor: isToast
                ? ComponentLightTokens.alertAlertBoxWarningContrastFillToast
                : ComponentLightTokens.alertAlertBoxWarningContrastFillDefault,
            borderColor:
                ComponentLightTokens.alertAlertBoxWarningContrastBorder,
            iconColor: isToast
                ? ComponentLightTokens.alertAlertBoxWarningContrastIconToast
                : ComponentLightTokens.alertAlertBoxWarningContrastIconDefault,
            textColor: isToast
                ? ComponentLightTokens.alertAlertBoxWarningContrastTextDefault2
                : ComponentLightTokens.alertAlertBoxWarningContrastTextDefault,
          );
        case OmsaAlertVariant.negative:
          return OmsaAlertColors(
            fillColor: isToast
                ? ComponentLightTokens.alertAlertBoxNegativeContrastFillToast
                : ComponentLightTokens.alertAlertBoxNegativeContrastFillDefault,
            borderColor:
                ComponentLightTokens.alertAlertBoxNegativeContrastBorder,
            iconColor: isToast
                ? ComponentLightTokens.alertAlertBoxNegativeContrastIconToast
                : ComponentLightTokens.alertAlertBoxNegativeContrastIconDefault,
            textColor: isToast
                ? ComponentLightTokens.alertAlertBoxNegativeContrastTextToast
                : ComponentLightTokens.alertAlertBoxNegativeContrastTextDefault,
          );
      }
    }

    switch (variant) {
      case OmsaAlertVariant.success:
        return OmsaAlertColors(
          fillColor: isToast
              ? ComponentLightTokens.alertAlertBoxSuccessStandardFillToast
              : ComponentLightTokens.alertAlertBoxSuccessStandardFillDefault,
          borderColor: ComponentLightTokens.alertAlertBoxSuccessStandardBorder,
          iconColor: isToast
              ? ComponentLightTokens.alertAlertBoxSuccessStandardIconToast
              : ComponentLightTokens.alertAlertBoxSuccessStandardIconDefault,
          textColor: isToast
              ? ComponentLightTokens.alertAlertBoxSuccessStandardTextToast
              : ComponentLightTokens.alertAlertBoxSuccessStandardTextDefault,
        );
      case OmsaAlertVariant.information:
        return OmsaAlertColors(
          fillColor: isToast
              ? ComponentLightTokens.alertAlertBoxInformationStandardFillToast
              : ComponentLightTokens
                    .alertAlertBoxInformationStandardFillDefault,
          borderColor:
              ComponentLightTokens.alertAlertBoxInformationStandardBorder,
          iconColor: isToast
              ? ComponentLightTokens.alertAlertBoxInformationStandardIconToast
              : ComponentLightTokens
                    .alertAlertBoxInformationStandardIconDefault,
          textColor: isToast
              ? ComponentLightTokens.alertAlertBoxInformationStandardTextToast
              : ComponentLightTokens
                    .alertAlertBoxInformationStandardTextDefault,
        );
      case OmsaAlertVariant.warning:
        return OmsaAlertColors(
          fillColor: isToast
              ? ComponentLightTokens.alertAlertBoxWarningStandardFillToast
              : ComponentLightTokens.alertAlertBoxWarningStandardFillDefault,
          borderColor: ComponentLightTokens.alertAlertBoxWarningStandardBorder,
          iconColor: isToast
              ? ComponentLightTokens.alertAlertBoxWarningStandardIconToast
              : ComponentLightTokens.alertAlertBoxWarningStandardIconDefault,
          textColor: isToast
              ? ComponentLightTokens.alertAlertBoxWarningStandardTextToast
              : ComponentLightTokens.alertAlertBoxWarningStandardTextDefault,
        );
      case OmsaAlertVariant.negative:
        return OmsaAlertColors(
          fillColor: isToast
              ? ComponentLightTokens.alertAlertBoxNegativeStandardFillToast
              : ComponentLightTokens.alertAlertBoxNegativeStandardFillDefault,
          borderColor: ComponentLightTokens.alertAlertBoxNegativeStandardBorder,
          iconColor: isToast
              ? ComponentLightTokens.alertAlertBoxNegativeStandardIconToast
              : ComponentLightTokens.alertAlertBoxNegativeStandardIconDefault,
          textColor: isToast
              ? ComponentLightTokens.alertAlertBoxNegativeStandardTextToast
              : ComponentLightTokens.alertAlertBoxNegativeStandardTextDefault,
        );
    }
  }

  static OmsaAlertColors _getDarkColors(
    OmsaAlertVariant variant,
    OmsaComponentMode mode,
    bool isToast,
  ) {
    if (mode == OmsaComponentMode.contrast) {
      switch (variant) {
        case OmsaAlertVariant.success:
          return OmsaAlertColors(
            fillColor: isToast
                ? ComponentDarkTokens.alertAlertBoxSuccessContrastFillToast
                : ComponentDarkTokens.alertAlertBoxSuccessContrastFillDefault,
            borderColor: ComponentDarkTokens.alertAlertBoxSuccessContrastBorder,
            iconColor: isToast
                ? ComponentDarkTokens.alertAlertBoxSuccessContrastIconToast
                : ComponentDarkTokens.alertAlertBoxSuccessContrastIconDefault,
            textColor: isToast
                ? ComponentDarkTokens.alertAlertBoxSuccessContrastTextToast
                : ComponentDarkTokens.alertAlertBoxSuccessContrastTextDefault,
          );
        case OmsaAlertVariant.information:
          return OmsaAlertColors(
            fillColor: isToast
                ? ComponentDarkTokens.alertAlertBoxInformationContrastFillToast
                : ComponentDarkTokens
                      .alertAlertBoxInformationContrastFillDefault,
            borderColor:
                ComponentDarkTokens.alertAlertBoxInformationContrastBorder,
            iconColor: isToast
                ? ComponentDarkTokens.alertAlertBoxInformationContrastIconToast
                : ComponentDarkTokens
                      .alertAlertBoxInformationContrastIconDefault,
            textColor: isToast
                ? ComponentDarkTokens.alertAlertBoxInformationContrastTextToast
                : ComponentDarkTokens
                      .alertAlertBoxInformationContrastTextDefault,
          );
        case OmsaAlertVariant.warning:
          return OmsaAlertColors(
            fillColor: isToast
                ? ComponentDarkTokens.alertAlertBoxWarningContrastFillToast
                : ComponentDarkTokens.alertAlertBoxWarningContrastFillDefault,
            borderColor: ComponentDarkTokens.alertAlertBoxWarningContrastBorder,
            iconColor: isToast
                ? ComponentDarkTokens.alertAlertBoxWarningContrastIconToast
                : ComponentDarkTokens.alertAlertBoxWarningContrastIconDefault,
            textColor: isToast
                ? ComponentDarkTokens.alertAlertBoxWarningContrastTextDefault2
                : ComponentDarkTokens.alertAlertBoxWarningContrastTextDefault,
          );
        case OmsaAlertVariant.negative:
          return OmsaAlertColors(
            fillColor: isToast
                ? ComponentDarkTokens.alertAlertBoxNegativeContrastFillToast
                : ComponentDarkTokens.alertAlertBoxNegativeContrastFillDefault,
            borderColor:
                ComponentDarkTokens.alertAlertBoxNegativeContrastBorder,
            iconColor: isToast
                ? ComponentDarkTokens.alertAlertBoxNegativeContrastIconToast
                : ComponentDarkTokens.alertAlertBoxNegativeContrastIconDefault,
            textColor: isToast
                ? ComponentDarkTokens.alertAlertBoxNegativeContrastTextToast
                : ComponentDarkTokens.alertAlertBoxNegativeContrastTextDefault,
          );
      }
    }

    switch (variant) {
      case OmsaAlertVariant.success:
        return OmsaAlertColors(
          fillColor: isToast
              ? ComponentDarkTokens.alertAlertBoxSuccessStandardFillToast
              : ComponentDarkTokens.alertAlertBoxSuccessStandardFillDefault,
          borderColor: ComponentDarkTokens.alertAlertBoxSuccessStandardBorder,
          iconColor: isToast
              ? ComponentDarkTokens.alertAlertBoxSuccessStandardIconToast
              : ComponentDarkTokens.alertAlertBoxSuccessStandardIconDefault,
          textColor: isToast
              ? ComponentDarkTokens.alertAlertBoxSuccessStandardTextToast
              : ComponentDarkTokens.alertAlertBoxSuccessStandardTextDefault,
        );
      case OmsaAlertVariant.information:
        return OmsaAlertColors(
          fillColor: isToast
              ? ComponentDarkTokens.alertAlertBoxInformationStandardFillToast
              : ComponentDarkTokens.alertAlertBoxInformationStandardFillDefault,
          borderColor:
              ComponentDarkTokens.alertAlertBoxInformationStandardBorder,
          iconColor: isToast
              ? ComponentDarkTokens.alertAlertBoxInformationStandardIconToast
              : ComponentDarkTokens.alertAlertBoxInformationStandardIconDefault,
          textColor: isToast
              ? ComponentDarkTokens.alertAlertBoxInformationStandardTextToast
              : ComponentDarkTokens.alertAlertBoxInformationStandardTextDefault,
        );
      case OmsaAlertVariant.warning:
        return OmsaAlertColors(
          fillColor: isToast
              ? ComponentDarkTokens.alertAlertBoxWarningStandardFillToast
              : ComponentDarkTokens.alertAlertBoxWarningStandardFillDefault,
          borderColor: ComponentDarkTokens.alertAlertBoxWarningStandardBorder,
          iconColor: isToast
              ? ComponentDarkTokens.alertAlertBoxWarningStandardIconToast
              : ComponentDarkTokens.alertAlertBoxWarningStandardIconDefault,
          textColor: isToast
              ? ComponentDarkTokens.alertAlertBoxWarningStandardTextToast
              : ComponentDarkTokens.alertAlertBoxWarningStandardTextDefault,
        );
      case OmsaAlertVariant.negative:
        return OmsaAlertColors(
          fillColor: isToast
              ? ComponentDarkTokens.alertAlertBoxNegativeStandardFillToast
              : ComponentDarkTokens.alertAlertBoxNegativeStandardFillDefault,
          borderColor: ComponentDarkTokens.alertAlertBoxNegativeStandardBorder,
          iconColor: isToast
              ? ComponentDarkTokens.alertAlertBoxNegativeStandardIconToast
              : ComponentDarkTokens.alertAlertBoxNegativeStandardIconDefault,
          textColor: isToast
              ? ComponentDarkTokens.alertAlertBoxNegativeStandardTextToast
              : ComponentDarkTokens.alertAlertBoxNegativeStandardTextDefault,
        );
    }
  }
}
