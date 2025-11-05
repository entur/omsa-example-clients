import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/layout/badge/omsa_badge_colors.dart';
import 'package:omsa_design_system/components/layout/badge/omsa_badge_dimensions.dart';
import 'package:omsa_design_system/components/layout/badge/omsa_badge_enums.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';

class OmsaBadge extends StatelessWidget {
  const OmsaBadge({
    super.key,
    required this.variant,
    this.child,
    this.mode = OmsaComponentMode.standard,
    this.type = OmsaBadgeType.status,
    this.showZero = false,
    this.max = 99,
    this.hide = false,
  });

  final OmsaBadgeVariant variant;
  final dynamic child;
  final OmsaComponentMode mode;
  final OmsaBadgeType type;
  final bool showZero;
  final int max;
  final bool hide;

  bool get _shouldHide {
    if (hide) return true;
    if (child == null) return true;
    if (child == 0 && !showZero) return true;
    return false;
  }

  String get _displayValue {
    if (child is int) {
      final numValue = child as int;
      return numValue > max ? '$max+' : numValue.toString();
    }
    return child.toString();
  }

  @override
  Widget build(BuildContext context) {
    final colors = OmsaBadgeColors.fromContext(
      context,
      variant: variant,
      mode: mode,
    );
    final dimensions = OmsaBadgeDimensions.forType(type);

    if (_shouldHide) {
      return const SizedBox.shrink();
    }

    Widget content;
    switch (type) {
      case OmsaBadgeType.bullet:
        content = _buildBulletBadge(colors, dimensions);
        break;
      case OmsaBadgeType.status:
        content = _buildStatusBadge(colors, dimensions);
        break;
      case OmsaBadgeType.notification:
        content = _buildNotificationBadge(colors, dimensions);
        break;
    }

    return AnimatedOpacity(
      opacity: _shouldHide ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: content,
    );
  }

  Widget _buildStatusBadge(
    OmsaBadgeColors colors,
    OmsaBadgeDimensions dimensions,
  ) {
    return Container(
      constraints: BoxConstraints(
        minWidth: dimensions.minWidth,
        minHeight: dimensions.height,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: dimensions.horizontalPadding,
        vertical: dimensions.verticalPadding,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        border: colors.border != null
            ? Border.all(color: colors.border!, width: dimensions.borderWidth)
            : null,
        borderRadius: BorderRadius.circular(dimensions.borderRadius),
      ),
      child: DefaultTextStyle(
        style: dimensions.textStyle.copyWith(
          color: colors.text,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
        child: child is Widget
            ? child
            : Text(_displayValue.toUpperCase(), textAlign: TextAlign.center),
      ),
    );
  }

  Widget _buildNotificationBadge(
    OmsaBadgeColors colors,
    OmsaBadgeDimensions dimensions,
  ) {
    return Container(
      constraints: BoxConstraints(
        minWidth: dimensions.minWidth,
        minHeight: dimensions.height,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: dimensions.horizontalPadding,
        vertical: dimensions.verticalPadding,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        border: colors.border != null
            ? Border.all(color: colors.border!, width: dimensions.borderWidth)
            : null,
        borderRadius: BorderRadius.circular(dimensions.borderRadius),
      ),
      child: Center(
        child: DefaultTextStyle(
          style: dimensions.textStyle.copyWith(
            color: colors.text,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
          child: child is Widget ? child : Text(_displayValue),
        ),
      ),
    );
  }

  Widget _buildBulletBadge(
    OmsaBadgeColors colors,
    OmsaBadgeDimensions dimensions,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: OmsaBadgeDimensions.bulletSize,
          height: OmsaBadgeDimensions.bulletSize,
          decoration: BoxDecoration(
            color: colors.bullet ?? colors.background,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8.0),
        DefaultTextStyle(
          style: dimensions.textStyle.copyWith(color: colors.text),
          child: child is Widget ? child : Text(_displayValue),
        ),
      ],
    );
  }
}
