import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';

class TravelerPickerResult {
  final int adults;
  final int youth;
  final int children;
  final int infants;
  final int seniors;
  final String? discount;

  TravelerPickerResult({
    this.adults = 1,
    this.youth = 0,
    this.children = 0,
    this.infants = 0,
    this.seniors = 0,
    this.discount,
  });

  int get totalTravelers => adults + youth + children + infants + seniors;

  String get displayText {
    final parts = <String>[];
    if (adults > 0) parts.add('$adults Adult${adults > 1 ? 's' : ''}');
    if (youth > 0) parts.add('$youth Youth');
    if (children > 0) parts.add('$children Child${children > 1 ? 'ren' : ''}');
    if (infants > 0) parts.add('$infants Infant${infants > 1 ? 's' : ''}');
    if (seniors > 0) parts.add('$seniors Senior${seniors > 1 ? 's' : ''}');
    return parts.join(', ');
  }
}

class TravelerPickerDrawer extends StatefulWidget {
  final int initialAdults;
  final int initialYouth;
  final int initialChildren;
  final int initialInfants;
  final int initialSeniors;
  final String? initialDiscount;

  const TravelerPickerDrawer({
    super.key,
    this.initialAdults = 1,
    this.initialYouth = 0,
    this.initialChildren = 0,
    this.initialInfants = 0,
    this.initialSeniors = 0,
    this.initialDiscount,
  });

  @override
  State<TravelerPickerDrawer> createState() => _TravelerPickerDrawerState();

  static Future<TravelerPickerResult?> show(
    BuildContext context, {
    int initialAdults = 1,
    int initialYouth = 0,
    int initialChildren = 0,
    int initialInfants = 0,
    int initialSeniors = 0,
    String? initialDiscount,
  }) {
    return showModalBottomSheet<TravelerPickerResult>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: context.tokens.frameTint,
      builder: (context) => TravelerPickerDrawer(
        initialAdults: initialAdults,
        initialYouth: initialYouth,
        initialChildren: initialChildren,
        initialInfants: initialInfants,
        initialSeniors: initialSeniors,
        initialDiscount: initialDiscount,
      ),
    );
  }
}

class _TravelerPickerDrawerState extends State<TravelerPickerDrawer> {
  late int _adults;
  late int _youth;
  late int _children;
  late int _infants;
  late int _seniors;
  String? _discount;

  @override
  void initState() {
    super.initState();
    _adults = widget.initialAdults;
    _youth = widget.initialYouth;
    _children = widget.initialChildren;
    _infants = widget.initialInfants;
    _seniors = widget.initialSeniors;
    _discount = widget.initialDiscount;
  }

  void _submit() {
    Navigator.of(context).pop(
      TravelerPickerResult(
        adults: _adults,
        youth: _youth,
        children: _children,
        infants: _infants,
        seniors: _seniors,
        discount: _discount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return SafeArea(
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

            _TravelerCounter(
              label: 'Adults',
              subtitle: '23+ years',
              count: _adults,
              onDecrement: _adults > 0 ? () => setState(() => _adults--) : null,
              onIncrement: _adults < 9 ? () => setState(() => _adults++) : null,
            ),

            const SizedBox(height: 12),

            _TravelerCounter(
              label: 'Youth',
              subtitle: '15-22 years',
              count: _youth,
              onDecrement: _youth > 0 ? () => setState(() => _youth--) : null,
              onIncrement: _youth < 9 ? () => setState(() => _youth++) : null,
            ),

            const SizedBox(height: 12),

            _TravelerCounter(
              label: 'Child',
              subtitle: '6-15 years',
              count: _children,
              onDecrement: _children > 0
                  ? () => setState(() => _children--)
                  : null,
              onIncrement: _children < 9
                  ? () => setState(() => _children++)
                  : null,
            ),

            const SizedBox(height: 12),

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

            const SizedBox(height: 12),

            _TravelerCounter(
              label: 'Senior',
              subtitle: '67+ years',
              count: _seniors,
              onDecrement: _seniors > 0
                  ? () => setState(() => _seniors--)
                  : null,
              onIncrement: _seniors < 9
                  ? () => setState(() => _seniors++)
                  : null,
            ),

            const SizedBox(height: 24),

            _DiscountSelector(
              selectedDiscount: _discount,
              onDiscountChanged: (discount) =>
                  setState(() => _discount = discount),
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
    final tokens = context.tokens;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.textMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTypography.textSmall.copyWith(
                  color: tokens.textSubdued,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            OmsaSquareButton(
              icon: OmsaIcons.Subtract(),
              onPressed: onDecrement,
            ),
            SizedBox(
              width: 48,
              child: Text(
                count.toString(),
                textAlign: TextAlign.center,
                style: AppTypography.textMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            OmsaSquareButton(icon: OmsaIcons.Add(), onPressed: onIncrement),
          ],
        ),
      ],
    );
  }
}

class _DiscountSelector extends StatelessWidget {
  final String? selectedDiscount;
  final ValueChanged<String?> onDiscountChanged;

  const _DiscountSelector({
    required this.selectedDiscount,
    required this.onDiscountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return OmsaRadioPanelGroup<String>(
      value: selectedDiscount,
      onChanged: (value) {
        if (value == selectedDiscount) {
          onDiscountChanged(null);
        } else {
          onDiscountChanged(value);
        }
      },
      label: const Text('Discount'),
      options: const [
        OmsaRadioPanelOption<String>(value: 'Student', title: Text('Student')),
        OmsaRadioPanelOption<String>(
          value: 'Military',
          title: Text('Military'),
        ),
      ],
    );
  }
}
