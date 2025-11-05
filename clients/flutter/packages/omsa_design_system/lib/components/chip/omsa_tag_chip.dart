import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/chip/omsa_chip_size.dart';
import 'package:omsa_design_system/components/chip/omsa_chip_colors.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_icons/omsa_icons.dart';

/// Tag chip with dismiss action (close button).
class OmsaTagChip extends StatefulWidget {
  const OmsaTagChip({
    super.key,
    required this.label,
    required this.onClose,
    this.closeButtonAriaLabel,
    this.size = OmsaChipSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.leadingIcon,
    this.trailingIcon,
  });

  final Widget label;
  final VoidCallback onClose;
  final String? closeButtonAriaLabel;
  final OmsaChipSize size;
  final OmsaComponentMode mode;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  @override
  State<OmsaTagChip> createState() => _OmsaTagChipState();
}

class _OmsaTagChipState extends State<OmsaTagChip> {
  static const Duration _animationDuration = Duration(milliseconds: 120);
  static const Curve _animationCurve = Curves.easeOut;
  static const double _borderRadius = 16.0;

  bool _closeHovered = false;
  bool _closePressed = false;
  bool _closeFocused = false;

  late OmsaChipColors _colors;

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

  double get _closeIconSize {
    switch (widget.size) {
      case OmsaChipSize.small:
        return 16.0;
      case OmsaChipSize.medium:
        return 24.0;
    }
  }

  double get _closeButtonRadius => 12.0;

  Color _resolveCloseBackground() {
    if (_closePressed) {
      return _colors.backgroundActive;
    }
    if (_closeHovered) {
      return _colors.backgroundHover;
    }
    return Colors.transparent;
  }

  Color _resolveCloseIconColor() {
    if (_closePressed && widget.mode == OmsaComponentMode.contrast) {
      return _colors.textSelected;
    }
    return _colors.textUnselected;
  }

  void _handleCloseHover(bool value) {
    if (_closeHovered == value) {
      return;
    }
    setState(() => _closeHovered = value);
  }

  void _handleCloseHighlight(bool value) {
    if (_closePressed == value) {
      return;
    }
    setState(() => _closePressed = value);
  }

  void _handleCloseFocus(bool value) {
    if (_closeFocused == value) {
      return;
    }
    setState(() => _closeFocused = value);
  }

  @override
  Widget build(BuildContext context) {
    _colors = OmsaChipColors.fromContext(context, mode: widget.mode);
    final Color textColor = _colors.textUnselected;

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

    if (widget.trailingIcon != null) {
      children
        ..add(const SizedBox(width: 4.0))
        ..add(
          IconTheme(
            data: IconThemeData(size: _iconSize, color: textColor),
            child: widget.trailingIcon!,
          ),
        );
    }

    final Widget closeButton = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _handleCloseHover(true),
      onExit: (_) {
        _handleCloseHover(false);
        _handleCloseHighlight(false);
      },
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: widget.onClose,
          onHover: _handleCloseHover,
          onHighlightChanged: _handleCloseHighlight,
          onFocusChange: _handleCloseFocus,
          canRequestFocus: true,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_closeButtonRadius),
          ),
          child: AnimatedContainer(
            duration: _animationDuration,
            curve: _animationCurve,
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: _resolveCloseBackground(),
              borderRadius: BorderRadius.circular(_closeButtonRadius),
              boxShadow: _closeFocused
                  ? [
                      BoxShadow(
                        color: _colors.focus,
                        spreadRadius: 2.0,
                        blurRadius: 0,
                      ),
                    ]
                  : const [],
            ),
            child: OmsaIcons.CloseSmall(
              size: _closeIconSize,
              color: _resolveCloseIconColor(),
              excludeFromSemantics: true,
            ),
          ),
        ),
      ),
    );

    children
      ..add(const SizedBox(width: 4.0))
      ..add(
        Semantics(
          button: true,
          label: widget.closeButtonAriaLabel,
          child: ExcludeSemantics(child: closeButton),
        ),
      );

    return Container(
      height: _height,
      constraints: BoxConstraints(minWidth: _minWidth),
      padding: EdgeInsets.only(left: _horizontalPadding, right: 2.0),
      decoration: BoxDecoration(
        color: _colors.backgroundDefault,
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(color: _colors.border, width: 1.0),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: _fontSize,
          fontWeight: FontWeight.normal,
          color: textColor,
        ),
        child: IconTheme(
          data: IconThemeData(size: _iconSize, color: textColor),
          child: Row(mainAxisSize: MainAxisSize.min, children: children),
        ),
      ),
    );
  }
}
