import 'package:flutter/material.dart';

/// Floating button size: standard = 48px, small = 32px
enum OmsaFloatingButtonSize { standard, small }

/// Floating action button component following EDS design system.
/// Supports icon-only or extended mode with text labels.
class OmsaFloatingButton extends StatefulWidget {
  const OmsaFloatingButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.label,
    this.size = OmsaFloatingButtonSize.standard,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String? label;
  final OmsaFloatingButtonSize size;
  final bool isLoading;

  bool get isExtended => label != null;

  @override
  State<OmsaFloatingButton> createState() => _OmsaFloatingButtonState();
}

class _OmsaFloatingButtonState extends State<OmsaFloatingButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  bool get _isDisabled => widget.onPressed == null;

  double get _height {
    switch (widget.size) {
      case OmsaFloatingButtonSize.small:
        return 32.0; // 2rem
      case OmsaFloatingButtonSize.standard:
        return 48.0; // 3rem
    }
  }

  double get _minWidth {
    switch (widget.size) {
      case OmsaFloatingButtonSize.small:
        return 32.0; // 2rem
      case OmsaFloatingButtonSize.standard:
        return 48.0; // 3rem
    }
  }

  double get _borderRadius {
    switch (widget.size) {
      case OmsaFloatingButtonSize.small:
        return 16.0; // 1rem
      case OmsaFloatingButtonSize.standard:
        return 24.0; // 1.5rem
    }
  }

  EdgeInsets get _padding {
    if (widget.isExtended) {
      switch (widget.size) {
        case OmsaFloatingButtonSize.small:
          return const EdgeInsets.symmetric(horizontal: 11.0); // 0.6875rem
        case OmsaFloatingButtonSize.standard:
          return const EdgeInsets.symmetric(horizontal: 15.0);
      }
    } else {
      switch (widget.size) {
        case OmsaFloatingButtonSize.small:
          return const EdgeInsets.symmetric(horizontal: 8.0); // 0.5rem
        case OmsaFloatingButtonSize.standard:
          return const EdgeInsets.symmetric(horizontal: 16.0); // 1rem
      }
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case OmsaFloatingButtonSize.small:
        return 14.0; // 0.875rem
      case OmsaFloatingButtonSize.standard:
        return 16.0; // 1rem
    }
  }

  double get _lineHeight {
    switch (widget.size) {
      case OmsaFloatingButtonSize.small:
        return 22.0; // 1.375rem
      case OmsaFloatingButtonSize.standard:
        return 24.0; // 1.5rem
    }
  }

  double get _iconSize {
    switch (widget.size) {
      case OmsaFloatingButtonSize.small:
        return 16.0;
      case OmsaFloatingButtonSize.standard:
        return 24.0;
    }
  }

  FloatingButtonColors _getColors(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    if (_isDisabled && !widget.isLoading) {
      return FloatingButtonColors(
        background: isLight ? const Color(0xFFCFD2D4) : const Color(0x1AD0D2D4),
        text: isLight ? const Color(0xFF515254) : const Color(0xFFB6B8BA),
        shadowColor: Colors.black.withValues(alpha: 0.25),
      );
    }

    if (_isPressed) {
      return FloatingButtonColors(
        background: isLight ? const Color(0xFF11143C) : const Color(0xFF8794D4),
        text: isLight ? const Color(0xFFFFFFFF) : const Color(0xFF08091C),
        shadowColor: Colors.black.withValues(alpha: 0.25),
      );
    }

    if (_isHovered) {
      return FloatingButtonColors(
        background: isLight ? const Color(0xFF393D79) : const Color(0xFFC7CDEB),
        text: isLight ? const Color(0xFFFFFFFF) : const Color(0xFF08091C),
        shadowColor: Colors.black.withValues(alpha: 0.25),
      );
    }

    return FloatingButtonColors(
      background: isLight ? const Color(0xFF181C56) : const Color(0xFFAEB7E2),
      text: isLight ? const Color(0xFFFFFFFF) : const Color(0xFF08091C),
      shadowColor: Colors.black.withValues(alpha: 0.25),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);

    Widget content;

    if (widget.isLoading) {
      content = SizedBox(
        height: _iconSize,
        width: _iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(colors.text),
        ),
      );
    } else if (widget.isExtended) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTheme(
            data: IconThemeData(color: colors.text, size: _iconSize),
            child: widget.icon,
          ),
          const SizedBox(width: 8.0),
          Text(
            widget.label!,
            style: TextStyle(
              color: colors.text,
              fontSize: _fontSize,
              fontWeight: FontWeight.w500,
              height: _lineHeight / _fontSize,
            ),
          ),
        ],
      );
    } else {
      content = IconTheme(
        data: IconThemeData(color: colors.text, size: _iconSize),
        child: widget.icon,
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: Focus(
          child: Material(
            color: colors.background,
            borderRadius: BorderRadius.circular(_borderRadius),
            elevation: 0,
            shadowColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(_borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: colors.shadowColor,
                    offset: const Offset(0, 1),
                    blurRadius: 3.0,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: InkWell(
                onTap: widget.isLoading || _isDisabled
                    ? null
                    : widget.onPressed,
                borderRadius: BorderRadius.circular(_borderRadius),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: _height,
                    minWidth: _minWidth,
                  ),
                  padding: _padding,
                  child: Center(child: content),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FloatingButtonColors {
  const FloatingButtonColors({
    required this.background,
    required this.text,
    required this.shadowColor,
  });

  final Color background;
  final Color text;
  final Color shadowColor;
}
