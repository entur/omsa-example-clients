import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';

class OmsaRadioGroupDimensions {
  OmsaRadioGroupDimensions._();

  /// Spacing when label is present
  static const double labelSpacing = AppSpacing.spaceExtraSmall;
}

/// A radio group component that provides layout for a group of radio buttons
class OmsaRadioGroup<T> extends StatelessWidget {
  const OmsaRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.children,
    this.label,
  });

  final T? value;
  final ValueChanged<T?>? onChanged;
  final List<Widget> children;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          label!,
          const SizedBox(height: OmsaRadioGroupDimensions.labelSpacing),
        ],
        ...children,
      ],
    );
  }
}
