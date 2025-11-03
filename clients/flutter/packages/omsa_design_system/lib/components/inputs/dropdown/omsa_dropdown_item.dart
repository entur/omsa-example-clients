import 'package:flutter/material.dart';

class OmsaDropdownItem<T> {
  const OmsaDropdownItem({
    required this.value,
    required this.label,
    this.icons,
  });

  final T value;
  final String label;
  final List<Widget>? icons;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OmsaDropdownItem<T> &&
        other.value == value &&
        other.label == label;
  }

  @override
  int get hashCode => Object.hash(value, label);

  @override
  String toString() => label;
}