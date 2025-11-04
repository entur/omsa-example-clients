import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/widgets/component_showcase.dart';

class ButtonShowcase extends ComponentShowcase {
  const ButtonShowcase({super.key});

  @override
  String get title => 'Buttons';

  @override
  State<ButtonShowcase> createState() => _ButtonShowcaseState();
}

class _ButtonShowcaseState extends State<ButtonShowcase> {
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
          label: 'Primary Buttons',
          child: VariantShowcase(
            children: [
              OmsaButton(onPressed: () {}, child: const Text('Primary')),
              const OmsaButton(onPressed: null, child: Text('Disabled')),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Secondary Buttons',
          child: VariantShowcase(
            children: [
              OmsaButton(
                variant: OmsaButtonVariant.secondary,
                onPressed: () {},
                child: const Text('Secondary'),
              ),
              const OmsaButton(
                variant: OmsaButtonVariant.secondary,
                onPressed: null,
                child: Text('Disabled'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Success Buttons',
          child: VariantShowcase(
            children: [
              OmsaButton(
                variant: OmsaButtonVariant.success,
                onPressed: () {},
                child: const Text('Success'),
              ),
              const OmsaButton(
                variant: OmsaButtonVariant.success,
                onPressed: null,
                child: Text('Disabled'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Negative Buttons',
          child: VariantShowcase(
            children: [
              OmsaButton(
                variant: OmsaButtonVariant.negative,
                onPressed: () {},
                child: const Text('Negative'),
              ),
              const OmsaButton(
                variant: OmsaButtonVariant.negative,
                onPressed: null,
                child: Text('Disabled'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Contrast Mode Buttons',
          mode: OmsaComponentMode.contrast,
          child: VariantShowcase(
            children: [
              OmsaButton(
                mode: OmsaComponentMode.contrast,
                onPressed: () {},
                child: const Text('Primary'),
              ),
              OmsaButton(
                variant: OmsaButtonVariant.secondary,
                mode: OmsaComponentMode.contrast,
                onPressed: () {},
                child: const Text('Secondary'),
              ),
              OmsaButton(
                variant: OmsaButtonVariant.success,
                mode: OmsaComponentMode.contrast,
                onPressed: () {},
                child: const Text('Success'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Icon Buttons',
          child: VariantShowcase(
            children: [
              OmsaIconButton(icon: const Icon(Icons.add), onPressed: () {}),
              OmsaIconButton(icon: const Icon(Icons.edit), onPressed: () {}),
              OmsaIconButton(icon: const Icon(Icons.delete), onPressed: () {}),
              const OmsaIconButton(icon: Icon(Icons.info), onPressed: null),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Square Buttons',
          child: VariantShowcase(
            children: [
              OmsaSquareButton(icon: const Icon(Icons.home), onPressed: () {}),
              OmsaSquareButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              const OmsaSquareButton(
                icon: Icon(Icons.settings),
                onPressed: null,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Floating Action Button',
          child: OmsaFloatingButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
