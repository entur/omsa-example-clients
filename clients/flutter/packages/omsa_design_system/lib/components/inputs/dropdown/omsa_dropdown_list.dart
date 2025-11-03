import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/app_spacing.dart';
import 'package:omsa_design_system/theme/app_typography.dart';
import 'package:omsa_design_system/theme/app_dimensions.dart';
import 'package:omsa_design_system/components/inputs/dropdown/omsa_dropdown_item.dart';
import 'package:omsa_design_system/components/inputs/text_field/omsa_text_field_colors.dart';

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
  });

  final List<OmsaDropdownItem<T>> items;
  final OmsaDropdownItem<T>? selectedItem;
  final ValueChanged<OmsaDropdownItem<T>> onItemSelected;
  final OmsaTextFieldColors colors;
  final bool isLoading;
  final String loadingText;
  final String noMatchesText;
  final int highlightedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 320.0,
      ),
      decoration: BoxDecoration(
        color: colors.fill,
        borderRadius: AppDimensions.borderRadiusMedium,
        border: Border.all(
          color: colors.border,
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
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.spaceDefault),
        child: Text(
          loadingText,
          style: TextStyle(
            color: colors.text,
            fontSize: AppTypography.fontSizesLarge,
            height: AppTypography.lineHeightsSmall / AppTypography.fontSizesLarge,
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
            color: colors.text,
            fontSize: AppTypography.fontSizesLarge,
            height: AppTypography.lineHeightsSmall / AppTypography.fontSizesLarge,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceExtraSmall2),
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
          colors: colors,
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
    required this.colors,
    required this.onTap,
  });

  final OmsaDropdownItem<T> item;
  final bool isSelected;
  final bool isHighlighted;
  final OmsaTextFieldColors colors;
  final VoidCallback onTap;

  @override
  State<_DropdownListItem<T>> createState() => _DropdownListItemState<T>();
}

class _DropdownListItemState<T> extends State<_DropdownListItem<T>> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isSelected || widget.isHighlighted || _isHovered
        ? widget.colors.borderInteractive.withValues(alpha: 0.1)
        : Colors.transparent;

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
                    color: widget.colors.text,
                    fontSize: AppTypography.fontSizesLarge,
                    height: AppTypography.lineHeightsSmall /
                        AppTypography.fontSizesLarge,
                    fontWeight: widget.isSelected
                        ? FontWeight.w600
                        : AppTypography.fontWeightsBody,
                  ),
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