import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/app_typography.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';
import 'package:omsa_design_system/components/form/text_field/omsa_text_field.dart';
import 'package:omsa_icons/omsa_icons.dart';

/// Feedback text component for text fields
class OmsaTextFieldFeedback extends StatelessWidget {
  const OmsaTextFieldFeedback({
    super.key,
    required this.text,
    required this.variant,
  });

  final String text;
  final OmsaTextFieldVariant variant;

  OmsaIconData? get _icon {
    switch (variant) {
      case OmsaTextFieldVariant.success:
        return OmsaIcons.ValidationSuccessFilled;
      case OmsaTextFieldVariant.negative:
        return OmsaIcons.ValidationErrorFilled;
      case OmsaTextFieldVariant.warning:
        return OmsaIcons.ValidationExclamationCircleFilled;
      case OmsaTextFieldVariant.information:
      case OmsaTextFieldVariant.none:
        return null;
    }
  }

  Color _getIconColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    switch (variant) {
      case OmsaTextFieldVariant.success:
        return isLight
            ? ComponentLightTokens.formBaseformStandardBorderSuccess
            : ComponentDarkTokens.formBaseformStandardBorderSuccess;
      case OmsaTextFieldVariant.negative:
        return isLight
            ? ComponentLightTokens.formBaseformStandardBorderNegative
            : ComponentDarkTokens.formBaseformStandardBorderNegative;
      case OmsaTextFieldVariant.warning:
        return isLight
            ? ComponentLightTokens.formBaseformStandardTextLabel
            : ComponentDarkTokens.formBaseformStandardTextLabel;
      case OmsaTextFieldVariant.information:
      case OmsaTextFieldVariant.none:
        return isLight
            ? ComponentLightTokens.formBaseformStandardTextLabel
            : ComponentDarkTokens.formBaseformStandardTextLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_icon != null) ...[
          _icon!(size: 16, color: _getIconColor(context)),
          const SizedBox(width: 4),
        ],
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: AppTypography.fontSizesSmall,
              height:
                  AppTypography.lineHeightsSmall / AppTypography.fontSizesSmall,
              color: _getIconColor(context),
              fontWeight: AppTypography.fontWeightsBody,
            ),
          ),
        ),
      ],
    );
  }
}
