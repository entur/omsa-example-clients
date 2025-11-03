import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/inputs/input_panel/omsa_input_panel_base.dart';
import 'package:omsa_design_system/components/inputs/input_panel/omsa_radio_panel.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/theme/app_typography.dart';

/// Data model for a radio panel option
class OmsaRadioPanelOption<T> {
  const OmsaRadioPanelOption({
    required this.value,
    required this.title,
    this.secondaryLabel,
    this.children,
    this.expandOnSelected = false,
  });

  final T value;
  final Widget title;
  final Widget? secondaryLabel;
  final Widget? children;
  final bool expandOnSelected;
}

/// A radio panel group component for managing multiple radio panels
class OmsaRadioPanelGroup<T> extends StatelessWidget {
  const OmsaRadioPanelGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.options,
    this.label,
    this.size = OmsaInputPanelSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.spacing,
    this.disabled = false,
    this.expandOnSelected = false,
  });

  final T? value;
  final ValueChanged<T?>? onChanged;
  final List<OmsaRadioPanelOption<T>> options;
  final Widget? label;
  final OmsaInputPanelSize size;
  final OmsaComponentMode mode;
  final double? spacing;
  final bool disabled;

  /// Whether to animate expand/collapse of children based on checked state.
  /// When true, children are only shown when the panel is checked.
  /// When false (default), children are always shown if provided.
  /// This applies to all options unless overridden per option.
  final bool expandOnSelected;

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
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OmsaRadioPanel<T>(
                value: option.value,
                groupValue: value,
                onChanged: onChanged,
                title: option.title,
                secondaryLabel: option.secondaryLabel,
                size: size,
                mode: mode,
                disabled: disabled,
                expandOnSelected: option.expandOnSelected || expandOnSelected,
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
