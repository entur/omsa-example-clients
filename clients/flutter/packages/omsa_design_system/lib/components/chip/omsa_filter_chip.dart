import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/chip/omsa_chip_size.dart';
import 'package:omsa_design_system/components/chip/omsa_chip_colors.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';

/// Filter chip that behaves like a checkbox for multi-select use-cases.
class OmsaFilterChip extends StatefulWidget {
  const OmsaFilterChip({
    super.key,
    required this.label,
    required this.value,
    this.selected = false,
    this.onSelected,
    this.size = OmsaChipSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.disabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.focusNode,
    this.autofocus = false,
    this.semanticsLabel,
  });

  final Widget label;
  final String value;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final OmsaChipSize size;
  final OmsaComponentMode mode;
  final bool disabled;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticsLabel;

  @override
  State<OmsaFilterChip> createState() => _OmsaFilterChipState();
}

class _OmsaFilterChipState extends State<OmsaFilterChip> {
  static const Duration _animationDuration = Duration(milliseconds: 120);
  static const Curve _animationCurve = Curves.easeOut;
  static const double _borderRadius = 16.0;

  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  bool get _isDisabled => widget.disabled || widget.onSelected == null;

  double get _height {
    switch (widget.size) {
      case OmsaChipSize.small:
        return 24.0;
      case OmsaChipSize.medium:
        return 32.0;
    }
  }

  double get _minWidth {
    switch (widget.size) {
      case OmsaChipSize.small:
        return 40.0;
      case OmsaChipSize.medium:
        return 48.0;
    }
  }

  double get _horizontalPadding {
    switch (widget.size) {
      case OmsaChipSize.small:
        return 8.0;
      case OmsaChipSize.medium:
        return 12.0;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case OmsaChipSize.small:
        return 14.0;
      case OmsaChipSize.medium:
        return 16.0;
    }
  }

  double get _iconSize => 16.0;
  double get _checkIconSize => 16.0;

  ChipState get _backgroundState {
    if (_isDisabled) {
      return ChipState.disabled;
    }
    if (widget.selected) {
      return ChipState.selected;
    }
    if (_isPressed) {
      return ChipState.pressed;
    }
    if (_isHovered) {
      return ChipState.hovered;
    }
    return ChipState.defaultState;
  }

  Color _resolveBorderColor(BuildContext context, OmsaChipColors colors) {
    if (widget.selected || _isPressed) {
      return Colors.transparent;
    }
    if (_isHovered && widget.mode == OmsaComponentMode.contrast) {
      return Colors.transparent;
    }
    return colors.border;
  }

  void _handleHover(bool value) {
    if (_isDisabled || _isHovered == value) {
      return;
    }
    setState(() => _isHovered = value);
  }

  void _handleHighlight(bool value) {
    if (_isDisabled || _isPressed == value) {
      return;
    }
    setState(() => _isPressed = value);
  }

  void _handleFocusChange(bool value) {
    if (_isFocused == value) {
      return;
    }
    setState(() => _isFocused = value);
  }

  void _toggleSelection() {
    if (_isDisabled || widget.onSelected == null) {
      return;
    }
    widget.onSelected!(!widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    final colors = OmsaChipColors.fromContext(context, mode: widget.mode);

    final Color backgroundColor;
    if (_isDisabled || _backgroundState == ChipState.defaultState) {
      backgroundColor = colors.backgroundDefault;
    } else if (_backgroundState == ChipState.selected) {
      backgroundColor = colors.backgroundActive;
    } else if (_backgroundState == ChipState.pressed) {
      backgroundColor = colors.backgroundActive;
    } else {
      backgroundColor = colors.backgroundHover;
    }

    final Color textColor;
    final Color iconColor;
    if (_isDisabled) {
      textColor = colors.textDisabled;
      iconColor = colors.iconDisabled;
    } else if (widget.selected) {
      if (_isHovered) {
        textColor = colors.textUnselected;
        iconColor = colors.iconUnselected;
      } else {
        textColor = colors.textSelected;
        iconColor = colors.iconSelected;
      }
    } else if (_isPressed) {
      textColor = colors.textSelected;
      iconColor = colors.iconSelected;
    } else {
      textColor = colors.textUnselected;
      iconColor = colors.iconUnselected;
    }

    final Color borderColor = _resolveBorderColor(context, colors);
    final Color focusColor = colors.focus;

    final List<Widget> children = [];

    if (widget.selected) {
      children
        ..add(Icon(Icons.check, size: _checkIconSize, color: iconColor))
        ..add(const SizedBox(width: 4.0));
    }

    if (widget.leadingIcon != null) {
      children
        ..add(
          IconTheme(
            data: IconThemeData(size: _iconSize, color: iconColor),
            child: widget.leadingIcon!,
          ),
        )
        ..add(const SizedBox(width: 4.0));
    }

    children.add(widget.label);

    if (widget.trailingIcon != null) {
      children
        ..add(const SizedBox(width: 4.0))
        ..add(
          IconTheme(
            data: IconThemeData(size: _iconSize, color: iconColor),
            child: widget.trailingIcon!,
          ),
        );
    }

    Widget chip = AnimatedContainer(
      duration: _animationDuration,
      curve: _animationCurve,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: _isFocused
            ? [BoxShadow(color: focusColor, spreadRadius: 2.0, blurRadius: 0)]
            : const [],
      ),
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: _animationCurve,
        height: _height,
        constraints: BoxConstraints(minWidth: _minWidth),
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(color: borderColor, width: 1.0),
        ),
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.normal,
            color: textColor,
          ),
          child: IconTheme(
            data: IconThemeData(size: _iconSize, color: iconColor),
            child: Row(mainAxisSize: MainAxisSize.min, children: children),
          ),
        ),
      ),
    );

    chip = MouseRegion(
      cursor: _isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: (_) => _handleHover(true),
      onExit: (_) {
        _handleHover(false);
        _handleHighlight(false);
      },
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: _toggleSelection,
          onHover: _handleHover,
          onHighlightChanged: _handleHighlight,
          onFocusChange: _handleFocusChange,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          canRequestFocus: !_isDisabled,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          child: chip,
        ),
      ),
    );

    if (_isDisabled) {
      chip = Opacity(opacity: 0.5, child: chip);
    }

    return Semantics(
      button: true,
      enabled: !_isDisabled,
      toggled: widget.selected,
      label: widget.semanticsLabel,
      child: chip,
    );
  }
}
