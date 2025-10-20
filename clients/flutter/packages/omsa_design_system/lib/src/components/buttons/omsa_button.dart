import 'package:flutter/material.dart';

/// Button variant types for the OMSA Design System
enum OmsaButtonVariant {
  primary,
  secondary,
  outlined,
  text,
}

/// Button size options
enum OmsaButtonSize {
  small,
  medium,
  large,
}

/// A customizable button component following OMSA Design System guidelines
class OmsaButton extends StatelessWidget {
  const OmsaButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = OmsaButtonVariant.primary,
    this.size = OmsaButtonSize.large,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final OmsaButtonVariant variant;
  final OmsaButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;

  double get _height {
    switch (size) {
      case OmsaButtonSize.small:
        return 32.0;
      case OmsaButtonSize.medium:
        return 40.0;
      case OmsaButtonSize.large:
        return 48.0;
    }
  }

  double get _fontSize {
    switch (size) {
      case OmsaButtonSize.small:
        return 12.0;
      case OmsaButtonSize.medium:
        return 14.0;
      case OmsaButtonSize.large:
        return 14.0;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case OmsaButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case OmsaButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case OmsaButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    }
  }

  Widget _buildButton(BuildContext context) {
    final content = isLoading
        ? SizedBox(
            height: _fontSize + 4,
            width: _fontSize + 4,
            child: const CircularProgressIndicator(strokeWidth: 2),
          )
        : icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon!,
                  const SizedBox(width: 8),
                  child,
                ],
              )
            : child;

    final buttonStyle = ButtonStyle(
      minimumSize: WidgetStateProperty.all(
        Size(isFullWidth ? double.infinity : 0, _height),
      ),
      padding: WidgetStateProperty.all(_padding),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w500),
      ),
    );

    switch (variant) {
      case OmsaButtonVariant.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: content,
        );
      case OmsaButtonVariant.secondary:
        return FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: content,
        );
      case OmsaButtonVariant.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: content,
        );
      case OmsaButtonVariant.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: content,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildButton(context);
  }
}
