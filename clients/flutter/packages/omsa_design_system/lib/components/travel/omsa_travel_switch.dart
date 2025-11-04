import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/inputs/switch/omsa_switch.dart';
import 'package:omsa_design_system/components/inputs/switch/omsa_switch_dimensions.dart';
import 'package:omsa_design_system/components/travel/transport_utils.dart';
import 'package:omsa_design_system/components/travel/travel_switch_colors.dart';

/// A specialized switch component for transport modes with transport-specific
/// icons and colors. Matches the API of the React TravelSwitch component
/// from @entur/travel.
class OmsaTravelSwitch extends StatelessWidget {
  const OmsaTravelSwitch({
    super.key,
    required this.transport,
    this.checked = false,
    this.onChanged,
    this.size = OmsaSwitchSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.labelPlacement = OmsaSwitchLabelPlacement.right,
    this.label,
    this.disabled = false,
  });

  final Transport transport;
  final bool checked;
  final ValueChanged<bool>? onChanged;
  final OmsaSwitchSize size;
  final OmsaComponentMode mode;
  final OmsaSwitchLabelPlacement labelPlacement;
  final Widget? label;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final transportStyle = getTransportStyle(transport);
    final colors = TravelSwitchColors.fromTransport(context, transport, mode);

    final trackWidth = size == OmsaSwitchSize.large
        ? OmsaSwitchDimensions.largeTrackWidth
        : OmsaSwitchDimensions.mediumTrackWidth;
    final trackHeight = size == OmsaSwitchSize.large
        ? OmsaSwitchDimensions.largeTrackHeight
        : OmsaSwitchDimensions.mediumTrackHeight;
    final thumbSize = size == OmsaSwitchSize.large
        ? OmsaSwitchDimensions.largeThumbSize
        : OmsaSwitchDimensions.mediumThumbSize;
    final iconSize = size == OmsaSwitchSize.large
        ? OmsaSwitchDimensions.largeIconSize
        : OmsaSwitchDimensions.mediumIconSize;

    final switchWidget = Semantics(
      label: transportStyle.ariaLabel,
      child: MouseRegion(
        cursor: disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: GestureDetector(
          onTap: disabled ? null : () => onChanged?.call(!checked),
          child: Opacity(
            opacity: disabled ? 0.5 : 1.0,
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: OmsaSwitchDimensions.animationDurationMs,
              ),
              width: trackWidth,
              height: trackHeight,
              decoration: BoxDecoration(
                color: checked ? colors.trackColorTrue : colors.trackColorFalse,
                borderRadius: BorderRadius.circular(trackHeight / 2),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(
                      milliseconds: OmsaSwitchDimensions.animationDurationMs,
                    ),
                    curve: Curves.easeInOut,
                    left: checked
                        ? trackWidth -
                              thumbSize -
                              OmsaSwitchDimensions.thumbPadding
                        : OmsaSwitchDimensions.thumbPadding,
                    top: OmsaSwitchDimensions.thumbPadding,
                    child: Container(
                      width: thumbSize,
                      height: thumbSize,
                      decoration: BoxDecoration(
                        color: colors.thumbColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: transportStyle.icon(
                          size: iconSize,
                          color: colors.iconColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (label == null) {
      return switchWidget;
    }

    if (labelPlacement == OmsaSwitchLabelPlacement.bottom) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          switchWidget,
          const SizedBox(height: OmsaSwitchDimensions.bottomLabelSpacing),
          DefaultTextStyle(
            style: TextStyle(color: colors.textColor),
            child: label!,
          ),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        switchWidget,
        const SizedBox(width: OmsaSwitchDimensions.labelSpacing),
        DefaultTextStyle(
          style: TextStyle(color: colors.textColor),
          child: label!,
        ),
      ],
    );
  }
}
