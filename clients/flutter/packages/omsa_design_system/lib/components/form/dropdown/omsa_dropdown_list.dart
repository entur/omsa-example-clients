import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/form/dropdown/omsa_dropdown_list_colors.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/theme/app_typography.dart';
import 'package:omsa_design_system/theme/app_dimensions.dart';
import 'package:omsa_design_system/components/form/dropdown/omsa_dropdown_item.dart';
import 'package:omsa_design_system/components/form/text_field/omsa_text_field_colors.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';

class OmsaDropdownList<T> extends StatelessWidget {
  const OmsaDropdownList({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    required this.colors,
    required this.isLoading,
    this.loadingText = 'Loading...',
    this.noMatchesText = 'No matches',
    this.highlightedIndex = -1,
    this.mode = OmsaComponentMode.standard,
  });

  final List<OmsaDropdownItem<T>> items;
  final OmsaDropdownItem<T>? selectedItem;
  final ValueChanged<OmsaDropdownItem<T>> onItemSelected;
  final OmsaTextFieldColors colors;
  final bool isLoading;
  final String loadingText;
  final String noMatchesText;
  final int highlightedIndex;
  final OmsaComponentMode mode;

  @override
  Widget build(BuildContext context) {
    final menuColors = OmsaDropdownListColors.fromContext(context, mode: mode);

    return Container(
      constraints: const BoxConstraints(maxHeight: 320.0),
      decoration: BoxDecoration(
        color: menuColors.background,
        borderRadius: AppDimensions.borderRadiusMedium,
        border: Border.all(
          color: menuColors.border,
          width: AppDimensions.borderWidthsMedium,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: _buildContent(menuColors),
    );
  }

  Widget _buildContent(OmsaDropdownListColors menuColors) {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.spaceDefault),
        child: Text(
          loadingText,
          style: TextStyle(
            color: menuColors.text,
            fontSize: AppTypography.fontSizesLarge,
            height:
                AppTypography.lineHeightsMedium / AppTypography.fontSizesLarge,
          ),
        ),
      );
    }

    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.spaceDefault),
        child: Text(
          noMatchesText,
          style: TextStyle(
            color: menuColors.text,
            fontSize: AppTypography.fontSizesLarge,
            height:
                AppTypography.lineHeightsMedium / AppTypography.fontSizesLarge,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = selectedItem == item;
        final isHighlighted = highlightedIndex == index;

        return _DropdownListItem(
          item: item,
          isSelected: isSelected,
          isHighlighted: isHighlighted,
          menuColors: menuColors,
          onTap: () => onItemSelected(item),
        );
      },
    );
  }
}

class _DropdownListItem<T> extends StatefulWidget {
  const _DropdownListItem({
    required this.item,
    required this.isSelected,
    required this.isHighlighted,
    required this.menuColors,
    required this.onTap,
  });

  final OmsaDropdownItem<T> item;
  final bool isSelected;
  final bool isHighlighted;
  final OmsaDropdownListColors menuColors;
  final VoidCallback onTap;

  @override
  State<_DropdownListItem<T>> createState() => _DropdownListItemState<T>();
}

class _DropdownListItemState<T> extends State<_DropdownListItem<T>> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.isSelected || widget.isHighlighted || _isHovered
        ? widget.menuColors.itemHoverBackground
        : widget.menuColors.itemBackground;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spaceDefault,
            vertical: AppSpacing.spaceSmall,
          ),
          color: backgroundColor,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.item.label,
                  style: TextStyle(
                    color: widget.menuColors.text,
                    fontSize: AppTypography.fontSizesLarge,
                    height:
                        AppTypography.lineHeightsMedium /
                        AppTypography.fontSizesLarge,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.item.icons != null) ...[
                const SizedBox(width: AppSpacing.spaceSmall),
                ...widget.item.icons!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
