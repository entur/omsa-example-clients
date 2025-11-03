import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/inputs/input_panel/omsa_input_panel_base.dart';
import 'package:omsa_design_system/components/inputs/omsa_radio.dart';

/// A radio panel component that displays a selectable card-style option
/// Used for single-value selection. If you need multi-selection, use the OmsaCheckboxPanel instead.
class OmsaRadioPanel<T> extends StatelessWidget {
  const OmsaRadioPanel({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.secondaryLabel,
    this.children,
    this.size = OmsaInputPanelSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.hideRadioButton = false,
    this.disabled = false,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Widget title;
  final Widget? secondaryLabel;
  final Widget? children;
  final OmsaInputPanelSize size;
  final OmsaComponentMode mode;
  final bool hideRadioButton;
  final bool disabled;

  bool get _isChecked => value == groupValue;

  void _handleChanged(bool checked) {
    if (onChanged != null && checked) {
      onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OmsaInputPanelBase(
      title: title,
      value: value.toString(),
      checked: _isChecked,
      onChanged: _handleChanged,
      secondaryLabel: secondaryLabel,
      size: size,
      mode: mode,
      hideSelectionIndicator: hideRadioButton,
      disabled: disabled,
      selectionIndicator: IgnorePointer(
        child: OmsaRadio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: null,
          mode: mode,
          disabled: disabled,
        ),
      ),
      children: children,
    );
  }
}
