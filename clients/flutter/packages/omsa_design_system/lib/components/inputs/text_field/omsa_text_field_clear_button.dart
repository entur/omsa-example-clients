import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';

/// Clear button with divider for text field
class OmsaTextFieldClearButton extends StatelessWidget {
  const OmsaTextFieldClearButton({
    super.key,
    required this.onClear,
    required this.iconColor,
    this.dividerColor,
  });

  final VoidCallback onClear;
  final Color iconColor;
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 1,
          height: 24,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSmall),
          color: dividerColor ?? iconColor,
        ),
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          child: InkWell(
            onTap: onClear,
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.spaceExtraSmall),
              child: Icon(Icons.close, size: 16, color: iconColor),
            ),
          ),
        ),
      ],
    );
  }
}
