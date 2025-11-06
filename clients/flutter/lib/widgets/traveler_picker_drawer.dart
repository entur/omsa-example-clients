import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';
import 'package:omsa_demo_app/models/traveler_model.dart';

class TravelerPickerResult {
  final List<Traveler> travelers;

  TravelerPickerResult({required this.travelers});

  String get displayText {
    if (travelers.isEmpty) return 'No travelers';

    final hasDefault = travelers.any((t) => t.isDefaultTraveler);

    if (travelers.length == 1 && hasDefault) {
      return 'You (${travelers.first.category.label})';
    }

    // Group by category
    final grouped = <TravelerCategory, int>{};
    for (final traveler in travelers) {
      grouped[traveler.category] = (grouped[traveler.category] ?? 0) + 1;
    }

    final parts = <String>[];
    for (final entry in grouped.entries) {
      final count = entry.value;
      final label = entry.key.label;
      parts.add('$count $label${count > 1 ? 's' : ''}');
    }

    return parts.join(', ');
  }
}

class TravelerPickerDrawer extends StatefulWidget {
  final List<Traveler> initialTravelers;

  const TravelerPickerDrawer({super.key, required this.initialTravelers});

  @override
  State<TravelerPickerDrawer> createState() => _TravelerPickerDrawerState();

  static Future<TravelerPickerResult?> show(
    BuildContext context, {
    required List<Traveler> initialTravelers,
  }) {
    return showModalBottomSheet<TravelerPickerResult>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: context.tokens.frameTint,
      builder: (context) =>
          TravelerPickerDrawer(initialTravelers: initialTravelers),
    );
  }
}

class _TravelerPickerDrawerState extends State<TravelerPickerDrawer> {
  late List<Traveler> _travelers;
  String? _expandedTravelerId;

  @override
  void initState() {
    super.initState();
    _travelers = List.from(widget.initialTravelers);
  }

  void _addTraveler() {
    setState(() {
      final newTraveler = Traveler(age: 22);
      _travelers.add(newTraveler);
      _expandedTravelerId = newTraveler.id;
    });
  }

  void _removeTraveler(String id) {
    if (_travelers.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('At least one traveler is required')),
      );
      return;
    }

    setState(() {
      _travelers.removeWhere((t) => t.id == id);
      if (_expandedTravelerId == id) {
        _expandedTravelerId = null;
      }
    });
  }

  void _updateTraveler(Traveler updated) {
    setState(() {
      final index = _travelers.indexWhere((t) => t.id == updated.id);
      if (index != -1) {
        _travelers[index] = updated;
      }
    });
  }

  void _toggleExpanded(String id) {
    setState(() {
      _expandedTravelerId = _expandedTravelerId == id ? null : id;
    });
  }

  void _submit() {
    Navigator.of(context).pop(TravelerPickerResult(travelers: _travelers));
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: tokens.strokeSubdued,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Travelers',
                  style: AppTypography.textExtraLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                OmsaIconButton(
                  icon: OmsaIcons.CloseSmall(),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Traveler list
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _travelers.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final traveler = _travelers[index];
                final isExpanded = _expandedTravelerId == traveler.id;

                return _TravelerCard(
                  traveler: traveler,
                  isExpanded: isExpanded,
                  canRemove: _travelers.length > 1,
                  onTap: () => _toggleExpanded(traveler.id),
                  onRemove: () => _removeTraveler(traveler.id),
                  onUpdate: _updateTraveler,
                );
              },
            ),

            const SizedBox(height: 16),

            // Add traveler button
            OmsaButton(
              onPressed: _addTraveler,
              variant: OmsaButtonVariant.secondary,
              width: OmsaButtonWidth.fluid,
              leadingIcon: OmsaIcons.Add(size: 20),
              child: const Text('Add traveler'),
            ),

            const SizedBox(height: 32),

            OmsaButton(
              onPressed: _submit,
              width: OmsaButtonWidth.fluid,
              child: const Text('Confirm travelers'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TravelerCard extends StatefulWidget {
  final Traveler traveler;
  final bool isExpanded;
  final bool canRemove;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final ValueChanged<Traveler> onUpdate;

  const _TravelerCard({
    required this.traveler,
    required this.isExpanded,
    required this.canRemove,
    required this.onTap,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  State<_TravelerCard> createState() => _TravelerCardState();
}

class _TravelerCardState extends State<_TravelerCard> {
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _ageController = TextEditingController(
      text: widget.traveler.age.toString(),
    );
  }

  @override
  void didUpdateWidget(_TravelerCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.traveler.id != widget.traveler.id) {
      _ageController.text = widget.traveler.age.toString();
    }
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  void _updateAge(String value) {
    final age = int.tryParse(value);
    if (age != null && age >= 0 && age <= 120) {
      widget.onUpdate(widget.traveler.copyWith(age: age));
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final category = widget.traveler.category;

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: tokens.strokeSubdued, width: 2)
        ),
        child: Column(
      children: [
        InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.traveler.displayName,
                        style: AppTypography.textMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.traveler.displaySummary,
                        style: AppTypography.textSmall.copyWith(
                          color: tokens.textSubdued,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.isExpanded
                      ? OmsaIcons.UpArrow()
                      : OmsaIcons.DownArrow(),
              ],
            ),
          ),
        ),
        if (widget.isExpanded) ...[
          Divider(height: 1, color: tokens.strokeSubduedAlt, indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OmsaTextField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        label: 'Age',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: _updateAge,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: tokens.frameTint,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.label,
                            style: AppTypography.textMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            category.subtitle,
                            style: AppTypography.textSmall.copyWith(
                              color: tokens.textSubdued,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Discounts & entitlements',
                  style: AppTypography.textMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  spacing: 8,
                  children: [
                    OmsaChoiceChip(label: Text("Student"), value: "Student", disabled: true),
                    OmsaChoiceChip(label: Text("Military"), value: "Military"),
                    Text("Coming soon...", style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal
                    ))
                  ]
                ),
                if (widget.canRemove) ...[
                  const SizedBox(height: 16),
                  OmsaButton(
                    onPressed: widget.onRemove,
                    variant: OmsaButtonVariant.negative,
                    width: OmsaButtonWidth.fluid,
                    leadingIcon: OmsaIcons.Delete(size: 20),
                    child: Text(
                      widget.traveler.isDefaultTraveler
                          ? 'Remove (buy for someone else)'
                          : 'Remove traveler',
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    ));
  }
}
