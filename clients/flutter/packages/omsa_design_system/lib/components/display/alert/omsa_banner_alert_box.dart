import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/display/alert/omsa_alert_colors.dart';
import 'package:omsa_design_system/components/display/alert/omsa_base_alert_box.dart';

/// Banner-sized alert box component matching React's BannerAlertBox
class OmsaBannerAlertBox extends StatelessWidget {
  const OmsaBannerAlertBox({
    super.key,
    required this.variant,
    required this.children,
    this.title,
    this.closable = false,
    this.closeButtonLabel = 'Lukk',
    this.onClose,
    this.mode = OmsaComponentMode.standard,
  });

  /// Color and expression variant of the alert box
  final OmsaAlertVariant variant;

  /// Content of the alert box
  final Widget children;

  /// Title of the alert box - summarize the effect
  final Widget? title;

  /// If true, the box will have a close button in the top right corner
  final bool closable;

  /// Screen reader label for the close button
  final String closeButtonLabel;

  /// Callback called when closing the box
  final VoidCallback? onClose;

  /// Component mode (standard or contrast)
  final OmsaComponentMode mode;

  @override
  Widget build(BuildContext context) {
    return OmsaBaseAlertBox(
      variant: variant,
      size: OmsaAlertSize.banner,
      title: title,
      closable: closable,
      closeButtonLabel: closeButtonLabel,
      onClose: onClose,
      mode: mode,
      children: children,
    );
  }
}
