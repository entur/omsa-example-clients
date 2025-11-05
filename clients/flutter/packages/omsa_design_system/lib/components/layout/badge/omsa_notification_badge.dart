import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/layout/badge/omsa_badge.dart';
import 'package:omsa_design_system/components/layout/badge/omsa_badge_enums.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';

/// A notification badge variant for displaying counts
class OmsaNotificationBadge extends StatelessWidget {
  const OmsaNotificationBadge({
    super.key,
    required this.variant,
    required this.child,
    this.mode = OmsaComponentMode.standard,
    this.showZero = false,
    this.max = 99,
    this.hide = false,
  });

  final OmsaBadgeVariant variant;
  final dynamic child;
  final OmsaComponentMode mode;
  final bool showZero;
  final int max;
  final bool hide;

  @override
  Widget build(BuildContext context) {
    return OmsaBadge(
      variant: variant,
      mode: mode,
      type: OmsaBadgeType.notification,
      showZero: showZero,
      max: max,
      hide: hide,
      child: child,
    );
  }
}
