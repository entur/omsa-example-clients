import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/inputs/input_panel/omsa_input_panel_base.dart';
import 'package:omsa_design_system/components/inputs/input_panel/omsa_checkbox_panel.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/theme/app_typography.dart';

/// Data model for a checkbox panel option
class OmsaCheckboxPanelOption {
  const OmsaCheckboxPanelOption({
    required this.value,
    required this.title,
    this.secondaryLabel,
    this.children,
  });

  final String value;
  final Widget title;
  final Widget? secondaryLabel;
  final Widget? children;
}

/// A checkbox panel group component for managing multiple checkbox panels
class OmsaCheckboxPanelGroup extends StatelessWidget {
  const OmsaCheckboxPanelGroup({
    super.key,
    required this.values,
    required this.onChanged,
    required this.options,
    this.label,
    this.size = OmsaInputPanelSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.spacing,
    this.disabled = false,
  });

  final List<String> values;
  final ValueChanged<List<String>>? onChanged;
  final List<OmsaCheckboxPanelOption> options;
  final Widget? label;
  final OmsaInputPanelSize size;
  final OmsaComponentMode mode;
  final double? spacing;
  final bool disabled;

  void _handleChanged(String value, bool checked) {
    if (onChanged == null) return;

    final newValues = List<String>.from(values);
    if (checked) {
      if (!newValues.contains(value)) {
        newValues.add(value);
      }
    } else {
      newValues.remove(value);
    }
    onChanged!(newValues);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveSpacing = spacing ?? AppSpacing.spaceDefault;

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
        ...options.map((option) {
          final isLast = options.last == option;
          final isChecked = values.contains(option.value);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OmsaCheckboxPanel(
                value: option.value,
                checked: isChecked,
                onChanged: (checked) => _handleChanged(option.value, checked),
                title: option.title,
                secondaryLabel: option.secondaryLabel,
                size: size,
                mode: mode,
                disabled: disabled,
                children: option.children,
              ),
              if (!isLast) SizedBox(height: effectiveSpacing),
            ],
          );
        }),
      ],
    );
  }
}
