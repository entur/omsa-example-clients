import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/inputs/segmented_control/omsa_segmented_choice.dart';
import 'package:omsa_design_system/components/inputs/segmented_control/omsa_segmented_control_colors.dart';
import 'package:omsa_design_system/components/inputs/segmented_control/omsa_segmented_control_dimensions.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/theme/app_typography.dart';

class _OptionalArgument<T> {
  _OptionalArgument._(this.value, this.isProvided);
  _OptionalArgument.absent() : this._(null, false);
  _OptionalArgument.present(T? value) : this._(value, true);

  final T? value;
  final bool isProvided;
}

const Object _optionalArgumentSentinel = Object();

_OptionalArgument<T> _optionalArgumentFrom<T>(Object? candidate) {
  if (identical(candidate, _optionalArgumentSentinel)) {
    return _OptionalArgument<T>.absent();
  }
  return _OptionalArgument<T>.present(candidate as T?);
}

enum OmsaSegmentedControlSize { medium, large }

class OmsaSegmentedControl extends StatefulWidget {
  OmsaSegmentedControl({
    super.key,
    this.label,
    this.name,
    required this.children,
    Object? value = _optionalArgumentSentinel,
    this.defaultValue,
    this.onChanged,
    this.size = OmsaSegmentedControlSize.medium,
    this.mode = OmsaComponentMode.standard,
    this.className,
    Object? selectedValue = _optionalArgumentSentinel,
  }) : assert(
         children.length >= 2,
         'OmsaSegmentedControl requires at least two choices.',
       ),
       assert(
         identical(value, _optionalArgumentSentinel) || defaultValue == null,
         'Do not provide both value and defaultValue.',
       ),
       assert(
         identical(selectedValue, _optionalArgumentSentinel) ||
             identical(value, _optionalArgumentSentinel),
         'Use either value or selectedValue, not both.',
       ),
       _valueArg = _optionalArgumentFrom<String?>(value),
       _selectedValueArg = _optionalArgumentFrom<String?>(selectedValue);

  final String? label;
  final String? name;
  final String? className;
  final List<OmsaSegmentedChoice> children;
  final _OptionalArgument<String?> _valueArg;
  final _OptionalArgument<String?> _selectedValueArg;
  final String? defaultValue;
  final ValueChanged<String?>? onChanged;
  final OmsaSegmentedControlSize size;
  final OmsaComponentMode mode;

  bool get _hasDeprecatedSelected => _selectedValueArg.isProvided;

  bool get _isTrulyControlled => _hasDeprecatedSelected || _valueArg.isProvided;

  String? get _controlledValue {
    if (_hasDeprecatedSelected) {
      return _selectedValueArg.value;
    }
    if (_valueArg.isProvided) {
      return _valueArg.value;
    }
    return null;
  }

  @override
  State<OmsaSegmentedControl> createState() => _OmsaSegmentedControlState();
}

class _OmsaSegmentedControlState extends State<OmsaSegmentedControl> {
  String? _internalValue;

  List<OmsaSegmentedChoice> get _choices => widget.children;

  @override
  void initState() {
    super.initState();
    _internalValue = widget._isTrulyControlled
        ? widget._controlledValue
        : widget.defaultValue;
  }

  @override
  void didUpdateWidget(covariant OmsaSegmentedControl oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget._isTrulyControlled) {
      _internalValue = widget._controlledValue;
    } else if (oldWidget._isTrulyControlled && !widget._isTrulyControlled) {
      _internalValue = widget.defaultValue;
    } else if (!widget._isTrulyControlled &&
        widget.defaultValue != oldWidget.defaultValue) {
      _internalValue = widget.defaultValue;
    }
  }

  void _handleActivate(int index) {
    final choice = _choices[index];
    final nextValue = choice.value;
    if (!widget._isTrulyControlled) {
      setState(() {
        _internalValue = nextValue;
      });
    }
    widget.onChanged?.call(nextValue);
    choice.onChanged?.call(nextValue);
  }

  String? get _currentValue =>
      widget._isTrulyControlled ? widget._controlledValue : _internalValue;

  @override
  Widget build(BuildContext context) {
    final colors = OmsaSegmentedControlColors.fromContext(
      context,
      mode: widget.mode,
    );

    final label = widget.label;
    final labelWidget = label == null
        ? null
        : Text(
            label,
            style: AppTypography.textMedium.copyWith(
              fontWeight: AppTypography.fontWeightsHeading,
              color: colors.labelColor,
            ),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelWidget != null) ...[
          labelWidget,
          const SizedBox(height: OmsaSegmentedControlDimensions.labelSpacing),
        ],
        Semantics(
          container: true,
          label: label ?? widget.name,
          explicitChildNodes: true,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.containerBackground,
              borderRadius: BorderRadius.circular(
                OmsaSegmentedControlDimensions.containerBorderRadius,
              ),
            ),
            child: FocusTraversalGroup(
              policy: OrderedTraversalPolicy(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_choices.length, (index) {
                  final choice = _choices[index];
                  final selected = _currentValue == choice.value;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        OmsaSegmentedControlDimensions.choiceSpacing,
                      ),
                      child: _OmsaSegmentedChoiceButton(
                        value: choice.value,
                        colors: colors,
                        size: widget.size,
                        selected: selected,
                        onActivate: () => _handleActivate(index),
                        child: choice.child,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OmsaSegmentedChoiceButton extends StatefulWidget {
  const _OmsaSegmentedChoiceButton({
    required this.value,
    required this.child,
    required this.colors,
    required this.size,
    required this.selected,
    required this.onActivate,
  });

  final String value;
  final Widget child;
  final OmsaSegmentedControlColors colors;
  final OmsaSegmentedControlSize size;
  final bool selected;
  final VoidCallback onActivate;

  @override
  State<_OmsaSegmentedChoiceButton> createState() =>
      _OmsaSegmentedChoiceButtonState();
}

class _OmsaSegmentedChoiceButtonState
    extends State<_OmsaSegmentedChoiceButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  void _handleActivate() {
    widget.onActivate();
  }

  Color _backgroundColor() {
    if (widget.selected) {
      return widget.colors.choiceBackgroundSelected;
    }
    if (_isHovered) {
      return widget.colors.choiceBackgroundHover;
    }
    return widget.colors.choiceBackground;
  }

  TextStyle _textStyle() {
    final baseStyle = widget.size == OmsaSegmentedControlSize.large
        ? AppTypography.textLarge
        : AppTypography.textMedium;
    final color = widget.selected
        ? widget.colors.choiceTextSelected
        : widget.colors.choiceText;
    return baseStyle.copyWith(color: color);
  }

  double get _height => widget.size == OmsaSegmentedControlSize.large
      ? OmsaSegmentedControlDimensions.largeHeight
      : OmsaSegmentedControlDimensions.mediumHeight;

  double get _verticalPadding => widget.size == OmsaSegmentedControlSize.large
      ? OmsaSegmentedControlDimensions.largeVerticalPadding
      : OmsaSegmentedControlDimensions.mediumVerticalPadding;

  @override
  Widget build(BuildContext context) {
    final boxShadows = <BoxShadow>[
      if (_isFocused) ...widget.colors.focusShadows,
      if (widget.selected) ...widget.colors.selectedShadows,
    ];
    final textStyle = _textStyle();

    return Semantics(
      selected: widget.selected,
      inMutuallyExclusiveGroup: true,
      button: true,
      child: FocusableActionDetector(
        onShowFocusHighlight: (value) {
          if (_isFocused != value) {
            setState(() => _isFocused = value);
          }
        },
        onShowHoverHighlight: (value) {
          if (_isHovered != value) {
            setState(() => _isHovered = value);
          }
        },
        mouseCursor: SystemMouseCursors.click,
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              _handleActivate();
              return null;
            },
          ),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _handleActivate,
          child: AnimatedContainer(
            duration: OmsaSegmentedControlDimensions.animationDuration,
            curve: Curves.easeInOut,
            height: _height,
            padding: EdgeInsets.symmetric(
              vertical: _verticalPadding,
              horizontal: OmsaSegmentedControlDimensions.horizontalPadding,
            ),
            decoration: BoxDecoration(
              color: _backgroundColor(),
              borderRadius: BorderRadius.circular(
                OmsaSegmentedControlDimensions.choiceBorderRadius,
              ),
              boxShadow: boxShadows.isEmpty ? null : boxShadows,
            ),
            alignment: Alignment.center,
            child: DefaultTextStyle(
              style: textStyle,
              textAlign: TextAlign.center,
              child: IconTheme(
                data: IconThemeData(color: textStyle.color),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
