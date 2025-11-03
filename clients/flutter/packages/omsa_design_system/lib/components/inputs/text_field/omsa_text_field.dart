import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/inputs/text_field/omsa_text_field_colors.dart';
import 'package:omsa_design_system/components/inputs/text_field/omsa_text_field_decoration.dart';
import 'package:omsa_design_system/components/inputs/text_field/omsa_text_field_clear_button.dart';
import 'package:omsa_design_system/components/inputs/text_field/omsa_text_field_feedback.dart';

enum OmsaTextFieldVariant { none, success, negative, information, warning }

enum OmsaTextFieldSize { medium, large }

/// Text field component with floating label, variants, and prepend/append support
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

  /// TODO: Add support for labelTooltip
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
  bool _isHovered = false;

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
      // Clean up old controller if we created it
      if (oldWidget.controller == null) {
        _controller.removeListener(_onTextChange);
        _controller.dispose();
      } else {
        _controller.removeListener(_onTextChange);
      }
      _controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
      _controller.addListener(_onTextChange);
      _hasValue = _controller.text.isNotEmpty;
    }
    if (widget.focusNode != oldWidget.focusNode) {
      // Clean up old focus node if we created it
      if (oldWidget.focusNode == null) {
        _focusNode.removeListener(_onFocusChange);
        _focusNode.dispose();
      } else {
        _focusNode.removeListener(_onFocusChange);
      }
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    // Only dispose if we created them
    _controller.removeListener(_onTextChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.removeListener(_onFocusChange);
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

  @override
  Widget build(BuildContext context) {
    final colors = OmsaTextFieldColors.fromContext(
      context,
      mode: widget.mode,
      variant: widget.variant,
      disabled: widget.disabled,
      readOnly: widget.readOnly,
      isFocused: _isFocused,
      isHovered: _isHovered,
    );

    final minHeight = OmsaTextFieldDecorationBuilder.getMinHeight(widget.size);
    final decoration = OmsaTextFieldDecorationBuilder.buildDecoration(
      colors: colors,
      size: widget.size,
      isFocused: _isFocused,
      hint: widget.hint,
    );
    final textStyle = OmsaTextFieldDecorationBuilder.getTextStyle(
      colors: colors,
      size: widget.size,
    );
    final containerDecoration =
        OmsaTextFieldDecorationBuilder.buildContainerDecoration(
          colors: colors,
          isFocused: _isFocused,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          onEnter: widget.disabled || widget.readOnly
              ? null
              : (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: widget.disabled || widget.readOnly
                ? null
                : () => _focusNode.requestFocus(),
            child: Container(
              constraints: BoxConstraints(minHeight: minHeight),
              decoration: containerDecoration,
              child: _buildTextFieldContent(
                minHeight: minHeight,
                colors: colors,
                textStyle: textStyle,
                decoration: decoration,
              ),
            ),
          ),
        ),
        if (widget.feedback != null) ...[
          const SizedBox(height: AppSpacing.spaceExtraSmall2),
          OmsaTextFieldFeedback(
            text: widget.feedback!,
            variant: widget.variant,
          ),
        ],
      ],
    );
  }

  Widget _buildTextFieldContent({
    required double minHeight,
    required OmsaTextFieldColors colors,
    required TextStyle textStyle,
    required InputDecoration decoration,
  }) {
    return Stack(
      children: [
        _FloatingLabel(
          label: widget.label,
          required: widget.required,
          shouldFloat: _shouldFloatLabel,
          size: widget.size,
          colors: colors,
          hasPrepend: widget.prepend != null,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spaceDefault,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.prepend != null)
                  _PrependAppendWrapper(
                    colors: colors,
                    size: widget.size,
                    isAppend: false,
                    child: widget.prepend!,
                  ),
                Expanded(
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
                    style: textStyle,
                    decoration: decoration,
                  ),
                ),
                // Clear button or append widget
                if (widget.clearable &&
                    _hasValue &&
                    !widget.disabled &&
                    !widget.readOnly)
                  OmsaTextFieldClearButton(
                    onClear: _onClear,
                    iconColor: colors.icon,
                  )
                else if (widget.append != null)
                  _PrependAppendWrapper(
                    colors: colors,
                    size: widget.size,
                    isAppend: true,
                    child: widget.append!,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Floating label widget that animates position and size
class _FloatingLabel extends StatelessWidget {
  const _FloatingLabel({
    required this.label,
    required this.required,
    required this.shouldFloat,
    required this.size,
    required this.colors,
    required this.hasPrepend,
  });

  final String label;
  final bool required;
  final bool shouldFloat;
  final OmsaTextFieldSize size;
  final OmsaTextFieldColors colors;
  final bool hasPrepend;

  @override
  Widget build(BuildContext context) {
    final labelTop = OmsaTextFieldDecorationBuilder.getLabelTop(
      size: size,
      shouldFloat: shouldFloat,
    );
    final labelStyle = OmsaTextFieldDecorationBuilder.getLabelStyle(
      colors: colors,
      size: size,
      shouldFloat: shouldFloat,
    );

    // Calculate left offset (includes prepend widget spacing if present)
    final leftOffset =
        AppSpacing.spaceDefault + (hasPrepend ? 24 + AppSpacing.spaceSmall : 0);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      left: leftOffset,
      top: labelTop,
      child: IgnorePointer(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          style: labelStyle,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label),
              if (required) ...[const SizedBox(width: 4), const Text('*')],
            ],
          ),
        ),
      ),
    );
  }
}

/// Wrapper for prepend/append widgets with consistent styling
class _PrependAppendWrapper extends StatelessWidget {
  const _PrependAppendWrapper({
    required this.colors,
    required this.size,
    required this.isAppend,
    required this.child,
  });

  final OmsaTextFieldColors colors;
  final OmsaTextFieldSize size;
  final bool isAppend;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textStyle = OmsaTextFieldDecorationBuilder.getTextStyle(
      colors: colors,
      size: size,
    );

    return Padding(
      padding: EdgeInsets.only(
        left: isAppend ? AppSpacing.spaceSmall : 0,
        right: isAppend ? 0 : AppSpacing.spaceSmall,
      ),
      child: IconTheme(
        data: IconThemeData(color: colors.icon, size: 24),
        child: DefaultTextStyle(
          style: textStyle.copyWith(color: colors.icon),
          child: child,
        ),
      ),
    );
  }
}
