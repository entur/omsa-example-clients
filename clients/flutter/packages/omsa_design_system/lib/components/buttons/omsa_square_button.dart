import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';

enum OmsaSquareButtonVariant { secondary, success, tertiary }

/// Square button component with icon and optional label
/// following EDS design system.
class OmsaSquareButton extends StatefulWidget {
  const OmsaSquareButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.label,
    this.variant = OmsaSquareButtonVariant.secondary,
    this.mode = OmsaComponentMode.standard,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String? label;
  final OmsaSquareButtonVariant variant;
  final OmsaComponentMode mode;
  final bool isLoading;

  @override
  State<OmsaSquareButton> createState() => _OmsaSquareButtonState();
}

class _OmsaSquareButtonState extends State<OmsaSquareButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  bool get _isDisabled => widget.onPressed == null;

  double get _buttonSize {
    switch (widget.variant) {
      case OmsaSquareButtonVariant.tertiary:
        return 32.0;
      case OmsaSquareButtonVariant.secondary:
      case OmsaSquareButtonVariant.success:
        return 44.0;
    }
  }

  double get _fontSize {
    switch (widget.variant) {
      case OmsaSquareButtonVariant.tertiary:
        return 14.0;
      case OmsaSquareButtonVariant.secondary:
      case OmsaSquareButtonVariant.success:
        return 16.0;
    }
  }

  double get _borderWidth {
    switch (widget.variant) {
      case OmsaSquareButtonVariant.tertiary:
        return 1.0;
      case OmsaSquareButtonVariant.secondary:
      case OmsaSquareButtonVariant.success:
        return 2.0;
    }
  }

  double get _spacing {
    switch (widget.variant) {
      case OmsaSquareButtonVariant.tertiary:
        return AppSpacing.spaceSmall;
      case OmsaSquareButtonVariant.secondary:
      case OmsaSquareButtonVariant.success:
        return AppSpacing.spaceDefault;
    }
  }

  SquareButtonColors _getColors(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;
    final isStandard = widget.mode == OmsaComponentMode.standard;

    if (_isDisabled && !widget.isLoading) {
      return SquareButtonColors(
        background: Colors.transparent,
        border: Theme.of(context).disabledColor,
        icon: Theme.of(context).disabledColor,
        label: Theme.of(context).disabledColor,
      );
    }

    switch (widget.variant) {
      case OmsaSquareButtonVariant.secondary:
      case OmsaSquareButtonVariant.tertiary:
        return _getSecondaryColors(isLight, isStandard);

      case OmsaSquareButtonVariant.success:
        return SquareButtonColors(
          background: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: _isPressed
                ? ComponentLightTokens.buttonSquaresuccessStandardActive
                : _isHovered
                ? ComponentLightTokens.buttonSquaresuccessStandardHover
                : ComponentLightTokens.buttonSquaresuccessStandardDefault,
            lightContrast: _isPressed
                ? ComponentLightTokens.buttonSquaresuccessContrastActive
                : _isHovered
                ? ComponentLightTokens.buttonSquaresuccessContrastHover
                : ComponentLightTokens.buttonSquaresuccessContrastDefault,
            darkStandard: _isPressed
                ? ComponentDarkTokens.buttonSquaresuccessStandardActive
                : _isHovered
                ? ComponentDarkTokens.buttonSquaresuccessStandardHover
                : ComponentDarkTokens.buttonSquaresuccessStandardDefault,
            darkContrast: _isPressed
                ? ComponentDarkTokens.buttonSquaresuccessContrastActive
                : _isHovered
                ? ComponentDarkTokens.buttonSquaresuccessContrastHover
                : ComponentDarkTokens.buttonSquaresuccessContrastDefault,
          ),
          border: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard:
                ComponentLightTokens.buttonSquaresuccessStandardBorder,
            lightContrast:
                ComponentLightTokens.buttonSquaresuccessContrastBorder,
            darkStandard: ComponentDarkTokens.buttonSquaresuccessStandardBorder,
            darkContrast: ComponentDarkTokens.buttonSquaresuccessContrastBorder,
          ),
          icon: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard: ComponentLightTokens.buttonSquaresuccessStandardIcon,
            lightContrast: ComponentLightTokens.buttonSquaresuccessContrastIcon,
            darkStandard: ComponentDarkTokens.buttonSquaresuccessStandardIcon,
            darkContrast: ComponentDarkTokens.buttonSquaresuccessContrastIcon,
          ),
          label: _getColorToken(
            isLight: isLight,
            isStandard: isStandard,
            lightStandard:
                ComponentLightTokens.buttonSquaresuccessStandardLabel,
            lightContrast:
                ComponentLightTokens.buttonSquaresuccessContrastLabel,
            darkStandard: ComponentDarkTokens.buttonSquaresuccessStandardLabel,
            darkContrast: ComponentDarkTokens.buttonSquaresuccessContrastLabel,
          ),
        );
    }
  }

  SquareButtonColors _getSecondaryColors(bool isLight, bool isStandard) {
    return SquareButtonColors(
      background: _getColorToken(
        isLight: isLight,
        isStandard: isStandard,
        lightStandard: _isPressed
            ? ComponentLightTokens.buttonSquaresecondaryStandardActive
            : _isHovered
            ? ComponentLightTokens.buttonSquaresecondaryStandardHover
            : ComponentLightTokens.buttonSquaresecondaryStandardDefault,
        lightContrast: _isPressed
            ? ComponentLightTokens.buttonSquaresecondaryContrastActive
            : _isHovered
            ? ComponentLightTokens.buttonSquaresecondaryContrastHover
            : ComponentLightTokens.buttonSquaresecondaryContrastDefault,
        darkStandard: _isPressed
            ? ComponentDarkTokens.buttonSquaresecondaryStandardActive
            : _isHovered
            ? ComponentDarkTokens.buttonSquaresecondaryStandardHover
            : ComponentDarkTokens.buttonSquaresecondaryStandardDefault,
        darkContrast: _isPressed
            ? ComponentDarkTokens.buttonSquaresecondaryContrastActive
            : _isHovered
            ? ComponentDarkTokens.buttonSquaresecondaryContrastHover
            : ComponentDarkTokens.buttonSquaresecondaryContrastDefault,
      ),
      border: _getColorToken(
        isLight: isLight,
        isStandard: isStandard,
        lightStandard: _isPressed
            ? ComponentLightTokens.buttonSquaresecondaryStandardBorderActive
            : ComponentLightTokens.buttonSquaresecondaryStandardBorder,
        lightContrast: _isPressed
            ? ComponentLightTokens.buttonSquaresecondaryContrastBorderActive
            : ComponentLightTokens.buttonSquaresecondaryContrastBorder,
        darkStandard: _isPressed
            ? ComponentDarkTokens.buttonSquaresecondaryStandardBorderActive
            : ComponentDarkTokens.buttonSquaresecondaryStandardBorder,
        darkContrast: _isPressed
            ? ComponentDarkTokens.buttonSquaresecondaryContrastBorderActive
            : ComponentDarkTokens.buttonSquaresecondaryContrastBorder,
      ),
      icon: _getColorToken(
        isLight: isLight,
        isStandard: isStandard,
        lightStandard: _isPressed
            ? ComponentLightTokens.buttonSquaresecondaryStandardIconActive
            : ComponentLightTokens.buttonSquaresecondaryStandardIcon,
        lightContrast: _isPressed
            ? ComponentLightTokens.buttonSquaresecondaryContrastIconActive
            : _isHovered
            ? ComponentLightTokens.buttonSquaresecondaryContrastIconHover
            : ComponentLightTokens.buttonSquaresecondaryContrastIconDefault,
        darkStandard: _isPressed
            ? ComponentDarkTokens.buttonSquaresecondaryStandardIconActive
            : ComponentDarkTokens.buttonSquaresecondaryStandardIcon,
        darkContrast: _isPressed
            ? ComponentDarkTokens.buttonSquaresecondaryContrastIconActive
            : _isHovered
            ? ComponentDarkTokens.buttonSquaresecondaryContrastIconHover
            : ComponentDarkTokens.buttonSquaresecondaryContrastIconDefault,
      ),
      label: _getColorToken(
        isLight: isLight,
        isStandard: isStandard,
        lightStandard: ComponentLightTokens.buttonSquaresecondaryStandardText,
        lightContrast: ComponentLightTokens.buttonSquaresecondaryContrastLabel,
        darkStandard: ComponentDarkTokens.buttonSquaresecondaryStandardText,
        darkContrast: ComponentDarkTokens.buttonSquaresecondaryContrastLabel,
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

    Widget iconContent = widget.icon;

    if (widget.isLoading) {
      iconContent = SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(colors.icon),
        ),
      );
    }

    final iconButtonContent = Container(
      width: _buttonSize,
      height: _buttonSize,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Center(
        child: IconTheme(
          data: IconThemeData(color: colors.icon, size: 24.0),
          child: iconContent,
        ),
      ),
    );

    final Widget iconButton = (_isDisabled && !widget.isLoading)
        ? DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: const Radius.circular(4.0),
              strokeWidth: _borderWidth,
              color: colors.border,
              dashPattern: const [4, 4],
              padding: EdgeInsets.zero,
            ),
            child: iconButtonContent,
          )
        : Container(
            width: _buttonSize,
            height: _buttonSize,
            decoration: BoxDecoration(
              color: colors.background,
              border: Border.all(color: colors.border, width: _borderWidth),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: IconTheme(
                data: IconThemeData(color: colors.icon, size: 24.0),
                child: iconContent,
              ),
            ),
          );

    Widget button;

    if (widget.label != null) {
      button = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconButton,
          SizedBox(width: _spacing),
          Text(
            widget.label!,
            style: TextStyle(
              color: colors.label,
              fontSize: _fontSize,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    } else {
      button = iconButton;
    }

    return MouseRegion(
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
        child: Opacity(
          opacity: _isDisabled && !widget.isLoading ? 0.5 : 1.0,
          child: button,
        ),
      ),
    );
  }
}

class SquareButtonColors {
  const SquareButtonColors({
    required this.background,
    required this.border,
    required this.icon,
    required this.label,
  });

  final Color background;
  final Color border;
  final Color icon;
  final Color label;
}
