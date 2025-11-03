import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/theme/app_dimensions.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/theme/app_typography.dart';
import 'package:omsa_design_system/components/inputs/input_panel/omsa_input_panel_colors.dart';
import 'package:omsa_design_system/components/inputs/input_panel/omsa_input_panel_dimensions.dart';

/// Size variants for input panels
enum OmsaInputPanelSize { medium, large }

/// Base widget for input panels (radio and checkbox variants)
///
/// This component provides the shared functionality for RadioPanel and CheckboxPanel,
/// including the container styling, selection state, hover effects, and layout.
class OmsaInputPanelBase extends StatefulWidget {
  const OmsaInputPanelBase({
    super.key,
    required this.title,
    required this.value,
    required this.checked,
    required this.onChanged,
    this.secondaryLabel,
    this.children,
    this.size = OmsaInputPanelSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.hideSelectionIndicator = false,
    this.disabled = false,
    this.selectionIndicator,
    this.expandOnSelected = false,
  });

  final Widget title;
  final String value;
  final bool checked;
  final ValueChanged<bool> onChanged;
  final Widget? secondaryLabel;
  final Widget? children;
  final OmsaInputPanelSize size;
  final OmsaComponentMode mode;
  final bool hideSelectionIndicator;
  final bool disabled;
  final Widget? selectionIndicator;

  /// Whether to animate expand/collapse of children based on checked state.
  /// When true, children are only shown when the panel is checked.
  /// When false (default), children are always shown if provided.
  final bool expandOnSelected;

  @override
  State<OmsaInputPanelBase> createState() => _OmsaInputPanelBaseState();
}

class _OmsaInputPanelBaseState extends State<OmsaInputPanelBase> {
  bool _isHovered = false;

  void _handleTap() {
    if (!widget.disabled) {
      widget.onChanged(!widget.checked);
    }
  }

  double get _minHeight => OmsaInputPanelDimensions.getMinHeight(widget.size);

  double get _minWidth => OmsaInputPanelDimensions.minWidth;

  TextStyle get _titleStyle {
    final baseStyle = widget.size == OmsaInputPanelSize.large
        ? AppTypography.textExtraLarge
        : AppTypography.textLarge;

    return baseStyle;
  }

  @override
  Widget build(BuildContext context) {
    final colors = OmsaInputPanelColors.fromContext(
      context,
      mode: widget.mode,
      disabled: widget.disabled,
    );

    final effectiveBackgroundColor = widget.disabled
        ? colors.backgroundDisabled
        : _isHovered
        ? colors.backgroundHover
        : widget.checked
        ? colors.backgroundSelected
        : colors.background;

    final effectiveBorderColor = widget.disabled
        ? colors.borderDisabled
        : widget.checked
        ? colors.borderSelected
        : colors.border;

    final effectiveTextColor = widget.disabled
        ? colors.textDisabled
        : colors.text;

    return MouseRegion(
      onEnter: widget.disabled
          ? null
          : (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: OmsaInputPanelDimensions.containerAnimationDurationMs,
          ),
          curve: Curves.easeInOut,
          constraints: BoxConstraints(
            minHeight: _minHeight,
            minWidth: _minWidth,
          ),
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            border: Border.all(
              color: effectiveBorderColor,
              width: AppDimensions.borderWidthsMedium,
            ),
            borderRadius: AppDimensions.borderRadiusMedium,
          ),
          padding: const EdgeInsets.all(AppSpacing.spaceMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: DefaultTextStyle(
                      style: _titleStyle.copyWith(color: effectiveTextColor),
                      child: widget.title,
                    ),
                  ),
                  if (widget.secondaryLabel != null) ...[
                    const SizedBox(width: AppSpacing.spaceSmall),
                    DefaultTextStyle(
                      style: AppTypography.textMedium.copyWith(
                        color: effectiveTextColor,
                      ),
                      child: widget.secondaryLabel!,
                    ),
                  ],
                  if (!widget.hideSelectionIndicator && !widget.disabled) ...[
                    const SizedBox(width: AppSpacing.spaceSmall),
                    if (widget.selectionIndicator != null)
                      widget.selectionIndicator!,
                  ],
                ],
              ),
              if (widget.children != null)
                widget.expandOnSelected
                    ? ClipRect(
                        child: AnimatedAlign(
                          duration: const Duration(
                            milliseconds: OmsaInputPanelDimensions
                                .expandAnimationDurationMs,
                          ),
                          curve: Curves.easeInOut,
                          heightFactor: widget.checked ? 1.0 : 0.0,
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: AppSpacing.spaceExtraSmall2,
                              ),
                              DefaultTextStyle(
                                style: AppTypography.textMedium.copyWith(
                                  color: effectiveTextColor,
                                ),
                                child: widget.children!,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSpacing.spaceExtraSmall2),
                          DefaultTextStyle(
                            style: AppTypography.textMedium.copyWith(
                              color: effectiveTextColor,
                            ),
                            child: widget.children!,
                          ),
                        ],
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
