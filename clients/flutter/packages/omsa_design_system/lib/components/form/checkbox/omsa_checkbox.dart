import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/form/checkbox/omsa_checkbox_colors.dart';
import 'package:omsa_design_system/components/form/checkbox/omsa_checkbox_dimensions.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/theme/app_dimensions.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/theme/app_typography.dart';
import 'package:omsa_icons/omsa_icons.dart';

/// A checkbox component following OMSA Design System guidelines
class OmsaCheckbox extends StatefulWidget {
  const OmsaCheckbox({
    super.key,
    required this.checked,
    required this.onChanged,
    this.label,
    this.mode = OmsaComponentMode.standard,
    this.disabled = false,
    this.readOnly = false,
    this.tristate = false,
  });

  /// Whether the checkbox is checked, unchecked, or null (indeterminate if tristate is true)
  final bool? checked;

  /// Callback when checkbox state changes
  final ValueChanged<bool?>? onChanged;

  /// Optional label displayed next to the checkbox
  final Widget? label;

  /// Component mode (standard or contrast)
  final OmsaComponentMode mode;

  /// Whether the checkbox is disabled
  final bool disabled;

  /// Whether the checkbox is read-only
  final bool readOnly;

  /// If true, allows the checkbox to have a third, indeterminate state
  final bool tristate;

  @override
  State<OmsaCheckbox> createState() => _OmsaCheckboxState();
}

class _OmsaCheckboxState extends State<OmsaCheckbox> {
  bool _isHovered = false;
  bool _isFocused = false;

  void _handleTap() {
    if (!widget.disabled && !widget.readOnly && widget.onChanged != null) {
      if (widget.tristate) {
        // Cycle through null -> false -> true -> null
        if (widget.checked == null) {
          widget.onChanged!(false);
        } else if (widget.checked == false) {
          widget.onChanged!(true);
        } else {
          widget.onChanged!(null);
        }
      } else {
        widget.onChanged!(!(widget.checked ?? false));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = OmsaCheckboxColors.fromContext(context, mode: widget.mode);

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
          margin: const EdgeInsets.symmetric(
            vertical: AppSpacing.spaceExtraSmall,
          ),
          constraints: const BoxConstraints(
            minHeight: OmsaCheckboxDimensions.containerMinHeight,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Focus(
                onFocusChange: (focused) =>
                    setState(() => _isFocused = focused),
                child: _CheckboxIndicator(
                  checked: widget.checked,
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

/// Internal checkbox indicator widget
class _CheckboxIndicator extends StatelessWidget {
  const _CheckboxIndicator({
    required this.checked,
    required this.colors,
    required this.isHovered,
    required this.isFocused,
    required this.disabled,
    required this.readOnly,
  });

  final bool? checked;
  final OmsaCheckboxColors colors;
  final bool isHovered;
  final bool isFocused;
  final bool disabled;
  final bool readOnly;

  bool get _isChecked => checked == true;
  bool get _isIndeterminate => checked == null;

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = disabled
        ? colors.backgroundDisabled
        : _isChecked || _isIndeterminate
        ? (isHovered && !readOnly
              ? colors.backgroundSelectedHover
              : colors.backgroundSelected)
        : (isHovered && !readOnly ? colors.backgroundHover : colors.background);

    final effectiveBorderColor = disabled
        ? colors.borderDisabled
        : (_isChecked || _isIndeterminate)
        ? Colors.transparent
        : colors.border;

    final effectiveIconColor = disabled ? colors.iconDisabled : colors.icon;

    return AnimatedContainer(
      duration: const Duration(
        milliseconds: OmsaCheckboxDimensions.animationDurationMs,
      ),
      curve: Curves.easeInOut,
      width: OmsaCheckboxDimensions.indicatorWidth,
      height: OmsaCheckboxDimensions.indicatorHeight,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: Border.all(
          color: effectiveBorderColor,
          width: AppDimensions.borderWidthsDefault,
        ),
        borderRadius: BorderRadius.circular(
          AppDimensions.borderRadiusesMedium / 2,
        ),
      ),
      child: _isChecked
          ? OmsaIcons.Check(
              size: OmsaCheckboxDimensions.checkIconSize,
              color: effectiveIconColor,
            )
          : _isIndeterminate
          ? Center(
              child: Container(
                width: OmsaCheckboxDimensions.indeterminateBarWidth,
                height: OmsaCheckboxDimensions.indeterminateBarHeight,
                color: effectiveIconColor,
              ),
            )
          : null,
    );
  }
}
