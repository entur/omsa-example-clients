import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/widgets/component_showcase.dart';

class InputShowcase extends ComponentShowcase {
  const InputShowcase({super.key});

  @override
  String get title => 'Inputs';

  @override
  State<InputShowcase> createState() => _InputShowcaseState();
}

class _InputShowcaseState extends State<InputShowcase> {
  // Checkbox state
  bool checkbox1 = false;
  bool checkbox2 = true;
  bool? tristateCheckbox;

  // Radio state
  String? radioValue = 'option1';

  // Switch state
  bool switch1 = false;
  bool switch2 = true;

  // Dropdown state
  OmsaDropdownItem<String>? selectedItem;

  // Segmented control state
  String? segmentedValue = 'option1';

  // Radio panel state
  String? panelValue = 'basic';

  // Checkbox panel state
  bool panel1 = false;
  bool panel2 = true;

  // Travel switch state
  bool bus = true;
  bool train = false;
  bool ferry = true;

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
          label: 'Checkboxes',
          child: VariantShowcase(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OmsaCheckbox(
                checked: checkbox1,
                onChanged: (value) =>
                    setState(() => checkbox1 = value ?? false),
                label: const Text('Option 1'),
              ),
              OmsaCheckbox(
                checked: checkbox2,
                onChanged: (value) =>
                    setState(() => checkbox2 = value ?? false),
                label: const Text('Option 2 (Checked)'),
              ),
              OmsaCheckbox(
                checked: tristateCheckbox,
                tristate: true,
                onChanged: (value) => setState(() => tristateCheckbox = value),
                label: const Text('Tristate Checkbox'),
              ),
              const OmsaCheckbox(
                checked: false,
                onChanged: null,
                disabled: true,
                label: Text('Disabled'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Radio Buttons',
          child: OmsaRadioGroup<String>(
            value: radioValue,
            onChanged: (value) => setState(() => radioValue = value),
            children: [
              OmsaRadio<String>(
                value: 'option1',
                groupValue: radioValue,
                onChanged: (value) => setState(() => radioValue = value),
                label: const Text('Option 1'),
              ),
              OmsaRadio<String>(
                value: 'option2',
                groupValue: radioValue,
                onChanged: (value) => setState(() => radioValue = value),
                label: const Text('Option 2'),
              ),
              OmsaRadio<String>(
                value: 'option3',
                groupValue: radioValue,
                onChanged: (value) => setState(() => radioValue = value),
                label: const Text('Option 3'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Switches',
          child: VariantShowcase(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OmsaSwitch(
                checked: switch1,
                onChanged: (value) => setState(() => switch1 = value),
                label: const Text('Enable Feature'),
              ),
              OmsaSwitch(
                checked: switch2,
                onChanged: (value) => setState(() => switch2 = value),
                label: const Text('Notifications'),
              ),
              const OmsaSwitch(
                checked: false,
                onChanged: null,
                disabled: true,
                label: Text('Disabled'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Dropdown',
          child: OmsaDropdown<String>(
            items: const [
              OmsaDropdownItem(value: '1', label: 'Option 1'),
              OmsaDropdownItem(value: '2', label: 'Option 2'),
              OmsaDropdownItem(value: '3', label: 'Option 3'),
            ],
            selectedItem: selectedItem,
            onChange: (item) => setState(() => selectedItem = item),
            label: 'Select an option',
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Segmented Control',
          child: OmsaSegmentedControl(
            value: segmentedValue,
            onChanged: (value) => setState(() => segmentedValue = value),
            children: const [
              OmsaSegmentedChoice(value: 'option1', child: Text('Option 1')),
              OmsaSegmentedChoice(value: 'option2', child: Text('Option 2')),
              OmsaSegmentedChoice(value: 'option3', child: Text('Option 3')),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Radio Panels',
          child: OmsaRadioPanelGroup<String>(
            value: panelValue,
            onChanged: (value) => setState(() => panelValue = value),
            options: const [
              OmsaRadioPanelOption(
                value: 'basic',
                title: Text('Basic Plan'),
                secondaryLabel: Text('Perfect for getting started'),
              ),
              OmsaRadioPanelOption(
                value: 'pro',
                title: Text('Pro Plan'),
                secondaryLabel: Text('For professionals'),
              ),
              OmsaRadioPanelOption(
                value: 'enterprise',
                title: Text('Enterprise Plan'),
                secondaryLabel: Text('For large organizations'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Checkbox Panels',
          child: VariantShowcase(
            direction: Axis.vertical,
            children: [
              OmsaCheckboxPanel(
                value: 'panel1',
                checked: panel1,
                onChanged: (value) => setState(() => panel1 = value),
                title: const Text('Email Notifications'),
                secondaryLabel: const Text('Receive updates via email'),
              ),
              OmsaCheckboxPanel(
                value: 'panel2',
                checked: panel2,
                onChanged: (value) => setState(() => panel2 = value),
                title: const Text('Push Notifications'),
                secondaryLabel: const Text('Get instant alerts on your device'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        const ComponentExample(
          label: 'Text Fields',
          child: Column(
            children: [
              OmsaTextField(label: 'Name', hint: 'Enter your name'),
              SizedBox(height: 16),
              OmsaTextField(label: 'Email', hint: 'email@example.com'),
              SizedBox(height: 16),
              OmsaTextField(label: 'Message', hint: 'Type your message here'),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Travel Switches',
          child: VariantShowcase(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OmsaTravelSwitch(
                checked: bus,
                onChanged: (value) => setState(() => bus = value),
                transport: Transport.bus,
                label: const Text('Bus'),
              ),
              OmsaTravelSwitch(
                checked: train,
                onChanged: (value) => setState(() => train = value),
                transport: Transport.train,
                label: const Text('Train'),
              ),
              OmsaTravelSwitch(
                checked: ferry,
                onChanged: (value) => setState(() => ferry = value),
                transport: Transport.ferry,
                label: const Text('Ferry'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
