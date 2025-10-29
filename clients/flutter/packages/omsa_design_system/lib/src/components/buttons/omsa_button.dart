import 'package:flutter/material.dart';
import 'package:omsa_design_system/src/theme/app_button_colors.dart';

enum OmsaButtonVariant {
  primary,
  secondary,
  success,
  negative,
}

/// Button size options: small = 32px, medium = 48px, large = 60px
enum OmsaButtonSize {
  small,
  medium,
  large,
}

enum OmsaButtonWidth {
  fluid,
  auto,
}

/// Button component following EDS design system with support for variants,
/// sizes, loading and disabled states.
class OmsaButton extends StatefulWidget {
  const OmsaButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = OmsaButtonVariant.primary,
    this.size = OmsaButtonSize.medium,
    this.width = OmsaButtonWidth.auto,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final OmsaButtonVariant variant;
  final OmsaButtonSize size;
  final OmsaButtonWidth width;
  final bool isLoading;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  @override
  State<OmsaButton> createState() => _OmsaButtonState();
}

class _OmsaButtonState extends State<OmsaButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  bool get _isDisabled => widget.onPressed == null;

  double get _height {
    switch (widget.size) {
      case OmsaButtonSize.small:
        return 32.0; // 2rem
      case OmsaButtonSize.medium:
        return 48.0; // 3rem
      case OmsaButtonSize.large:
        return 60.0; // 3.75rem
    }
  }

  double get _minWidth {
    switch (widget.size) {
      case OmsaButtonSize.small:
        return 92.0; // 5.75rem
      case OmsaButtonSize.medium:
        return 152.0; // 9.5rem
      case OmsaButtonSize.large:
        return 188.0; // 11.75rem
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case OmsaButtonSize.small:
        return 14.0; // 0.875rem
      case OmsaButtonSize.medium:
      case OmsaButtonSize.large:
        return 16.0; // 1rem
    }
  }

  double get _lineHeight {
    switch (widget.size) {
      case OmsaButtonSize.small:
        return 22.0; // 1.375rem
      case OmsaButtonSize.medium:
      case OmsaButtonSize.large:
        return 24.0; // 1.5rem
    }
  }

  EdgeInsets get _padding {
    return const EdgeInsets.symmetric(horizontal: 16.0);
  }

  ButtonColors _getColors(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final colors = brightness == Brightness.light
        ? AppButtonColors.standard
        : AppButtonColors.contrast;

    if (_isDisabled && !widget.isLoading) {
      return ButtonColors(
        background: colors.disabledFill,
        text: colors.disabledText,
        border: Colors.transparent,
      );
    }

    switch (widget.variant) {
      case OmsaButtonVariant.primary:
        return ButtonColors(
          background: _isPressed
              ? colors.primaryBackgroundActive
              : _isHovered
                  ? colors.primaryBackgroundHover
                  : colors.primaryBackground,
          text: colors.primaryText,
          border: Colors.transparent,
        );
      case OmsaButtonVariant.secondary:
        return ButtonColors(
          background: _isPressed
              ? colors.secondaryBackgroundActive
              : _isHovered
                  ? colors.secondaryBackgroundHover
                  : colors.secondaryBackground,
          text: _isPressed ? colors.secondaryTextActive : colors.secondaryText,
          border: _isPressed ? colors.secondaryBorderActive : colors.secondaryBorder,
        );
      case OmsaButtonVariant.success:
        return ButtonColors(
          background: _isPressed
              ? colors.successBackgroundActive
              : _isHovered
                  ? colors.successBackgroundHover
                  : colors.successBackground,
          text: colors.successText,
          border: colors.successBorder,
        );
      case OmsaButtonVariant.negative:
        return ButtonColors(
          background: _isPressed
              ? colors.negativeBackgroundActive
              : _isHovered
                  ? colors.negativeBackgroundHover
                  : colors.negativeBackground,
          text: _isPressed ? colors.negativeTextActive : colors.negativeText,
          border: colors.negativeBorder,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);

    Widget content = widget.child;

    if (widget.leadingIcon != null || widget.trailingIcon != null) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.leadingIcon != null) ...[
            IconTheme(
              data: IconThemeData(color: colors.text),
              child: widget.leadingIcon!,
            ),
            const SizedBox(width: 12.0), // 0.75rem
          ],
          content,
          if (widget.trailingIcon != null) ...[
            const SizedBox(width: 12.0), // 0.75rem
            IconTheme(
              data: IconThemeData(color: colors.text),
              child: widget.trailingIcon!,
            ),
          ],
        ],
      );
    }

    if (widget.isLoading) {
      content = SizedBox(
        height: _fontSize,
        width: _fontSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(colors.text),
        ),
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
            borderRadius: BorderRadius.circular(4.0), // 0.25rem
            child: InkWell(
              onTap: widget.isLoading || _isDisabled ? null : widget.onPressed,
              borderRadius: BorderRadius.circular(4.0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: _height,
                  minWidth: widget.width == OmsaButtonWidth.fluid ? double.infinity : _minWidth,
                  maxWidth: widget.width == OmsaButtonWidth.fluid ? double.infinity : double.infinity,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colors.border,
                    width: 2.0, // 0.125rem
                  ),
                  borderRadius: BorderRadius.circular(4.0), // 0.25rem
                ),
                padding: _padding,
                child: Center(
                  child: IconTheme(
                    data: IconThemeData(color: colors.text),
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: colors.text,
                        fontSize: _fontSize,
                        fontWeight: FontWeight.w500,
                        height: _lineHeight / _fontSize,
                      ),
                      textAlign: TextAlign.center,
                      child: content,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonColors {
  const ButtonColors({
    required this.background,
    required this.text,
    required this.border,
  });

  final Color background;
  final Color text;
  final Color border;
}
