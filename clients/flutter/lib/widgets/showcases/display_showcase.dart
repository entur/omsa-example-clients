import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/widgets/component_showcase.dart';

class DisplayShowcase extends ComponentShowcase {
  const DisplayShowcase({super.key});

  @override
  String get title => 'Display';

  @override
  State<DisplayShowcase> createState() => _DisplayShowcaseState();
}

class _DisplayShowcaseState extends State<DisplayShowcase> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTypography.displaySmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Chips',
          child: VariantShowcase(
            children: [
              const OmsaChip(label: Text('Default')),
              OmsaChip(
                label: const Text('With Icon'),
                icon: const Icon(Icons.check),
                onPressed: () {},
              ),
              OmsaChip(label: const Text('Deletable'), onDeleted: () {}),
              const OmsaChip(
                label: Text('Custom Color'),
                customBackgroundColor: Colors.blue,
                customTextColor: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
