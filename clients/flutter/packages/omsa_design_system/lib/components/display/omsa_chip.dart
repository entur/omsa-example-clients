import 'package:flutter/material.dart';

/// Chip variant types for the OMSA Design System
enum OmsaChipVariant { filled, outlined, elevated }

/// Semantic color types for chips
enum OmsaChipColor {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
  neutral,
}

/// A customizable chip component following OMSA Design System guidelines
///
/// This component extends Flutter's [Chip] widget to provide consistent
/// chip styling across the OMSA application with support for different
/// variants and semantic colors.
class OmsaChip extends StatelessWidget {
  const OmsaChip({
    super.key,
    required this.label,
    this.variant = OmsaChipVariant.filled,
    this.color = OmsaChipColor.neutral,
    this.icon,
    this.avatar,
    this.onDeleted,
    this.deleteIcon,
    this.onPressed,
    this.padding,
    this.customBackgroundColor,
    this.customTextColor,
    this.customBorderColor,
  });

  final Widget label;
  final OmsaChipVariant variant;
  final OmsaChipColor color;
  final Widget? icon;
  final Widget? avatar;
  final VoidCallback? onDeleted;
  final Widget? deleteIcon;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;

  // Allow custom colors to override semantic colors
  final Color? customBackgroundColor;
  final Color? customTextColor;
  final Color? customBorderColor;

  Color _getSemanticColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (color) {
      case OmsaChipColor.primary:
        return theme.colorScheme.primary;
      case OmsaChipColor.secondary:
        return theme.colorScheme.secondary;
      case OmsaChipColor.success:
        return Colors.green;
      case OmsaChipColor.warning:
        return Colors.orange;
      case OmsaChipColor.error:
        return theme.colorScheme.error;
      case OmsaChipColor.info:
        return Colors.blue;
      case OmsaChipColor.neutral:
        return theme.colorScheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final semanticColor = customBackgroundColor ?? _getSemanticColor(context);
    final iconColor = customTextColor ?? semanticColor;
    final theme = Theme.of(context);

    Widget chip;

    switch (variant) {
      case OmsaChipVariant.filled:
        chip = _buildActionableChip(
          context,
          backgroundColor: semanticColor.withValues(alpha: 0.12),
          labelStyle: TextStyle(color: iconColor, fontWeight: FontWeight.w500),
          iconColor: iconColor,
          side: BorderSide.none,
        );
        break;

      case OmsaChipVariant.outlined:
        chip = _buildActionableChip(
          context,
          backgroundColor: Colors.transparent,
          labelStyle: TextStyle(color: iconColor, fontWeight: FontWeight.w500),
          iconColor: iconColor,
          side: BorderSide(
            color: customBorderColor ?? semanticColor.withValues(alpha: 0.3),
            width: 1,
          ),
        );
        break;

      case OmsaChipVariant.elevated:
        chip = _buildActionableChip(
          context,
          backgroundColor: theme.colorScheme.surface,
          labelStyle: TextStyle(color: iconColor, fontWeight: FontWeight.w500),
          iconColor: iconColor,
          side: BorderSide.none,
          elevation: 2,
        );
        break;
    }

    return chip;
  }

  Widget _buildActionableChip(
    BuildContext context, {
    required Color backgroundColor,
    required TextStyle labelStyle,
    required Color iconColor,
    required BorderSide side,
    double elevation = 0,
  }) {
    // Apply icon color to the icon if provided
    final coloredIcon = icon != null
        ? IconTheme(
            data: IconThemeData(color: iconColor),
            child: icon!,
          )
        : null;

    if (onPressed != null) {
      return ActionChip(
        label: label,
        onPressed: onPressed,
        avatar:
            avatar ??
            (coloredIcon != null ? _IconAvatar(icon: coloredIcon) : null),
        backgroundColor: backgroundColor,
        labelStyle: labelStyle,
        side: side,
        elevation: elevation,
        padding: padding,
      );
    }

    return Chip(
      label: label,
      avatar:
          avatar ??
          (coloredIcon != null ? _IconAvatar(icon: coloredIcon) : null),
      backgroundColor: backgroundColor,
      labelStyle: labelStyle,
      side: side,
      elevation: elevation,
      padding: padding,
      deleteIcon: deleteIcon,
      onDeleted: onDeleted,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: side,
      ),
    );
  }
}

class _IconAvatar extends StatelessWidget {
  final Widget icon;

  const _IconAvatar({required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 18, height: 18, child: icon);
  }
}
