import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';

class TravelerPickerResult {
  final int adults;
  final int children;
  final int infants;

  TravelerPickerResult({this.adults = 1, this.children = 0, this.infants = 0});

  int get totalTravelers => adults + children + infants;

  String get displayText {
    final parts = <String>[];
    if (adults > 0) parts.add('$adults Adult${adults > 1 ? 's' : ''}');
    if (children > 0) parts.add('$children Child${children > 1 ? 'ren' : ''}');
    if (infants > 0) parts.add('$infants Infant${infants > 1 ? 's' : ''}');
    return parts.join(', ');
  }
}

class TravelerPickerDrawer extends StatefulWidget {
  final int initialAdults;
  final int initialChildren;
  final int initialInfants;

  const TravelerPickerDrawer({
    super.key,
    this.initialAdults = 1,
    this.initialChildren = 0,
    this.initialInfants = 0,
  });

  @override
  State<TravelerPickerDrawer> createState() => _TravelerPickerDrawerState();

  static Future<TravelerPickerResult?> show(
    BuildContext context, {
    int initialAdults = 1,
    int initialChildren = 0,
    int initialInfants = 0,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    return showModalBottomSheet<TravelerPickerResult>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: isLight
          ? Colors.transparent
          : BaseDarkTokens.frameElevated,
      builder: (context) => TravelerPickerDrawer(
        initialAdults: initialAdults,
        initialChildren: initialChildren,
        initialInfants: initialInfants,
      ),
    );
  }
}

class _TravelerPickerDrawerState extends State<TravelerPickerDrawer> {
  late int _adults;
  late int _children;
  late int _infants;

  @override
  void initState() {
    super.initState();
    _adults = widget.initialAdults;
    _children = widget.initialChildren;
    _infants = widget.initialInfants;
  }

  void _submit() {
    Navigator.of(context).pop(
      TravelerPickerResult(
        adults: _adults,
        children: _children,
        infants: _infants,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    return Container(
      decoration: BoxDecoration(
        color: isLight ? BaseLightTokens.frameElevated : null,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
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
                    color: isLight
                        ? BaseLightTokens.strokeSubdued
                        : BaseDarkTokens.strokeSubdued,
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
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _TravelerCounter(
                label: 'Adults',
                subtitle: '18+ years',
                count: _adults,
                onDecrement: _adults > 1
                    ? () => setState(() => _adults--)
                    : null,
                onIncrement: _adults < 9
                    ? () => setState(() => _adults++)
                    : null,
              ),

              const SizedBox(height: 16),

              _TravelerCounter(
                label: 'Children',
                subtitle: '6-17 years',
                count: _children,
                onDecrement: _children > 0
                    ? () => setState(() => _children--)
                    : null,
                onIncrement: _children < 9
                    ? () => setState(() => _children++)
                    : null,
              ),

              const SizedBox(height: 16),

              _TravelerCounter(
                label: 'Infants',
                subtitle: '0-5 years',
                count: _infants,
                onDecrement: _infants > 0
                    ? () => setState(() => _infants--)
                    : null,
                onIncrement: _infants < 9
                    ? () => setState(() => _infants++)
                    : null,
              ),

              const SizedBox(height: 32),

              OmsaButton(
                onPressed: _submit,
                width: OmsaButtonWidth.fluid,
                child: Text('Confirm travelers'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TravelerCounter extends StatelessWidget {
  final String label;
  final String subtitle;
  final int count;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  const _TravelerCounter({
    required this.label,
    required this.subtitle,
    required this.count,
    this.onDecrement,
    this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLight
            ? BaseLightTokens.frameElevatedAlt
            : BaseDarkTokens.frameElevatedAlt,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.textMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTypography.textSmall.copyWith(
                    color: isLight
                        ? BaseLightTokens.textSubdued
                        : BaseDarkTokens.textSubdued,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove_circle_outline),
                color: onDecrement != null
                    ? const Color(0xFFE90037)
                    : (isLight
                          ? BaseLightTokens.textDisabled
                          : BaseDarkTokens.textDisabled),
              ),
              SizedBox(
                width: 40,
                child: Text(
                  count.toString(),
                  textAlign: TextAlign.center,
                  style: AppTypography.textLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add_circle_outline),
                color: onIncrement != null
                    ? const Color(0xFFE90037)
                    : (isLight
                          ? BaseLightTokens.textDisabled
                          : BaseDarkTokens.textDisabled),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
