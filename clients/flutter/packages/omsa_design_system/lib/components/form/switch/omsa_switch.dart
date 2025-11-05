import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/form/switch/omsa_switch_colors.dart';
import 'package:omsa_design_system/components/form/switch/omsa_switch_dimensions.dart';

enum OmsaSwitchSize { medium, large }

enum OmsaSwitchLabelPlacement { right, bottom }

/// A Material Design switch component with support for custom icons and labels.
/// Matches the API of the React Switch component from @entur/form.
class OmsaSwitch extends StatelessWidget {
  const OmsaSwitch({
    super.key,
    this.checked = false,
    this.onChanged,
    this.icon,
    this.hideIcon = false,
    this.size = OmsaSwitchSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.labelPlacement = OmsaSwitchLabelPlacement.right,
    this.label,
    this.disabled = false,
  });

  final bool checked;
  final ValueChanged<bool>? onChanged;
  final Widget? icon;
  final bool hideIcon;
  final OmsaSwitchSize size;
  final OmsaComponentMode mode;
  final OmsaSwitchLabelPlacement labelPlacement;
  final Widget? label;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final colors = OmsaSwitchColors.fromContext(context, mode: mode);
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

    final switchWidget = MouseRegion(
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
                    child: hideIcon
                        ? null
                        : Center(
                            child: icon ?? _buildDefaultIcon(colors, iconSize),
                          ),
                  ),
                ),
              ],
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

  Widget _buildDefaultIcon(OmsaSwitchColors colors, double iconSize) {
    return Icon(
      checked ? Icons.check : Icons.close,
      size: iconSize,
      color: checked ? colors.iconColorTrue : colors.iconColorFalse,
    );
  }
}
