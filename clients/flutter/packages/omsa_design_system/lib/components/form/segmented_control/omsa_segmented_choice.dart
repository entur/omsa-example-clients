import 'package:flutter/widgets.dart';

/// Individual choice used inside [OmsaSegmentedControl].
class OmsaSegmentedChoice extends StatelessWidget {
  const OmsaSegmentedChoice({
    super.key,
    required this.value,
    required this.child,
    this.onChanged,
  });

  /// Value emitted when this choice is selected.
  final String value;

  /// Visual contents of the choice.
  final Widget child;

  /// Optional callback fired when this choice is selected.
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) => child;
}
