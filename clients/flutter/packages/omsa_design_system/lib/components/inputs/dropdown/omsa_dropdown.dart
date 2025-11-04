import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/inputs/text_field/omsa_text_field.dart';
import 'package:omsa_design_system/components/inputs/text_field/omsa_text_field_colors.dart';
import 'package:omsa_design_system/components/inputs/text_field/omsa_text_field_decoration.dart';
import 'package:omsa_design_system/components/inputs/text_field/omsa_text_field_dimensions.dart';
import 'package:omsa_design_system/components/inputs/text_field/omsa_text_field_feedback.dart';
import 'package:omsa_design_system/components/inputs/dropdown/omsa_dropdown_item.dart';
import 'package:omsa_design_system/components/inputs/dropdown/omsa_dropdown_list.dart';

enum OmsaDropdownVariant { none, success, negative, information, warning }

enum OmsaDropdownSize { medium, large }

class OmsaDropdown<T> extends StatefulWidget {
  const OmsaDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChange,
    required this.label,
    this.placeholder,
    this.clearable = false,
    this.disabled = false,
    this.readOnly = false,
    this.variant = OmsaDropdownVariant.none,
    this.size = OmsaDropdownSize.medium,
    this.feedback,
    this.prepend,
    this.loading = false,
    this.loadingText = 'Loading...',
    this.noMatchesText = 'No matches',
    this.disableLabelAnimation = false,
    this.required = false,
    this.mode = OmsaComponentMode.standard,
  });

  final List<OmsaDropdownItem<T>> items;
  final OmsaDropdownItem<T>? selectedItem;
  final ValueChanged<OmsaDropdownItem<T>?> onChange;
  final String label;
  final String? placeholder;
  final bool clearable;
  final bool disabled;
  final bool readOnly;
  final OmsaDropdownVariant variant;
  final OmsaDropdownSize size;
  final String? feedback;
  final Widget? prepend;
  final bool loading;
  final String loadingText;
  final String noMatchesText;
  final bool disableLabelAnimation;
  final bool required;
  final OmsaComponentMode mode;

  @override
  State<OmsaDropdown<T>> createState() => _OmsaDropdownState<T>();
}

class _OmsaDropdownState<T> extends State<OmsaDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  bool _isFocused = false;
  bool _isHovered = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    if (!_isFocused && _isOpen) {
      _closeDropdown();
    }
  }

  bool get _hasValue {
    return widget.selectedItem != null;
  }

  bool get _shouldFloatLabel {
    return widget.disableLabelAnimation ||
        _isFocused ||
        _hasValue ||
        widget.placeholder != null;
  }

  bool get _showPlaceholder {
    return !_hasValue && widget.placeholder != null;
  }

  void _toggleDropdown() {
    if (widget.disabled || widget.readOnly) return;

    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    if (widget.disabled || widget.readOnly) return;

    setState(() => _isOpen = true);
    _focusNode.requestFocus();

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    setState(() => _isOpen = false);
    _removeOverlay();
    _focusNode.unfocus();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OmsaTextFieldVariant _mapVariant() {
    switch (widget.variant) {
      case OmsaDropdownVariant.success:
        return OmsaTextFieldVariant.success;
      case OmsaDropdownVariant.negative:
        return OmsaTextFieldVariant.negative;
      case OmsaDropdownVariant.information:
        return OmsaTextFieldVariant.information;
      case OmsaDropdownVariant.warning:
        return OmsaTextFieldVariant.warning;
      case OmsaDropdownVariant.none:
        return OmsaTextFieldVariant.none;
    }
  }

  OmsaTextFieldSize _mapSize() {
    switch (widget.size) {
      case OmsaDropdownSize.medium:
        return OmsaTextFieldSize.medium;
      case OmsaDropdownSize.large:
        return OmsaTextFieldSize.large;
    }
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final colors = OmsaTextFieldColors.fromContext(
      context,
      mode: widget.mode,
      variant: _mapVariant(),
      disabled: widget.disabled,
      readOnly: widget.readOnly,
      isFocused: _isFocused,
      isHovered: _isHovered,
    );

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _closeDropdown,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + AppSpacing.spaceExtraSmall2),
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {},
                  child: OmsaDropdownList<T>(
                    items: widget.items,
                    selectedItem: widget.selectedItem,
                    onItemSelected: _onItemSelected,
                    colors: colors,
                    isLoading: widget.loading,
                    loadingText: widget.loadingText,
                    noMatchesText: widget.noMatchesText,
                    mode: widget.mode,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onItemSelected(OmsaDropdownItem<T> item) {
    widget.onChange(item);
    _closeDropdown();
  }

  void _onClear() {
    widget.onChange(null);
  }

  @override
  Widget build(BuildContext context) {
    final textFieldSize = _mapSize();
    final textFieldVariant = _mapVariant();

    final colors = OmsaTextFieldColors.fromContext(
      context,
      mode: widget.mode,
      variant: textFieldVariant,
      disabled: widget.disabled,
      readOnly: widget.readOnly,
      isFocused: _isFocused,
      isHovered: _isHovered,
    );

    final minHeight = OmsaTextFieldDecorationBuilder.getMinHeight(
      textFieldSize,
    );
    final containerDecoration =
        OmsaTextFieldDecorationBuilder.buildContainerDecoration(
          colors: colors,
          isFocused: _isFocused,
        );
    final textStyle = OmsaTextFieldDecorationBuilder.getTextStyle(
      colors: colors,
      size: textFieldSize,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: Focus(
            focusNode: _focusNode,
            onKeyEvent: (node, event) {
              if (event.logicalKey == LogicalKeyboardKey.escape && _isOpen) {
                _closeDropdown();
                return KeyEventResult.handled;
              } else if (event.logicalKey == LogicalKeyboardKey.enter ||
                  event.logicalKey == LogicalKeyboardKey.space) {
                _toggleDropdown();
                return KeyEventResult.handled;
              }
              return KeyEventResult.ignored;
            },
            child: MouseRegion(
              onEnter: widget.disabled || widget.readOnly
                  ? null
                  : (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              cursor: widget.disabled || widget.readOnly
                  ? SystemMouseCursors.basic
                  : SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _toggleDropdown,
                child: Container(
                  constraints: BoxConstraints(minHeight: minHeight),
                  decoration: containerDecoration,
                  child: _buildFieldContent(
                    minHeight: minHeight,
                    colors: colors,
                    textStyle: textStyle,
                    textFieldSize: textFieldSize,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (widget.feedback != null) ...[
          const SizedBox(height: AppSpacing.spaceExtraSmall2),
          OmsaTextFieldFeedback(
            text: widget.feedback!,
            variant: textFieldVariant,
          ),
        ],
      ],
    );
  }

  Widget _buildFieldContent({
    required double minHeight,
    required OmsaTextFieldColors colors,
    required TextStyle textStyle,
    required OmsaTextFieldSize textFieldSize,
  }) {
    return Stack(
      children: [
        _FloatingLabel(
          label: widget.label,
          required: widget.required,
          shouldFloat: _shouldFloatLabel,
          size: textFieldSize,
          colors: colors,
          hasPrepend: widget.prepend != null,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spaceDefault,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.prepend != null)
                  _PrependWrapper(
                    colors: colors,
                    size: textFieldSize,
                    child: widget.prepend!,
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: OmsaTextFieldDecorationBuilder.getContentPadding(
                        textFieldSize,
                      ).top,
                      bottom: AppSpacing.spaceExtraSmall2,
                    ),
                    child: _hasValue
                        ? Text(widget.selectedItem!.label, style: textStyle)
                        : _showPlaceholder
                        ? Text(widget.placeholder!, style: textStyle)
                        : const SizedBox.shrink(),
                  ),
                ),
                _DropdownAppendix(
                  isOpen: _isOpen,
                  clearable: widget.clearable,
                  hasSelection: _hasValue,
                  disabled: widget.disabled,
                  iconColor: colors.icon,
                  onClear: _onClear,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FloatingLabel extends StatelessWidget {
  const _FloatingLabel({
    required this.label,
    required this.required,
    required this.shouldFloat,
    required this.size,
    required this.colors,
    required this.hasPrepend,
  });

  final String label;
  final bool required;
  final bool shouldFloat;
  final OmsaTextFieldSize size;
  final OmsaTextFieldColors colors;
  final bool hasPrepend;

  @override
  Widget build(BuildContext context) {
    final labelTop = OmsaTextFieldDecorationBuilder.getLabelTop(
      size: size,
      shouldFloat: shouldFloat,
    );
    final labelStyle = OmsaTextFieldDecorationBuilder.getLabelStyle(
      colors: colors,
      size: size,
      shouldFloat: shouldFloat,
    );

    final leftOffset =
        AppSpacing.spaceDefault +
        (hasPrepend
            ? OmsaTextFieldDimensions.prependWidgetSize + AppSpacing.spaceSmall
            : 0);

    return AnimatedPositioned(
      duration: const Duration(
        milliseconds: OmsaTextFieldDimensions.animationDurationMs,
      ),
      curve: Curves.easeInOut,
      left: leftOffset,
      top: labelTop,
      child: IgnorePointer(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(
            milliseconds: OmsaTextFieldDimensions.animationDurationMs,
          ),
          curve: Curves.easeInOut,
          style: labelStyle,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label),
              if (required) ...[
                const SizedBox(
                  width: OmsaTextFieldDimensions.labelRequiredSpacing,
                ),
                const Text('*'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PrependWrapper extends StatelessWidget {
  const _PrependWrapper({
    required this.colors,
    required this.size,
    required this.child,
  });

  final OmsaTextFieldColors colors;
  final OmsaTextFieldSize size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textStyle = OmsaTextFieldDecorationBuilder.getTextStyle(
      colors: colors,
      size: size,
    );

    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.spaceSmall),
      child: IconTheme(
        data: IconThemeData(
          color: colors.icon,
          size: OmsaTextFieldDimensions.iconSize,
        ),
        child: DefaultTextStyle(
          style: textStyle.copyWith(color: colors.icon),
          child: child,
        ),
      ),
    );
  }
}

class _DropdownAppendix extends StatelessWidget {
  const _DropdownAppendix({
    required this.isOpen,
    required this.clearable,
    required this.hasSelection,
    required this.disabled,
    required this.iconColor,
    required this.onClear,
  });

  final bool isOpen;
  final bool clearable;
  final bool hasSelection;
  final bool disabled;
  final Color iconColor;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    if (disabled) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (clearable && hasSelection) ...[
          GestureDetector(
            onTap: onClear,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                Icons.close,
                size: OmsaTextFieldDimensions.iconSize - 4,
                color: iconColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
            child: VerticalDivider(
              width: AppSpacing.spaceSmall,
              thickness: 1,
              color: iconColor.withValues(alpha: 0.2),
            ),
          ),
        ],
        const SizedBox(width: AppSpacing.spaceSmall),
        AnimatedRotation(
          turns: isOpen ? 0.5 : 0,
          duration: const Duration(
            milliseconds: OmsaTextFieldDimensions.animationDurationMs,
          ),
          child: Icon(
            Icons.keyboard_arrow_down,
            size: OmsaTextFieldDimensions.iconSize,
            color: iconColor,
          ),
        ),
      ],
    );
  }
}
