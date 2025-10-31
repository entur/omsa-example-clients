import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';

enum OmsaButtonVariant { primary, secondary, success, negative }

/// Button size options: small = 32px, medium = 48px, large = 60px
enum OmsaButtonSize { small, medium, large }

enum OmsaButtonWidth { fluid, auto }

/// Component mode for switching between default and contrast tokens
enum OmsaComponentMode { standard, contrast }

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
    this.mode = OmsaComponentMode.standard,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final OmsaButtonVariant variant;
  final OmsaButtonSize size;
  final OmsaButtonWidth width;
  final OmsaComponentMode mode;
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
    final isLight = brightness == Brightness.light;
    final isStandard = widget.mode == OmsaComponentMode.standard;

    if (_isDisabled && !widget.isLoading) {
      return ButtonColors(
        background: isLight
            ? (isStandard
                  ? ComponentLightTokens.buttonDisabledStandardFill
                  : ComponentLightTokens.buttonDisabledContrastFill)
            : (isStandard
                  ? ComponentDarkTokens.buttonDisabledStandardFill
                  : ComponentDarkTokens.buttonDisabledContrastFill),
        text: isLight
            ? (isStandard
                  ? ComponentLightTokens.buttonDisabledStandardTextDisabled
                  : ComponentLightTokens.buttonDisabledContrastTextDisabled)
            : (isStandard
                  ? ComponentDarkTokens.buttonDisabledStandardTextDisabled
                  : ComponentDarkTokens.buttonDisabledContrastTextDisabled),
        border: Colors.transparent,
      );
    }

    switch (widget.variant) {
      case OmsaButtonVariant.primary:
        return ButtonColors(
          background: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: _isPressed
                ? ComponentLightTokens.buttonPrimaryStandardActive
                : _isHovered
                ? ComponentLightTokens.buttonPrimaryStandardHover
                : ComponentLightTokens.buttonPrimaryStandardDefault,
            lightContrast: _isPressed
                ? ComponentLightTokens.buttonPrimaryContrastActive
                : _isHovered
                ? ComponentLightTokens.buttonPrimaryContrastHover
                : ComponentLightTokens.buttonPrimaryContrastDefault,
            darkStandard: _isPressed
                ? ComponentDarkTokens.buttonPrimaryStandardActive
                : _isHovered
                ? ComponentDarkTokens.buttonPrimaryStandardHover
                : ComponentDarkTokens.buttonPrimaryStandardDefault,
            darkContrast: _isPressed
                ? ComponentDarkTokens.buttonPrimaryContrastActive
                : _isHovered
                ? ComponentDarkTokens.buttonPrimaryContrastHover
                : ComponentDarkTokens.buttonPrimaryContrastDefault,
          ),
          text: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: ComponentLightTokens.buttonPrimaryStandardText,
            lightContrast: ComponentLightTokens.buttonPrimaryContrastText,
            darkStandard: ComponentDarkTokens.buttonPrimaryStandardText,
            darkContrast: ComponentDarkTokens.buttonPrimaryContrastText,
          ),
          border: Colors.transparent,
        );
      case OmsaButtonVariant.secondary:
        return ButtonColors(
          background: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: _isPressed
                ? ComponentLightTokens.buttonSecondaryStandardActive
                : _isHovered
                ? ComponentLightTokens.buttonSecondaryStandardHover
                : ComponentLightTokens.buttonSecondaryStandardDefault,
            lightContrast: _isPressed
                ? ComponentLightTokens.buttonSecondaryContrastActive
                : _isHovered
                ? ComponentLightTokens.buttonSecondaryContrastHover
                : ComponentLightTokens.buttonSecondaryContrastDefault,
            darkStandard: _isPressed
                ? ComponentDarkTokens.buttonSecondaryStandardActive
                : _isHovered
                ? ComponentDarkTokens.buttonSecondaryStandardHover
                : ComponentDarkTokens.buttonSecondaryStandardDefault,
            darkContrast: _isPressed
                ? ComponentDarkTokens.buttonSecondaryContrastActive
                : _isHovered
                ? ComponentDarkTokens.buttonSecondaryContrastHover
                : ComponentDarkTokens.buttonSecondaryContrastDefault,
          ),
          text: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: _isPressed
                ? ComponentLightTokens.buttonSecondaryStandardTextActive
                : ComponentLightTokens.buttonSecondaryStandardText,
            lightContrast: _isPressed
                ? ComponentLightTokens.buttonSecondaryContrastTextActive
                : ComponentLightTokens.buttonSecondaryContrastText,
            darkStandard: _isPressed
                ? ComponentDarkTokens.buttonSecondaryStandardTextActive
                : ComponentDarkTokens.buttonSecondaryStandardText,
            darkContrast: _isPressed
                ? ComponentDarkTokens.buttonSecondaryContrastTextActive
                : ComponentDarkTokens.buttonSecondaryContrastText,
          ),
          border: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: _isPressed
                ? ComponentLightTokens.buttonSecondaryStandardBorderActive
                : ComponentLightTokens.buttonSecondaryStandardBorder,
            lightContrast: _isPressed
                ? ComponentLightTokens.buttonSecondaryContrastBorderActive
                : ComponentLightTokens.buttonSecondaryContrastBorder,
            darkStandard: _isPressed
                ? ComponentDarkTokens.buttonSecondaryStandardBorderActive
                : ComponentDarkTokens.buttonSecondaryStandardBorder,
            darkContrast: _isPressed
                ? ComponentDarkTokens.buttonSecondaryContrastBorderActive
                : ComponentDarkTokens.buttonSecondaryContrastBorder,
          ),
        );
      case OmsaButtonVariant.success:
        return ButtonColors(
          background: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: _isPressed
                ? ComponentLightTokens.buttonSuccessStandardActive
                : _isHovered
                ? ComponentLightTokens.buttonSuccessStandardHover
                : ComponentLightTokens.buttonSuccessStandardDefault,
            lightContrast: _isPressed
                ? ComponentLightTokens.buttonSuccessContrastActive
                : _isHovered
                ? ComponentLightTokens.buttonSuccessContrastHover
                : ComponentLightTokens.buttonSuccessContrastDefault,
            darkStandard: _isPressed
                ? ComponentDarkTokens.buttonSuccessStandardActive
                : _isHovered
                ? ComponentDarkTokens.buttonSuccessStandardHover
                : ComponentDarkTokens.buttonSuccessStandardDefault,
            darkContrast: _isPressed
                ? ComponentDarkTokens.buttonSuccessContrastActive
                : _isHovered
                ? ComponentDarkTokens.buttonSuccessContrastHover
                : ComponentDarkTokens.buttonSuccessContrastDefault,
          ),
          text: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: ComponentLightTokens.buttonSuccessStandardText,
            lightContrast: ComponentLightTokens.buttonSuccessContrastText,
            darkStandard: ComponentDarkTokens.buttonSuccessStandardText,
            darkContrast: ComponentDarkTokens.buttonSuccessContrastText,
          ),
          border: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: ComponentLightTokens.buttonSuccessStandardBorder,
            lightContrast: ComponentLightTokens.buttonSuccessContrastBorder,
            darkStandard: ComponentDarkTokens.buttonSuccessStandardBorder,
            darkContrast: ComponentDarkTokens.buttonSuccessContrastBorder,
          ),
        );
      case OmsaButtonVariant.negative:
        return ButtonColors(
          background: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: _isPressed
                ? ComponentLightTokens.buttonNegativeStandardActive
                : _isHovered
                ? ComponentLightTokens.buttonNegativeStandardHover
                : ComponentLightTokens.buttonNegativeStandardDefault,
            lightContrast: _isPressed
                ? ComponentLightTokens.buttonNegativeContrastActive
                : _isHovered
                ? ComponentLightTokens.buttonNegativeContrastHover
                : ComponentLightTokens.buttonNegativeContrastDefault,
            darkStandard: _isPressed
                ? ComponentDarkTokens.buttonNegativeStandardActive
                : _isHovered
                ? ComponentDarkTokens.buttonNegativeStandardHover
                : ComponentDarkTokens.buttonNegativeStandardDefault,
            darkContrast: _isPressed
                ? ComponentDarkTokens.buttonNegativeContrastActive
                : _isHovered
                ? ComponentDarkTokens.buttonNegativeContrastHover
                : ComponentDarkTokens.buttonNegativeContrastDefault,
          ),
          text: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: _isPressed
                ? ComponentLightTokens.buttonNegativeStandardTextActive
                : ComponentLightTokens.buttonNegativeStandardText,
            lightContrast: _isPressed
                ? ComponentLightTokens.buttonNegativeContrastTextActive
                : ComponentLightTokens.buttonNegativeContrastText,
            darkStandard: _isPressed
                ? ComponentDarkTokens.buttonNegativeStandardTextActive
                : ComponentDarkTokens.buttonNegativeStandardText,
            darkContrast: _isPressed
                ? ComponentDarkTokens.buttonNegativeContrastTextActive
                : ComponentDarkTokens.buttonNegativeContrastText,
          ),
          border: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: ComponentLightTokens.buttonNegativeStandardBorder,
            lightContrast: ComponentLightTokens.buttonNegativeContrastBorder,
            darkStandard: ComponentDarkTokens.buttonNegativeStandardBorder,
            darkContrast: ComponentDarkTokens.buttonNegativeContrastBorder,
          ),
        );
    }
  }

  /// Helper method to select the correct color token based on brightness and mode
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
                  minWidth: widget.width == OmsaButtonWidth.fluid
                      ? double.infinity
                      : _minWidth,
                  maxWidth: widget.width == OmsaButtonWidth.fluid
                      ? double.infinity
                      : double.infinity,
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
