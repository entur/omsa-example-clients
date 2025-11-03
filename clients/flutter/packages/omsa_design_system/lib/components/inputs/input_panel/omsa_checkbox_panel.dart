import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/inputs/input_panel/omsa_input_panel_base.dart';
import 'package:omsa_design_system/components/inputs/omsa_checkbox.dart';

/// A checkbox panel component that displays a selectable card-style option
/// Used for multi-selection. If you need single-value selection, use the OmsaRadioPanel instead.
class OmsaCheckboxPanel extends StatelessWidget {
  const OmsaCheckboxPanel({
    super.key,
    required this.value,
    required this.checked,
    required this.onChanged,
    required this.title,
    this.secondaryLabel,
    this.children,
    this.size = OmsaInputPanelSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.hideCheckbox = false,
    this.disabled = false,
    this.expandOnSelected = false,
  });

  final String value;
  final bool checked;
  final ValueChanged<bool>? onChanged;
  final Widget title;
  final Widget? secondaryLabel;
  final Widget? children;
  final OmsaInputPanelSize size;
  final OmsaComponentMode mode;
  final bool hideCheckbox;
  final bool disabled;
  final bool expandOnSelected;

  void _handleChanged(bool newChecked) {
    onChanged?.call(newChecked);
  }

  @override
  Widget build(BuildContext context) {
    return OmsaInputPanelBase(
      title: title,
      value: value,
      checked: checked,
      onChanged: _handleChanged,
      secondaryLabel: secondaryLabel,
      size: size,
      mode: mode,
      hideSelectionIndicator: hideCheckbox,
      disabled: disabled,
      expandOnSelected: expandOnSelected,
      selectionIndicator: IgnorePointer(
        child: OmsaCheckbox(
          checked: checked,
          onChanged: null,
          mode: mode,
          disabled: disabled,
        ),
      ),
      children: children,
    );
  }
}
