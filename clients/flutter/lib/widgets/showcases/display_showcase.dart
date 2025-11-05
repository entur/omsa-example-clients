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
          label: 'Banner AlertBox',
          child: VariantShowcase(
            direction: Axis.vertical,
            children: [
              OmsaBannerAlertBox(
                variant: OmsaAlertVariant.success,
                title: const Text('Success'),
                closable: true,
                children: const Text('Operation completed successfully.'),
              ),
              OmsaBannerAlertBox(
                variant: OmsaAlertVariant.information,
                title: const Text('Information'),
                children: const Text('This is an informational message.'),
              ),
              OmsaBannerAlertBox(
                variant: OmsaAlertVariant.warning,
                title: const Text('Warning'),
                closable: true,
                children: const Text(
                  'Please be aware of this important point.',
                ),
              ),
              OmsaBannerAlertBox(
                variant: OmsaAlertVariant.negative,
                title: const Text('Error'),
                children: const Text('Something went wrong. Please try again.'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Small AlertBox',
          child: VariantShowcase(
            direction: Axis.vertical,
            children: [
              OmsaSmallAlertBox(
                variant: OmsaAlertVariant.success,
                title: const Text('Saved'),
                children: const Text('Changes saved.'),
              ),
              OmsaSmallAlertBox(
                variant: OmsaAlertVariant.information,
                title: const Text('Tip'),
                width: OmsaAlertWidth.fitContent,
                children: const Text('This is a helpful tip.'),
              ),
              OmsaSmallAlertBox(
                variant: OmsaAlertVariant.warning,
                closable: true,
                children: const Text('Warning without title'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Expandable AlertBox',
          child: VariantShowcase(
            direction: Axis.vertical,
            children: [
              OmsaBannerExpandableAlertBox(
                variant: OmsaAlertVariant.information,
                title: const Text('Learn more about this feature'),
                openLabel: 'Show details',
                closeLabel: 'Hide details',
                children: const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Here is more detailed information that is shown when '
                    'the user expands the alert. This can contain longer '
                    'explanations or instructions.',
                  ),
                ),
              ),
              OmsaSmallExpandableAlertBox(
                variant: OmsaAlertVariant.warning,
                title: const Text('Important notice'),
                children: const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Additional details about the warning that the user can '
                    'choose to view when needed.',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'AlertBox - Contrast Mode',
          mode: OmsaComponentMode.contrast,
          child: VariantShowcase(
            direction: Axis.vertical,
            children: [
              OmsaBannerAlertBox(
                variant: OmsaAlertVariant.information,
                mode: OmsaComponentMode.contrast,
                title: const Text('Contrast Mode'),
                children: const Text(
                  'This alert uses contrast mode for dark backgrounds.',
                ),
              ),
              OmsaSmallAlertBox(
                variant: OmsaAlertVariant.success,
                mode: OmsaComponentMode.contrast,
                title: const Text('Success'),
                children: const Text('Contrast mode enabled.'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
