import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';

enum OmsaIconButtonSize { small, medium }

/// Icon-only button component following EDS design system
/// with support for sizes, loading and disabled states.
class OmsaIconButton extends StatefulWidget {
  const OmsaIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = OmsaIconButtonSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.isLoading = false,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final OmsaIconButtonSize size;
  final OmsaComponentMode mode;
  final bool isLoading;
  final String? tooltip;

  @override
  State<OmsaIconButton> createState() => _OmsaIconButtonState();
}

class _OmsaIconButtonState extends State<OmsaIconButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  bool get _isDisabled => widget.onPressed == null;

  double get _size {
    switch (widget.size) {
      case OmsaIconButtonSize.small:
        return 24.0;
      case OmsaIconButtonSize.medium:
        return 40.0;
    }
  }

  double get _iconSize {
    return 24.0;
  }

  EdgeInsets get _padding {
    switch (widget.size) {
      case OmsaIconButtonSize.small:
        return EdgeInsets.zero;
      case OmsaIconButtonSize.medium:
        return const EdgeInsets.all(AppSpacing.spaceExtraSmall);
    }
  }

  IconButtonColors _getColors(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;
    final isStandard = widget.mode == OmsaComponentMode.standard;

    return IconButtonColors(
      background: _getColorToken(
        isLight: isLight,
        isStandard: isStandard,
        lightStandard: _isPressed
            ? ComponentLightTokens.buttonIconButtonStandardActive
            : _isHovered
            ? ComponentLightTokens.buttonIconButtonStandardHover
            : ComponentLightTokens.buttonIconButtonStandardDefault,
        lightContrast: _isPressed
            ? ComponentLightTokens.buttonIconButtonContrastActive
            : _isHovered
            ? ComponentLightTokens.buttonIconButtonContrastHover
            : ComponentLightTokens.buttonIconButtonContrastDefault,
        darkStandard: _isPressed
            ? ComponentDarkTokens.buttonIconButtonStandardActive
            : _isHovered
            ? ComponentDarkTokens.buttonIconButtonStandardHover
            : ComponentDarkTokens.buttonIconButtonStandardDefault,
        darkContrast: _isPressed
            ? ComponentDarkTokens.buttonIconButtonContrastActive
            : _isHovered
            ? ComponentDarkTokens.buttonIconButtonContrastHover
            : ComponentDarkTokens.buttonIconButtonContrastDefault,
      ),
      icon: _getColorToken(
        isLight: isLight,
        isStandard: isStandard,
        lightStandard: _isPressed
            ? ComponentLightTokens.buttonIconButtonStandardIconActive
            : ComponentLightTokens.buttonIconButtonStandardIcon,
        lightContrast: _isPressed
            ? ComponentLightTokens.buttonIconButtonContrastIconActive
            : ComponentLightTokens.buttonIconButtonContrastIcon,
        darkStandard: _isPressed
            ? ComponentDarkTokens.buttonIconButtonStandardIconActive
            : ComponentDarkTokens.buttonIconButtonStandardIcon,
        darkContrast: _isPressed
            ? ComponentDarkTokens.buttonIconButtonContrastIconActive
            : ComponentDarkTokens.buttonIconButtonContrastIcon,
      ),
      text: _getColorToken(
        isLight: isLight,
        isStandard: isStandard,
        lightStandard: _isPressed
            ? ComponentLightTokens.buttonIconButtonStandardTextActive
            : ComponentLightTokens.buttonIconButtonStandardText,
        lightContrast: _isPressed
            ? ComponentLightTokens.buttonIconButtonContrastTextActive
            : ComponentLightTokens.buttonIconButtonContrastText,
        darkStandard: _isPressed
            ? ComponentDarkTokens.buttonIconButtonStandardTextActive
            : ComponentDarkTokens.buttonIconButtonStandardText,
        darkContrast: _isPressed
            ? ComponentDarkTokens.buttonIconButtonContrastTextActive
            : ComponentDarkTokens.buttonIconButtonContrastText,
      ),
    );
  }

  Color _getColorToken({
    required bool isLight,
    required bool isStandard,
    required Color lightStandard,
    required Color lightContrast,
    required Color darkStandard,
    required Color darkContrast,
  }) {
    if (isLight) {
      return isStandard ? lightStandard : lightContrast;
    } else {
      return isStandard ? darkStandard : darkContrast;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);

    Widget content = widget.icon;

    if (widget.isLoading) {
      content = SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(colors.text),
        ),
      );
    }

    final button = MouseRegion(
      cursor: _isDisabled || widget.isLoading
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: _isDisabled ? null : (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _isDisabled
            ? null
            : (_) => setState(() => _isPressed = true),
        onTapUp: _isDisabled ? null : (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.isLoading || _isDisabled ? null : widget.onPressed,
        child: Container(
          width: _size,
          height: _size,
          padding: _padding,
          decoration: BoxDecoration(
            color: colors.background,
            border: Border.all(color: Colors.transparent, width: 2.0),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: IconTheme(
              data: IconThemeData(color: colors.text, size: _iconSize),
              child: content,
            ),
          ),
        ),
      ),
    );

    if (_isDisabled && !widget.isLoading) {
      return Opacity(opacity: 0.5, child: IgnorePointer(child: button));
    }

    if (widget.tooltip != null) {
      return Tooltip(message: widget.tooltip!, child: button);
    }

    return button;
  }
}

class IconButtonColors {
  const IconButtonColors({
    required this.background,
    required this.icon,
    required this.text,
  });

  final Color background;
  final Color icon;
  final Color text;
}
