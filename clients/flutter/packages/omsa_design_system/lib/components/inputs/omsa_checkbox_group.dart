import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/theme/app_typography.dart';

/// A checkbox group component for managing multiple checkboxes
class OmsaCheckboxGroup extends StatelessWidget {
  const OmsaCheckboxGroup({
    super.key,
    required this.children,
    this.label,
    this.spacing,
  });

  final List<Widget> children;
  final Widget? label;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    final effectiveSpacing = spacing ?? AppSpacing.spaceExtraSmall;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          DefaultTextStyle(
            style: AppTypography.textLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
            child: label!,
          ),
          SizedBox(height: effectiveSpacing),
        ],
        ...children.map((child) {
          final isLast = children.last == child;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              child,
              if (!isLast) SizedBox(height: effectiveSpacing),
            ],
          );
        }),
      ],
    );
  }
}
