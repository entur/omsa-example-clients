import 'package:flutter/material.dart';

/// A customizable dropdown component following OMSA Design System guidelines
///
/// This component extends Flutter's [DropdownButtonFormField] to provide
/// a consistent dropdown experience with OMSA theming and styling.
class OmsaDropdown<T> extends StatelessWidget {
  const OmsaDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.validator,
    this.enabled = true,
    this.icon,
    this.isDense = false,
  });

  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? Function(T?)? validator;
  final bool enabled;
  final Widget? icon;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: enabled ? onChanged : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        errorText: errorText,
        enabled: enabled,
        border: const OutlineInputBorder(),
        isDense: isDense,
      ),
      validator: validator,
      icon: icon,
      isExpanded: true,
    );
  }
}
