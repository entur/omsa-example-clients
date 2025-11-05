import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/layout/badge/omsa_badge.dart';
import 'package:omsa_design_system/components/layout/badge/omsa_badge_enums.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';

/// A status badge variant for displaying status information
class OmsaStatusBadge extends StatelessWidget {
  const OmsaStatusBadge({
    super.key,
    required this.variant,
    required this.child,
    this.mode = OmsaComponentMode.standard,
    this.hide = false,
  });

  final OmsaBadgeVariant variant;
  final dynamic child;
  final OmsaComponentMode mode;
  final bool hide;

  @override
  Widget build(BuildContext context) {
    return OmsaBadge(
      variant: variant,
      mode: mode,
      type: OmsaBadgeType.status,
      hide: hide,
      child: child,
    );
  }
}
