import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/chip/omsa_chip_size.dart';
import 'package:omsa_design_system/components/chip/omsa_chip_colors.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';

/// Action chip used for triggering immediate actions.
class OmsaActionChip extends StatefulWidget {
  const OmsaActionChip({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = OmsaChipSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.loading = false,
    this.disabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.focusNode,
    this.autofocus = false,
    this.semanticsLabel,
  });

  final Widget label;
  final VoidCallback? onPressed;
  final OmsaChipSize size;
  final OmsaComponentMode mode;
  final bool loading;
  final bool disabled;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticsLabel;

  @override
  State<OmsaActionChip> createState() => _OmsaActionChipState();
}

class _OmsaActionChipState extends State<OmsaActionChip> {
  static const Duration _animationDuration = Duration(milliseconds: 120);
  static const Curve _animationCurve = Curves.easeOut;
  static const double _borderRadius = 16.0;

  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  bool get _isDisabled => widget.disabled || widget.onPressed == null;

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

  ChipState get _interactionState {
    if (_isDisabled) {
      return ChipState.disabled;
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
    if (_interactionState == ChipState.pressed) {
      return Colors.transparent;
    }

    if (_interactionState == ChipState.hovered &&
        widget.mode == OmsaComponentMode.contrast) {
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

  @override
  Widget build(BuildContext context) {
    final colors = OmsaChipColors.fromContext(context, mode: widget.mode);
    final ChipState state = _interactionState;

    final Color backgroundColor;
    switch (state) {
      case ChipState.disabled:
      case ChipState.defaultState:
        backgroundColor = colors.backgroundDefault;
        break;
      case ChipState.hovered:
        backgroundColor = colors.backgroundHover;
        break;
      case ChipState.pressed:
      case ChipState.selected:
        backgroundColor = colors.backgroundActive;
        break;
    }

    final Color textColor;
    if (state == ChipState.disabled) {
      textColor = colors.textDisabled;
    } else if (state == ChipState.pressed &&
        widget.mode == OmsaComponentMode.contrast) {
      textColor = colors.textSelected;
    } else {
      textColor = colors.textUnselected;
    }

    final Color borderColor = _resolveBorderColor(context, colors);
    final Color focusColor = colors.focus;

    final List<Widget> children = [];

    if (widget.leadingIcon != null) {
      children
        ..add(
          IconTheme(
            data: IconThemeData(size: _iconSize, color: textColor),
            child: widget.leadingIcon!,
          ),
        )
        ..add(const SizedBox(width: 4.0));
    }

    children.add(widget.label);

    if (widget.trailingIcon != null && !widget.loading) {
      children
        ..add(const SizedBox(width: 4.0))
        ..add(
          IconTheme(
            data: IconThemeData(size: _iconSize, color: textColor),
            child: widget.trailingIcon!,
          ),
        );
    }

    Widget content;
    if (widget.loading) {
      content = SizedBox(
        height: _iconSize,
        width: _iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    } else {
      content = Row(mainAxisSize: MainAxisSize.min, children: children);
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
            data: IconThemeData(size: _iconSize, color: textColor),
            child: content,
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
          onTap: _isDisabled || widget.loading ? null : widget.onPressed,
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
      label: widget.semanticsLabel,
      liveRegion: widget.loading,
      child: chip,
    );
  }
}
