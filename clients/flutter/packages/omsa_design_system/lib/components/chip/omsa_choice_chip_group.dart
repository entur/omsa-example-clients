import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/chip/omsa_choice_chip.dart';

/// ChoiceChipGroup component matching React's ChoiceChipGroup
/// A group wrapper for ChoiceChips providing radio group behavior
class OmsaChoiceChipGroup extends StatelessWidget {
  const OmsaChoiceChipGroup({
    super.key,
    required this.children,
    required this.value,
    required this.onChanged,
    this.label,
    this.mode = OmsaComponentMode.standard,
    this.spacing = 12.0,
  });

  final List<OmsaChoiceChip> children;
  final String? value;
  final ValueChanged<String> onChanged;
  final Widget? label;
  final OmsaComponentMode mode;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final List<Widget> chipWidgets = children.map((chip) {
      return OmsaChoiceChip(
        key: chip.key,
        label: chip.label,
        value: chip.value,
        groupValue: value,
        onSelected: onChanged,
        size: chip.size,
        mode: mode,
        disabled: chip.disabled,
        leadingIcon: chip.leadingIcon,
        trailingIcon: chip.trailingIcon,
        focusNode: chip.focusNode,
        autofocus: chip.autofocus,
        semanticsLabel: chip.semanticsLabel,
      );
    }).toList();

    final Widget chipsRow = Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: chipWidgets,
    );

    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.labelMedium ?? const TextStyle(),
            child: label!,
          ),
          const SizedBox(height: 8.0),
          chipsRow,
        ],
      );
    }

    return chipsRow;
  }
}
