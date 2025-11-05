import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/form/radio/omsa_radio_colors.dart';
import 'package:omsa_design_system/components/form/radio/omsa_radio_dimensions.dart';
import 'package:omsa_design_system/theme/app_dimensions.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/theme/app_typography.dart';

/// A radio button component following the Linje design system
class OmsaRadio<T> extends StatefulWidget {
  const OmsaRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.mode = OmsaComponentMode.standard,
    this.disabled = false,
    this.readOnly = false,
  });

  /// The value represented by this radio button
  final T value;

  /// The currently selected value in the radio group
  final T? groupValue;

  /// Callback when this radio button is selected
  final ValueChanged<T?>? onChanged;

  /// Optional label displayed next to the radio button
  final Widget? label;

  /// Component mode (standard or contrast)
  final OmsaComponentMode mode;

  /// Whether the radio button is disabled
  final bool disabled;

  /// Whether the radio button is read-only
  final bool readOnly;

  @override
  State<OmsaRadio<T>> createState() => _OmsaRadioState<T>();
}

class _OmsaRadioState<T> extends State<OmsaRadio<T>> {
  bool _isHovered = false;
  bool _isFocused = false;

  bool get _isChecked => widget.value == widget.groupValue;

  void _handleTap() {
    if (!widget.disabled && !widget.readOnly && widget.onChanged != null) {
      widget.onChanged!(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = OmsaRadioColors.fromContext(context, mode: widget.mode);

    return MouseRegion(
      onEnter: widget.disabled || widget.readOnly
          ? null
          : (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.disabled
          ? SystemMouseCursors.forbidden
          : widget.readOnly
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          height: AppSpacing.spaceExtraLarge,
          constraints: const BoxConstraints(
            minHeight: OmsaRadioDimensions.containerMinHeight,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Focus(
                onFocusChange: (focused) =>
                    setState(() => _isFocused = focused),
                child: _RadioIndicator(
                  checked: _isChecked,
                  colors: colors,
                  isHovered: _isHovered,
                  isFocused: _isFocused,
                  disabled: widget.disabled,
                  readOnly: widget.readOnly,
                ),
              ),
              if (widget.label != null) ...[
                const SizedBox(width: AppSpacing.spaceDefault),
                Flexible(
                  child: DefaultTextStyle(
                    style: AppTypography.textMedium.copyWith(
                      color: widget.disabled
                          ? colors.textDisabled
                          : colors.text,
                    ),
                    child: widget.label!,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Internal radio indicator widget
class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({
    required this.checked,
    required this.colors,
    required this.isHovered,
    required this.isFocused,
    required this.disabled,
    required this.readOnly,
  });

  final bool checked;
  final OmsaRadioColors colors;
  final bool isHovered;
  final bool isFocused;
  final bool disabled;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = disabled
        ? colors.backgroundDisabled
        : isHovered && !readOnly
        ? colors.backgroundHover
        : colors.background;

    final effectiveBorderColor = disabled
        ? colors.borderDisabled
        : colors.border;

    final effectiveIconColor = disabled ? colors.iconDisabled : colors.icon;

    return Container(
      width: OmsaRadioDimensions.indicatorWidth,
      height: OmsaRadioDimensions.indicatorHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: effectiveBackgroundColor,
        border: Border.all(
          color: effectiveBorderColor,
          width: AppDimensions.borderWidthsMedium,
        ),
      ),
      child: checked
          ? Center(
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: OmsaRadioDimensions.animationDurationMs,
                ),
                curve: Curves.easeInOut,
                width: OmsaRadioDimensions.innerCircleWidth,
                height: OmsaRadioDimensions.innerCircleHeight,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: effectiveIconColor,
                ),
              ),
            )
          : null,
    );
  }
}
