import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/layout/tag/omsa_tag_colors.dart';
import 'package:omsa_design_system/components/layout/tag/omsa_tag_dimensions.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/theme/app_dimensions.dart';

/// A tag component for displaying labels and metadata
class OmsaTag extends StatelessWidget {
  const OmsaTag({
    super.key,
    required this.child,
    this.mode = OmsaComponentMode.standard,
    this.compact = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  final Widget child;
  final OmsaComponentMode mode;
  final bool compact;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final colors = OmsaTagColors.fromContext(context, mode: mode);
    final dimensions = compact
        ? OmsaTagDimensions.compact
        : OmsaTagDimensions.standard;

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
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusesMedium),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            leadingIcon!,
            SizedBox(width: dimensions.iconSpacing),
          ],
          DefaultTextStyle(
            style: dimensions.textStyle.copyWith(color: colors.text),
            child: child,
          ),
          if (trailingIcon != null) ...[
            SizedBox(width: dimensions.iconSpacing),
            trailingIcon!,
          ],
        ],
      ),
    );
  }
}
