import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/alert/omsa_alert_colors.dart';
import 'package:omsa_design_system/components/alert/omsa_base_alert_box.dart';

/// Small-sized alert box component matching React's SmallAlertBox
class OmsaSmallAlertBox extends StatelessWidget {
  const OmsaSmallAlertBox({
    super.key,
    required this.variant,
    required this.children,
    this.title,
    this.closable = false,
    this.closeButtonLabel = 'Lukk',
    this.onClose,
    this.mode = OmsaComponentMode.standard,
    this.width,
  });

  final OmsaAlertVariant variant;
  final Widget children;
  final Widget? title;
  final bool closable;
  final String closeButtonLabel;
  final VoidCallback? onClose;
  final OmsaComponentMode mode;
  final OmsaAlertWidth? width;

  @override
  Widget build(BuildContext context) {
    return OmsaBaseAlertBox(
      variant: variant,
      size: OmsaAlertSize.small,
      title: title,
      closable: closable,
      closeButtonLabel: closeButtonLabel,
      onClose: onClose,
      mode: mode,
      width: width,
      children: children,
    );
  }
}
