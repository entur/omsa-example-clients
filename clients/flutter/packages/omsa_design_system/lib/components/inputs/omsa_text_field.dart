import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omsa_design_system/theme/app_dimensions.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/theme/app_typography.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';

enum OmsaTextFieldVariant { none, success, negative, information, warning }

enum OmsaTextFieldSize { medium, large }

class OmsaTextField extends StatefulWidget {
  const OmsaTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.feedback,
    this.variant = OmsaTextFieldVariant.none,
    this.size = OmsaTextFieldSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.prepend,
    this.append,
    this.disabled = false,
    this.readOnly = false,
    this.required = false,
    this.clearable = false,
    this.disableLabelAnimation = false,
    this.labelTooltip,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.initialValue,
    this.autofocus = false,
    this.obscureText = false,
    this.focusNode,
  }) : assert(
         controller == null || initialValue == null,
         'Cannot provide both controller and initialValue',
       );

  final TextEditingController? controller;
  final String label;
  final String? hint;
  final String? feedback;
  final OmsaTextFieldVariant variant;
  final OmsaTextFieldSize size;
  final OmsaComponentMode mode;
  final Widget? prepend;
  final Widget? append;
  final bool disabled;
  final bool readOnly;
  final bool required;
  final bool clearable;
  final bool disableLabelAnimation;
  final String? labelTooltip;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String? initialValue;
  final bool autofocus;
  final bool obscureText;
  final FocusNode? focusNode;

  @override
  State<OmsaTextField> createState() => _OmsaTextFieldState();
}

class _OmsaTextFieldState extends State<OmsaTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _hasValue = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    _hasValue = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChange);
  }

  @override
  void didUpdateWidget(OmsaTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _controller.dispose();
      }
      _controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
      _controller.addListener(_onTextChange);
      _hasValue = _controller.text.isNotEmpty;
    }
    if (widget.focusNode != oldWidget.focusNode) {
      if (oldWidget.focusNode == null) {
        _focusNode.dispose();
      }
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTextChange() {
    final hasValue = _controller.text.isNotEmpty;
    if (hasValue != _hasValue) {
      setState(() {
        _hasValue = hasValue;
      });
    }
    widget.onChanged?.call(_controller.text);
  }

  void _onClear() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  bool get _shouldFloatLabel {
    return widget.disableLabelAnimation || _isFocused || _hasValue;
  }

  double get _minHeight {
    return widget.size == OmsaTextFieldSize.medium ? 48.0 : 64.0;
  }

  double get _fontSize {
    return widget.size == OmsaTextFieldSize.medium
        ? AppTypography.fontSizesLarge
        : AppTypography.fontSizesExtraLarge2;
  }

  double get _lineHeight {
    return widget.size == OmsaTextFieldSize.medium
        ? AppTypography.lineHeightsSmall
        : AppTypography.lineHeightsExtraLarge2;
  }

  _TextFieldColors _getColors(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;
    final isStandard = widget.mode == OmsaComponentMode.standard;

    Color borderDefault;
    Color borderInteractive;
    Color borderSuccess;
    Color borderNegative;
    Color fillDefault;
    Color fillDisabled;
    Color fillReadOnly;
    Color textContent;
    Color textLabel;
    Color textDisabled;
    Color icon;

    if (isLight) {
      if (isStandard) {
        borderDefault = ComponentLightTokens.formBaseformStandardBorderDefault;
        borderInteractive =
            ComponentLightTokens.formBaseformStandardBorderInteractive;
        borderSuccess = ComponentLightTokens.formBaseformStandardBorderSuccess;
        borderNegative =
            ComponentLightTokens.formBaseformStandardBorderNegative;
        fillDefault = ComponentLightTokens.formBaseformStandardFillDefault;
        fillDisabled = ComponentLightTokens.formBaseformStandardFillDisabled;
        fillReadOnly = ComponentLightTokens.formBaseformStandardFillReadOnly;
        textContent = ComponentLightTokens.formBaseformStandardTextContent;
        textLabel = ComponentLightTokens.formBaseformStandardTextLabel;
        textDisabled = ComponentLightTokens.formBaseformStandardTextdisabled;
        icon = ComponentLightTokens.formBaseformStandardIcon;
      } else {
        borderDefault = ComponentLightTokens.formBaseformContrastBorderDefault;
        borderInteractive =
            ComponentLightTokens.formBaseformContrastBorderInteractive;
        borderSuccess = ComponentLightTokens.formBaseformContrastBorderSuccess;
        borderNegative =
            ComponentLightTokens.formBaseformContrastBorderNegative;
        fillDefault = ComponentLightTokens.formBaseformContrastFillDefault;
        fillDisabled = ComponentLightTokens.formBaseformContrastFillDisabled;
        fillReadOnly = ComponentLightTokens.formBaseformContrastFillReadOnly;
        textContent = ComponentLightTokens.formBaseformContrastTextContent;
        textLabel = ComponentLightTokens.formBaseformContrastTextLabel;
        textDisabled = ComponentLightTokens.formBaseformContrastTextdisabled;
        icon = ComponentLightTokens.formBaseformContrastIcon;
      }
    } else {
      if (isStandard) {
        borderDefault = ComponentDarkTokens.formBaseformStandardBorderDefault;
        borderInteractive =
            ComponentDarkTokens.formBaseformStandardBorderInteractive;
        borderSuccess = ComponentDarkTokens.formBaseformStandardBorderSuccess;
        borderNegative = ComponentDarkTokens.formBaseformStandardBorderNegative;
        fillDefault = ComponentDarkTokens.formBaseformStandardFillDefault;
        fillDisabled = ComponentDarkTokens.formBaseformStandardFillDisabled;
        fillReadOnly = ComponentDarkTokens.formBaseformStandardFillReadOnly;
        textContent = ComponentDarkTokens.formBaseformStandardTextContent;
        textLabel = ComponentDarkTokens.formBaseformStandardTextLabel;
        textDisabled = ComponentDarkTokens.formBaseformStandardTextdisabled;
        icon = ComponentDarkTokens.formBaseformStandardIcon;
      } else {
        borderDefault = ComponentDarkTokens.formBaseformContrastBorderDefault;
        borderInteractive =
            ComponentDarkTokens.formBaseformContrastBorderInteractive;
        borderSuccess = ComponentDarkTokens.formBaseformContrastBorderSuccess;
        borderNegative = ComponentDarkTokens.formBaseformContrastBorderNegative;
        fillDefault = ComponentDarkTokens.formBaseformContrastFillDefault;
        fillDisabled = ComponentDarkTokens.formBaseformContrastFillDisabled;
        fillReadOnly = ComponentDarkTokens.formBaseformContrastFillReadOnly;
        textContent = ComponentDarkTokens.formBaseformContrastTextContent;
        textLabel = ComponentDarkTokens.formBaseformContrastTextLabel;
        textDisabled = ComponentDarkTokens.formBaseformContrastTextdisabled;
        icon = ComponentDarkTokens.formBaseformContrastIcon;
      }
    }

    Color borderColor;
    if (widget.disabled || widget.readOnly) {
      borderColor = Colors.transparent;
    } else if (widget.variant == OmsaTextFieldVariant.success) {
      borderColor = borderSuccess;
    } else if (widget.variant == OmsaTextFieldVariant.negative) {
      borderColor = borderNegative;
    } else if (_isFocused) {
      borderColor = borderInteractive;
    } else {
      borderColor = borderDefault;
    }

    final fillColor = widget.disabled
        ? fillDisabled
        : widget.readOnly
        ? fillReadOnly
        : fillDefault;

    final textColor = widget.disabled ? textDisabled : textContent;

    return _TextFieldColors(
      border: borderColor,
      borderInteractive: borderInteractive,
      fill: fillColor,
      text: textColor,
      label: widget.disabled ? textDisabled : textLabel,
      icon: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: widget.disabled || widget.readOnly
              ? null
              : () => _focusNode.requestFocus(),
          child: Container(
            constraints: BoxConstraints(minHeight: _minHeight),
            decoration: BoxDecoration(
              color: colors.fill,
              borderRadius: AppDimensions.borderRadiusMedium,
              border: Border.all(
                color: colors.border,
                width: AppDimensions.borderWidthsMedium,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: AppSpacing.spaceDefault,
                  top: _shouldFloatLabel
                      ? (widget.size == OmsaTextFieldSize.medium ? 6.0 : 8.0)
                      : (widget.size == OmsaTextFieldSize.medium ? 16.0 : 20.0),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    style: TextStyle(
                      color: colors.label,
                      fontSize: _shouldFloatLabel
                          ? AppTypography.fontSizesSmall
                          : _fontSize,
                      height: _shouldFloatLabel
                          ? (AppTypography.lineHeightsSmall /
                                AppTypography.fontSizesSmall)
                          : (_lineHeight / _fontSize),
                      fontWeight: AppTypography.fontWeightsBody,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(widget.label),
                        if (widget.required) ...[
                          const SizedBox(width: 4),
                          const Text('*'),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spaceDefault,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.prepend != null) ...[
                        IconTheme(
                          data: IconThemeData(color: colors.icon, size: 24),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: colors.icon,
                              fontSize: _fontSize,
                              height: _lineHeight / _fontSize,
                            ),
                            child: widget.prepend!,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.spaceSmall),
                      ],
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: widget.size == OmsaTextFieldSize.medium
                                ? 20.0
                                : 24.0,
                            bottom: AppSpacing.spaceExtraSmall2,
                          ),
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            enabled: !widget.disabled,
                            readOnly: widget.readOnly,
                            autofocus: widget.autofocus,
                            obscureText: widget.obscureText,
                            maxLines: widget.maxLines,
                            maxLength: widget.maxLength,
                            keyboardType: widget.keyboardType,
                            textInputAction: widget.textInputAction,
                            inputFormatters: widget.inputFormatters,
                            onSubmitted: widget.onSubmitted,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: _fontSize,
                              height: _lineHeight / _fontSize,
                              fontWeight: AppTypography.fontWeightsBody,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: _isFocused ? widget.hint : null,
                              hintStyle: TextStyle(
                                color: colors.label,
                                fontSize: _fontSize,
                                height: _lineHeight / _fontSize,
                              ),
                              counterText: '',
                            ),
                          ),
                        ),
                      ),
                      if (widget.clearable &&
                          _hasValue &&
                          !widget.disabled &&
                          !widget.readOnly) ...[
                        Container(
                          width: 1,
                          height: 24,
                          margin: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.spaceSmall,
                          ),
                          color: colors.icon,
                        ),
                        Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                          child: InkWell(
                            onTap: _onClear,
                            borderRadius: BorderRadius.circular(24),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                AppSpacing.spaceExtraSmall,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 16,
                                color: colors.icon,
                              ),
                            ),
                          ),
                        ),
                      ] else if (widget.append != null) ...[
                        const SizedBox(width: AppSpacing.spaceSmall),
                        IconTheme(
                          data: IconThemeData(color: colors.icon, size: 24),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: colors.icon,
                              fontSize: _fontSize,
                              height: _lineHeight / _fontSize,
                            ),
                            child: widget.append!,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.feedback != null) ...[
          const SizedBox(height: AppSpacing.spaceExtraSmall),
          _FeedbackText(text: widget.feedback!, variant: widget.variant),
        ],
      ],
    );
  }
}

class _TextFieldColors {
  const _TextFieldColors({
    required this.border,
    required this.borderInteractive,
    required this.fill,
    required this.text,
    required this.label,
    required this.icon,
  });

  final Color border;
  final Color borderInteractive;
  final Color fill;
  final Color text;
  final Color label;
  final Color icon;
}

class _FeedbackText extends StatelessWidget {
  const _FeedbackText({required this.text, required this.variant});

  final String text;
  final OmsaTextFieldVariant variant;

  IconData? get _icon {
    switch (variant) {
      case OmsaTextFieldVariant.success:
        return Icons.check_circle;
      case OmsaTextFieldVariant.negative:
        return Icons.error;
      case OmsaTextFieldVariant.warning:
        return Icons.warning;
      case OmsaTextFieldVariant.information:
      case OmsaTextFieldVariant.none:
        return null;
    }
  }

  Color _getIconColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    switch (variant) {
      case OmsaTextFieldVariant.success:
        return isLight
            ? ComponentLightTokens.formBaseformStandardBorderSuccess
            : ComponentDarkTokens.formBaseformStandardBorderSuccess;
      case OmsaTextFieldVariant.negative:
        return isLight
            ? ComponentLightTokens.formBaseformStandardBorderNegative
            : ComponentDarkTokens.formBaseformStandardBorderNegative;
      case OmsaTextFieldVariant.warning:
        return isLight
            ? ComponentLightTokens.formBaseformStandardTextLabel
            : ComponentDarkTokens.formBaseformStandardTextLabel;
      case OmsaTextFieldVariant.information:
      case OmsaTextFieldVariant.none:
        return isLight
            ? ComponentLightTokens.formBaseformStandardTextLabel
            : ComponentDarkTokens.formBaseformStandardTextLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_icon != null) ...[
          Icon(_icon, size: 16, color: _getIconColor(context)),
          const SizedBox(width: 4),
        ],
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: AppTypography.fontSizesSmall,
              height:
                  AppTypography.lineHeightsSmall / AppTypography.fontSizesSmall,
              color: _getIconColor(context),
              fontWeight: AppTypography.fontWeightsBody,
            ),
          ),
        ),
      ],
    );
  }
}
