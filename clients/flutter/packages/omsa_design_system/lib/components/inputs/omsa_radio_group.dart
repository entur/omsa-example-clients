import 'package:flutter/material.dart';

/// Context for managing radio group state
class OmsaRadioGroupContext<T> extends InheritedWidget {
  const OmsaRadioGroupContext({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required super.child,
  });

  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  static OmsaRadioGroupContext<T>? maybeOf<T>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OmsaRadioGroupContext<T>>();
  }

  static OmsaRadioGroupContext<T> of<T>(BuildContext context) {
    final result = maybeOf<T>(context);
    assert(result != null, 'No OmsaRadioGroupContext found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(OmsaRadioGroupContext<T> oldWidget) {
    return groupValue != oldWidget.groupValue ||
        onChanged != oldWidget.onChanged;
  }
}

/// A radio group component that manages a group of radio buttons
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
    return OmsaRadioGroupContext<T>(
      groupValue: value,
      onChanged: onChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) ...[label!, const SizedBox(height: 8)],
          ...children,
        ],
      ),
    );
  }
}
