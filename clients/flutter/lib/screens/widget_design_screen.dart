import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';

class WidgetDesignScreen extends StatefulWidget {
  const WidgetDesignScreen({super.key});

  @override
  State<WidgetDesignScreen> createState() => _WidgetDesignScreenState();
}

class _WidgetDesignScreenState extends State<WidgetDesignScreen> {
  String _selectedCategory = 'Buttons';

  // State for radio examples
  String? _radioValue1 = 'option1';
  String? _radioValue2 = 'option2';

  // State for checkbox examples
  bool _checkbox1 = false;
  bool _checkbox2 = true;
  bool _checkbox3 = false;
  bool _checkbox4 = false;
  bool _checkbox5 = true;
  bool? _tristateCheckbox;

  // State for radio panel examples
  String? _radioPanelValue1 = 'basic';
  String? _radioPanelValue2 = 'standard';
  String? _radioPanelValue3;
  String? _radioPanelValue4;

  // State for checkbox panel examples
  bool _checkboxPanel1 = false;
  bool _checkboxPanel2 = true;
  bool _checkboxPanel3 = false;

  // State for segmented control examples
  String? _segmentedStandardValue = 'departures';
  String? _segmentedLargeValue = 'today';
  String? _segmentedContrastValue = 'overview';

  // State for dropdown examples
  OmsaDropdownItem<String>? _selectedDropdownOption1;
  OmsaDropdownItem<String>? _selectedDropdownOption2 = const OmsaDropdownItem(
    value: '2',
    label: 'Option 2',
  );

  final List<String> _categories = [
    'Buttons',
    'Inputs',
    'Cards',
    'Display',
    'Typography',
    'Colors',
    'Spacing',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Design Lab'),
        backgroundColor: BaseLightTokens.frameElevatedAlt,
      ),
      body: Row(
        children: [
          Container(
            width: 200,
            color: BaseLightTokens.frameElevatedAlt,
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;

                return ListTile(
                  title: Text(
                    category,
                    style: AppTypography.textMedium.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : BaseLightTokens.textAccent,
                    ),
                  ),
                  selected: isSelected,
                  selectedTileColor: BaseLightTokens.frameElevated,
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: _buildCategoryContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryContent() {
    switch (_selectedCategory) {
      case 'Buttons':
        return _buildButtonsSection();
      case 'Inputs':
        return _buildInputsSection();
      case 'Cards':
        return _buildCardsSection();
      case 'Display':
        return _buildDisplaySection();
      case 'Typography':
        return _buildTypographySection();
      case 'Colors':
        return _buildColorsSection();
      case 'Spacing':
        return _buildSpacingSection();
      default:
        return const Text('Select a category');
    }
  }

  Widget _buildButtonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buttons',
          style: AppTypography.displaySmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        _buildSection(
          'Button Variants - Standard Mode (Light Background)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Primary:'),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                child: const Text('Primary Standard'),
              ),
              const SizedBox(height: 16),

              const Text('Secondary:'),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                variant: OmsaButtonVariant.secondary,
                child: const Text('Secondary Standard'),
              ),
              const SizedBox(height: 16),

              const Text('Success:'),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                variant: OmsaButtonVariant.success,
                child: const Text('Success Standard'),
              ),
              const SizedBox(height: 16),

              const Text('Negative:'),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                variant: OmsaButtonVariant.negative,
                child: const Text('Negative Standard'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildContrastSection(
          'Button Variants - Contrast Mode (Dark Background)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Primary:', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                mode: OmsaComponentMode.contrast,
                child: const Text('Primary Contrast'),
              ),
              const SizedBox(height: 16),

              const Text('Secondary:', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                variant: OmsaButtonVariant.secondary,
                mode: OmsaComponentMode.contrast,
                child: const Text('Secondary Contrast'),
              ),
              const SizedBox(height: 16),

              const Text('Success:', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                variant: OmsaButtonVariant.success,
                mode: OmsaComponentMode.contrast,
                child: const Text('Success Contrast'),
              ),
              const SizedBox(height: 16),

              const Text('Negative:', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                variant: OmsaButtonVariant.negative,
                mode: OmsaComponentMode.contrast,
                child: const Text('Negative Contrast'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Button Sizes - Standard Mode',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Large:'),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                size: OmsaButtonSize.large,
                child: const Text('Large Primary Button'),
              ),
              const SizedBox(height: 16),

              const Text('Medium:'),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                size: OmsaButtonSize.medium,
                child: const Text('Medium Primary Button'),
              ),
              const SizedBox(height: 16),

              const Text('Small:'),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                size: OmsaButtonSize.small,
                child: const Text('Small Primary Button'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Button States - Standard Mode',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Disabled:'),
              const SizedBox(height: 8),
              OmsaButton(onPressed: null, child: const Text('Disabled Button')),
              const SizedBox(height: 16),

              const Text('Loading:'),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                isLoading: true,
                child: const Text('Loading Button'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Full Width Buttons',
          Column(
            children: [
              OmsaButton(
                onPressed: () {},
                width: OmsaButtonWidth.fluid,
                child: const Text('Full Width Primary'),
              ),
              const SizedBox(height: 16),

              OmsaButton(
                onPressed: () {},
                variant: OmsaButtonVariant.secondary,
                width: OmsaButtonWidth.fluid,
                child: const Text('Full Width Secondary'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Floating Action Buttons - Standard Mode',
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              OmsaFloatingButton(onPressed: () {}, icon: const Icon(Icons.add)),
              OmsaFloatingButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              OmsaFloatingButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
              OmsaFloatingButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: 'Add Item',
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Icon Buttons - Standard Mode',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Medium Size:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  OmsaIconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                    tooltip: 'Search',
                  ),
                  OmsaIconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
                    tooltip: 'Favorite',
                  ),
                  OmsaIconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                    tooltip: 'Share',
                  ),
                  OmsaIconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                    tooltip: 'Settings',
                  ),
                  OmsaIconButton(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    tooltip: 'Disabled',
                  ),
                  OmsaIconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.refresh),
                    isLoading: true,
                    tooltip: 'Loading',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Small Size:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OmsaIconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 18),
                    size: OmsaIconButtonSize.small,
                    tooltip: 'Edit',
                  ),
                  OmsaIconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete, size: 18),
                    size: OmsaIconButtonSize.small,
                    tooltip: 'Delete',
                  ),
                  OmsaIconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 18),
                    size: OmsaIconButtonSize.small,
                    tooltip: 'Add',
                  ),
                  OmsaIconButton(
                    onPressed: null,
                    icon: const Icon(Icons.remove, size: 18),
                    size: OmsaIconButtonSize.small,
                    tooltip: 'Disabled',
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildContrastSection(
          'Icon Buttons - Contrast Mode (Dark Background)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Medium Size:', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  OmsaIconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                    mode: OmsaComponentMode.contrast,
                    tooltip: 'Search',
                  ),
                  OmsaIconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
                    mode: OmsaComponentMode.contrast,
                    tooltip: 'Favorite',
                  ),
                  OmsaIconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                    mode: OmsaComponentMode.contrast,
                    tooltip: 'Share',
                  ),
                  OmsaIconButton(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    mode: OmsaComponentMode.contrast,
                    tooltip: 'Disabled',
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Square Buttons - Standard Mode',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Secondary Variant:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: 'Add Item',
                  ),
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: 'Edit',
                  ),
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                  ),
                  OmsaSquareButton(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    label: 'Disabled',
                  ),
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.save),
                    label: 'Loading',
                    isLoading: true,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Success Variant:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.check),
                    label: 'Confirm',
                    variant: OmsaSquareButtonVariant.success,
                  ),
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.check_circle),
                    label: 'Approve',
                    variant: OmsaSquareButtonVariant.success,
                  ),
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.check),
                    variant: OmsaSquareButtonVariant.success,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Tertiary Variant (Smaller):'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                    label: 'More',
                    variant: OmsaSquareButtonVariant.tertiary,
                  ),
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                    label: 'Filter',
                    variant: OmsaSquareButtonVariant.tertiary,
                  ),
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.sort),
                    variant: OmsaSquareButtonVariant.tertiary,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildContrastSection(
          'Square Buttons - Contrast Mode (Dark Background)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Secondary:', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: 'Add',
                    mode: OmsaComponentMode.contrast,
                  ),
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                    mode: OmsaComponentMode.contrast,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Success:', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.check),
                    label: 'Confirm',
                    variant: OmsaSquareButtonVariant.success,
                    mode: OmsaComponentMode.contrast,
                  ),
                  OmsaSquareButton(
                    onPressed: () {},
                    icon: const Icon(Icons.check),
                    variant: OmsaSquareButtonVariant.success,
                    mode: OmsaComponentMode.contrast,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Input Components',
          style: AppTypography.displaySmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        _buildSection(
          'Text Fields - Basic',
          Column(
            children: [
              const OmsaTextField(
                label: 'Standard Text Field',
                hint: 'Enter some text',
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'Email Field',
                hint: 'email@example.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'Phone Number',
                hint: '12345678',
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Text Fields - Variants (Standard Mode)',
          Column(
            children: [
              const OmsaTextField(
                label: 'Default',
                hint: 'No variant',
                variant: OmsaTextFieldVariant.none,
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'Success',
                hint: 'Valid input',
                variant: OmsaTextFieldVariant.success,
                feedback: 'This field is valid',
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'Negative/Error',
                hint: 'Invalid input',
                variant: OmsaTextFieldVariant.negative,
                feedback: 'This field has an error',
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'Warning',
                hint: 'Warning state',
                variant: OmsaTextFieldVariant.warning,
                feedback: 'This field has a warning',
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'Information',
                hint: 'Info state',
                variant: OmsaTextFieldVariant.information,
                feedback: 'Additional information about this field',
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Text Fields - Sizes',
          Column(
            children: [
              const OmsaTextField(
                label: 'Medium Size (48px)',
                hint: 'Default size',
                size: OmsaTextFieldSize.medium,
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'Large Size (64px)',
                hint: 'Large variant',
                size: OmsaTextFieldSize.large,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Text Fields - States',
          Column(
            children: [
              const OmsaTextField(
                label: 'Disabled Field',
                hint: 'Cannot edit',
                disabled: true,
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'Read-only Field',
                hint: 'Cannot edit',
                readOnly: true,
                initialValue: 'Read-only value',
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'Required Field',
                hint: 'This field is required',
                required: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Text Fields - With Icons',
          Column(
            children: [
              const OmsaTextField(
                label: 'With Prepend Icon',
                hint: 'Search...',
                prepend: Icon(Icons.search),
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'With Append Icon',
                hint: 'Password',
                append: Icon(Icons.visibility),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'Clearable Field',
                hint: 'Type something',
                clearable: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildContrastSection(
          'Text Fields - Contrast Mode (Dark Background)',
          Column(
            children: [
              const OmsaTextField(
                label: 'Contrast Mode',
                hint: 'Enter text',
                mode: OmsaComponentMode.contrast,
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'Contrast with Success',
                hint: 'Valid input',
                mode: OmsaComponentMode.contrast,
                variant: OmsaTextFieldVariant.success,
                feedback: 'This field is valid',
              ),
              const SizedBox(height: 16),
              const OmsaTextField(
                label: 'Contrast with Error',
                hint: 'Invalid input',
                mode: OmsaComponentMode.contrast,
                variant: OmsaTextFieldVariant.negative,
                feedback: 'This field has an error',
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Segmented Control - Standard Mode',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OmsaSegmentedControl(
                label: 'Travel type',
                value: _segmentedStandardValue,
                onChanged: (value) =>
                    setState(() => _segmentedStandardValue = value),
                children: [
                  OmsaSegmentedChoice(
                    value: 'departures',
                    child: const Text('Departures'),
                  ),
                  OmsaSegmentedChoice(
                    value: 'arrivals',
                    child: const Text('Arrivals'),
                  ),
                  OmsaSegmentedChoice(
                    value: 'delays',
                    child: const Text('Delays'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Selected: ${_segmentedStandardValue ?? 'None'}',
                style: AppTypography.textMedium,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Segmented Control - Sizes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OmsaSegmentedControl(
                label: 'Today view',
                size: OmsaSegmentedControlSize.large,
                value: _segmentedLargeValue,
                onChanged: (value) =>
                    setState(() => _segmentedLargeValue = value),
                children: [
                  OmsaSegmentedChoice(
                    value: 'today',
                    child: const Text('Today'),
                  ),
                  OmsaSegmentedChoice(value: 'week', child: const Text('Week')),
                  OmsaSegmentedChoice(
                    value: 'month',
                    child: const Text('Month'),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildContrastSection(
          'Segmented Control - Contrast Mode (Dark Background)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OmsaSegmentedControl(
                label: 'Overview',
                mode: OmsaComponentMode.contrast,
                value: _segmentedContrastValue,
                onChanged: (value) =>
                    setState(() => _segmentedContrastValue = value),
                children: [
                  OmsaSegmentedChoice(
                    value: 'overview',
                    child: const Text('Overview'),
                  ),
                  OmsaSegmentedChoice(
                    value: 'details',
                    child: const Text('Details'),
                  ),
                  OmsaSegmentedChoice(
                    value: 'map',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.map_outlined, size: 16),
                        SizedBox(width: 4),
                        Text('Map'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Radio Buttons - Basic',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OmsaRadio<String>(
                value: 'option1',
                groupValue: _radioValue1,
                onChanged: (value) => setState(() => _radioValue1 = value),
                label: const Text('Option 1'),
              ),
              const SizedBox(height: 8),
              OmsaRadio<String>(
                value: 'option2',
                groupValue: _radioValue1,
                onChanged: (value) => setState(() => _radioValue1 = value),
                label: const Text('Option 2'),
              ),
              const SizedBox(height: 8),
              OmsaRadio<String>(
                value: 'option3',
                groupValue: _radioValue1,
                onChanged: (value) => setState(() => _radioValue1 = value),
                label: const Text('Option 3'),
              ),
              const SizedBox(height: 16),
              const Text('With Radio Group:'),
              const SizedBox(height: 8),
              OmsaRadioGroup<String>(
                value: _radioValue1,
                onChanged: (value) => setState(() => _radioValue1 = value),
                label: const Text('Select an option:'),
                children: [
                  OmsaRadio<String>(
                    value: 'option1',
                    groupValue: _radioValue1,
                    onChanged: (value) => setState(() => _radioValue1 = value),
                    label: const Text('First option'),
                  ),
                  OmsaRadio<String>(
                    value: 'option2',
                    groupValue: _radioValue1,
                    onChanged: (value) => setState(() => _radioValue1 = value),
                    label: const Text('Second option'),
                  ),
                  OmsaRadio<String>(
                    value: 'option3',
                    groupValue: _radioValue1,
                    onChanged: (value) => setState(() => _radioValue1 = value),
                    label: const Text('Third option'),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Radio Buttons - States',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Disabled:'),
              const SizedBox(height: 8),
              OmsaRadio<String>(
                value: 'disabled',
                groupValue: null,
                onChanged: null,
                label: const Text('Disabled radio'),
                disabled: true,
              ),
              const SizedBox(height: 16),
              const Text('Read-only:'),
              const SizedBox(height: 8),
              OmsaRadio<String>(
                value: 'readonly',
                groupValue: 'readonly',
                onChanged: (value) {},
                label: const Text('Read-only radio'),
                readOnly: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildContrastSection(
          'Radio Buttons - Contrast Mode (Dark Background)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OmsaRadio<String>(
                value: 'option1',
                groupValue: _radioValue2,
                onChanged: (value) => setState(() => _radioValue2 = value),
                label: const Text(
                  'Option 1',
                  style: TextStyle(color: Colors.white),
                ),
                mode: OmsaComponentMode.contrast,
              ),
              const SizedBox(height: 8),
              OmsaRadio<String>(
                value: 'option2',
                groupValue: _radioValue2,
                onChanged: (value) => setState(() => _radioValue2 = value),
                label: const Text(
                  'Option 2',
                  style: TextStyle(color: Colors.white),
                ),
                mode: OmsaComponentMode.contrast,
              ),
              const SizedBox(height: 8),
              OmsaRadio<String>(
                value: 'option3',
                groupValue: _radioValue2,
                onChanged: (value) => setState(() => _radioValue2 = value),
                label: const Text(
                  'Option 3',
                  style: TextStyle(color: Colors.white),
                ),
                mode: OmsaComponentMode.contrast,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Checkboxes - Basic',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OmsaCheckbox(
                checked: _checkbox1,
                onChanged: (value) =>
                    setState(() => _checkbox1 = value ?? false),
                label: const Text('Unchecked checkbox'),
              ),
              const SizedBox(height: 8),
              OmsaCheckbox(
                checked: _checkbox2,
                onChanged: (value) =>
                    setState(() => _checkbox2 = value ?? false),
                label: const Text('Checked checkbox'),
              ),
              const SizedBox(height: 16),
              const Text('With Checkbox Group:'),
              const SizedBox(height: 8),
              OmsaCheckboxGroup(
                label: const Text('Select multiple options:'),
                children: [
                  OmsaCheckbox(
                    checked: _checkbox3,
                    onChanged: (value) =>
                        setState(() => _checkbox3 = value ?? false),
                    label: const Text('First option'),
                  ),
                  OmsaCheckbox(
                    checked: _checkbox4,
                    onChanged: (value) =>
                        setState(() => _checkbox4 = value ?? false),
                    label: const Text('Second option'),
                  ),
                  OmsaCheckbox(
                    checked: _checkbox5,
                    onChanged: (value) =>
                        setState(() => _checkbox5 = value ?? false),
                    label: const Text('Third option'),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Checkboxes - States',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Disabled:'),
              const SizedBox(height: 8),
              const OmsaCheckbox(
                checked: false,
                onChanged: null,
                label: Text('Disabled unchecked'),
                disabled: true,
              ),
              const SizedBox(height: 8),
              const OmsaCheckbox(
                checked: true,
                onChanged: null,
                label: Text('Disabled checked'),
                disabled: true,
              ),
              const SizedBox(height: 16),
              const Text('Read-only:'),
              const SizedBox(height: 8),
              OmsaCheckbox(
                checked: true,
                onChanged: (value) {},
                label: const Text('Read-only checked'),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              const Text('Tristate (Indeterminate):'),
              const SizedBox(height: 8),
              OmsaCheckbox(
                checked: _tristateCheckbox,
                onChanged: (value) => setState(() => _tristateCheckbox = value),
                label: const Text('Click to cycle: null → false → true → null'),
                tristate: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildContrastSection(
          'Checkboxes - Contrast Mode (Dark Background)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OmsaCheckbox(
                checked: false,
                onChanged: (value) {},
                label: const Text(
                  'Unchecked',
                  style: TextStyle(color: Colors.white),
                ),
                mode: OmsaComponentMode.contrast,
              ),
              const SizedBox(height: 8),
              OmsaCheckbox(
                checked: true,
                onChanged: (value) {},
                label: const Text(
                  'Checked',
                  style: TextStyle(color: Colors.white),
                ),
                mode: OmsaComponentMode.contrast,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Radio Panels - Basic',
          Column(
            children: [
              OmsaRadioPanel<String>(
                value: 'basic',
                groupValue: _radioPanelValue1,
                onChanged: (value) => setState(() => _radioPanelValue1 = value),
                title: const Text('Basic Plan'),
                secondaryLabel: const Text('Free • Up to 10 users'),
              ),
              const SizedBox(height: 12),
              OmsaRadioPanel<String>(
                value: 'standard',
                groupValue: _radioPanelValue1,
                onChanged: (value) => setState(() => _radioPanelValue1 = value),
                title: const Text('Standard Plan'),
                secondaryLabel: const Text('\$29/mo • Up to 50 users'),
              ),
              const SizedBox(height: 12),
              OmsaRadioPanel<String>(
                value: 'premium',
                groupValue: _radioPanelValue1,
                onChanged: (value) => setState(() => _radioPanelValue1 = value),
                title: const Text('Premium Plan'),
                secondaryLabel: const Text('\$99/mo • Unlimited users'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Radio Panels - With Children',
          Column(
            children: [
              OmsaRadioPanel<String>(
                value: 'card',
                groupValue: _radioPanelValue3,
                onChanged: (value) => setState(() {
                  _radioPanelValue3 = _radioPanelValue3 == value ? null : value;
                }),
                title: const Text('Credit Card'),
                secondaryLabel: const Text('Pay with credit or debit card'),
                children: const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Visa, Mastercard, Amex accepted',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OmsaRadioPanel<String>(
                value: 'paypal',
                groupValue: _radioPanelValue3,
                onChanged: (value) => setState(() {
                  _radioPanelValue3 = _radioPanelValue3 == value ? null : value;
                }),
                title: const Text('PayPal'),
                secondaryLabel: const Text('Pay securely with PayPal'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Radio Panels - Expand on Selected',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Children are only shown when the panel is selected. '
                'Click again to deselect (toggle behavior):',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 12),
              OmsaRadioPanel<String>(
                value: 'expand1',
                groupValue: _radioPanelValue4,
                onChanged: (value) => setState(() {
                  // Toggle: deselect if clicking the already selected option
                  _radioPanelValue4 = _radioPanelValue4 == value ? null : value;
                }),
                title: const Text('Option with Details'),
                secondaryLabel: const Text('Click to expand'),
                expandOnSelected: true,
                children: const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'These details only appear when this option is selected. '
                    'The panel will animate smoothly when expanding and collapsing.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OmsaRadioPanel<String>(
                value: 'expand2',
                groupValue: _radioPanelValue4,
                onChanged: (value) => setState(() {
                  // Toggle: deselect if clicking the already selected option
                  _radioPanelValue4 = _radioPanelValue4 == value ? null : value;
                }),
                title: const Text('Another Option'),
                secondaryLabel: const Text('Also expandable'),
                expandOnSelected: true,
                children: const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'This is great for forms where you want to keep the UI clean '
                    'and only show relevant details for the selected option.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Radio Panels - Without Radio Button',
          Column(
            children: [
              OmsaRadioPanel<String>(
                value: 'option1',
                groupValue: _radioPanelValue1,
                onChanged: (value) => setState(() => _radioPanelValue1 = value),
                title: const Text('Option 1'),
                secondaryLabel: const Text('Clean card-style selection'),
                hideRadioButton: true,
              ),
              const SizedBox(height: 12),
              OmsaRadioPanel<String>(
                value: 'option2',
                groupValue: _radioPanelValue1,
                onChanged: (value) => setState(() => _radioPanelValue1 = value),
                title: const Text('Option 2'),
                secondaryLabel: const Text('No radio indicator shown'),
                hideRadioButton: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildContrastSection(
          'Radio Panels - Contrast Mode (Dark Background)',
          Column(
            children: [
              OmsaRadioPanel<String>(
                value: 'basic',
                groupValue: _radioPanelValue2,
                onChanged: (value) => setState(() => _radioPanelValue2 = value),
                title: const Text('Basic Plan'),
                secondaryLabel: const Text('Free forever'),
                mode: OmsaComponentMode.contrast,
              ),
              const SizedBox(height: 12),
              OmsaRadioPanel<String>(
                value: 'standard',
                groupValue: _radioPanelValue2,
                onChanged: (value) => setState(() => _radioPanelValue2 = value),
                title: const Text('Standard Plan'),
                secondaryLabel: const Text('\$29/month'),
                mode: OmsaComponentMode.contrast,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Checkbox Panels - Basic',
          Column(
            children: [
              OmsaCheckboxPanel(
                value: 'notifications',
                checked: _checkboxPanel1,
                onChanged: (value) => setState(() => _checkboxPanel1 = value),
                title: const Text('Enable Notifications'),
                secondaryLabel: const Text('Receive email notifications'),
              ),
              const SizedBox(height: 12),
              OmsaCheckboxPanel(
                value: 'newsletter',
                checked: _checkboxPanel2,
                onChanged: (value) => setState(() => _checkboxPanel2 = value),
                title: const Text('Subscribe to Newsletter'),
                secondaryLabel: const Text('Weekly updates and tips'),
              ),
              const SizedBox(height: 12),
              OmsaCheckboxPanel(
                value: 'marketing',
                checked: _checkboxPanel3,
                onChanged: (value) => setState(() => _checkboxPanel3 = value),
                title: const Text('Marketing Emails'),
                secondaryLabel: const Text('Product updates and offers'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Checkbox Panels - With Children',
          Column(
            children: [
              OmsaCheckboxPanel(
                value: 'terms',
                checked: _checkboxPanel1,
                onChanged: (value) => setState(() => _checkboxPanel1 = value),
                title: const Text('Accept Terms & Conditions'),
                secondaryLabel: const Text('Required to continue'),
                children: const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'By checking this box, you agree to our Terms of Service and Privacy Policy.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Checkbox Panels - Without Checkbox',
          Column(
            children: [
              OmsaCheckboxPanel(
                value: 'feature1',
                checked: _checkboxPanel1,
                onChanged: (value) => setState(() => _checkboxPanel1 = value),
                title: const Text('Feature 1'),
                secondaryLabel: const Text('Toggle this feature'),
                hideCheckbox: true,
              ),
              const SizedBox(height: 12),
              OmsaCheckboxPanel(
                value: 'feature2',
                checked: _checkboxPanel2,
                onChanged: (value) => setState(() => _checkboxPanel2 = value),
                title: const Text('Feature 2'),
                secondaryLabel: const Text('Toggle this feature'),
                hideCheckbox: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Dropdowns',
          Column(
            children: [
              OmsaDropdown<String>(
                label: 'Select an Option',
                selectedItem: _selectedDropdownOption1,
                items: const [
                  OmsaDropdownItem(value: '1', label: 'Option 1'),
                  OmsaDropdownItem(value: '2', label: 'Option 2'),
                  OmsaDropdownItem(value: '3', label: 'Option 3'),
                ],
                onChange: (value) =>
                    setState(() => _selectedDropdownOption1 = value),
                placeholder: 'Choose an option',
              ),
              const SizedBox(height: 16),
              OmsaDropdown<String>(
                label: 'With Selected Value',
                selectedItem: _selectedDropdownOption2,
                items: const [
                  OmsaDropdownItem(value: '1', label: 'Option 1'),
                  OmsaDropdownItem(value: '2', label: 'Option 2'),
                  OmsaDropdownItem(value: '3', label: 'Option 3'),
                ],
                onChange: (value) =>
                    setState(() => _selectedDropdownOption2 = value),
                clearable: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cards',
          style: AppTypography.displaySmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        _buildSection(
          'Basic Cards',
          Column(
            children: [
              OmsaCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Title',
                        style: AppTypography.textLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This is a basic card component with some content.',
                        style: AppTypography.textMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              OmsaCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Card with icon and content',
                          style: AppTypography.textMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDisplaySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Display Components',
          style: AppTypography.displaySmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        _buildSection(
          'Chips',
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OmsaChip(label: const Text('Default Chip'), onDeleted: () {}),
              OmsaChip(
                label: const Text('Filled Chip'),
                variant: OmsaChipVariant.filled,
                onDeleted: () {},
              ),
              const OmsaChip(
                label: Text('Outlined Chip'),
                variant: OmsaChipVariant.outlined,
              ),
              const OmsaChip(
                label: Text('Elevated Chip'),
                variant: OmsaChipVariant.elevated,
              ),
              OmsaChip(
                label: const Text('Success Chip'),
                color: OmsaChipColor.success,
                onDeleted: () {},
              ),
              const OmsaChip(
                label: Text('With Icon'),
                icon: Icon(Icons.star, size: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTypographySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Typography',
          style: AppTypography.displaySmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        _buildSection(
          'Display Styles',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Display Large', style: AppTypography.displayLarge),
              const SizedBox(height: 8),
              Text('Display Medium', style: AppTypography.displayMedium),
              const SizedBox(height: 8),
              Text('Display Small', style: AppTypography.displaySmall),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildSection(
          'Headline Styles',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Headline Large', style: AppTypography.headlineLarge),
              const SizedBox(height: 8),
              Text('Headline Medium', style: AppTypography.headlineMedium),
              const SizedBox(height: 8),
              Text('Headline Small', style: AppTypography.headlineSmall),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildSection(
          'Text Styles',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Text Large', style: AppTypography.textLarge),
              const SizedBox(height: 8),
              Text('Text Medium', style: AppTypography.textMedium),
              const SizedBox(height: 8),
              Text('Text Small', style: AppTypography.textSmall),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildSection(
          'Label Styles',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Label Large', style: AppTypography.labelLarge),
              const SizedBox(height: 8),
              Text('Label Medium', style: AppTypography.labelMedium),
              const SizedBox(height: 8),
              Text('Label Small', style: AppTypography.labelSmall),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Colors',
          style: AppTypography.displaySmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        _buildSection(
          'Primary Colors',
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildColorSwatch(
                'Primary',
                Theme.of(context).colorScheme.primary,
              ),
              _buildColorSwatch(
                'Primary Container',
                Theme.of(context).colorScheme.primaryContainer,
              ),
              _buildColorSwatch(
                'On Primary',
                Theme.of(context).colorScheme.onPrimary,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildSection(
          'Secondary Colors',
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildColorSwatch(
                'Secondary',
                Theme.of(context).colorScheme.secondary,
              ),
              _buildColorSwatch(
                'Secondary Container',
                Theme.of(context).colorScheme.secondaryContainer,
              ),
              _buildColorSwatch(
                'On Secondary',
                Theme.of(context).colorScheme.onSecondary,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildSection(
          'Shape Colors',
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildColorSwatch('Accent', BaseLightTokens.shapeAccent),
              _buildColorSwatch('Highlight', BaseLightTokens.shapeHighlight),
              _buildColorSwatch('Light', BaseLightTokens.shapeLight),
              _buildColorSwatch('Disabled', BaseLightTokens.shapeDisabled),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildSection(
          'Text Colors',
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildColorSwatch('Text Accent', BaseLightTokens.textAccent),
              _buildColorSwatch('Text Subdued', BaseLightTokens.textSubdued),
              _buildColorSwatch('Text Disabled', BaseLightTokens.textDisabled),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildSection(
          'Background Colors',
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildColorSwatch('Frame Default', BaseLightTokens.frameDefault),
              _buildColorSwatch(
                'Frame Contrast',
                BaseLightTokens.frameContrast,
              ),
              _buildColorSwatch(
                'Frame Elevated',
                BaseLightTokens.frameElevated,
              ),
              _buildColorSwatch(
                'Frame Elevated Alt',
                BaseLightTokens.frameElevatedAlt,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildSection(
          'Mode Comparison',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: BaseLightTokens.frameDefault,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Standard Mode (Frame Default - White)',
                      style: AppTypography.textMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This is the default background color for standard mode.',
                      style: AppTypography.textSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: BaseLightTokens.frameContrast,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contrast Mode (Frame Contrast - Dark Blue)',
                      style: AppTypography.textMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This is the contrast background color, used to create visual hierarchy.',
                      style: AppTypography.textSmall.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpacingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Spacing',
          style: AppTypography.displaySmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        _buildSection(
          'Spacing Scale',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSpacingExample('None (0px)', AppSpacing.spaceNone),
              _buildSpacingExample(
                'Extra Small 2 (4px)',
                AppSpacing.spaceExtraSmall2,
              ),
              _buildSpacingExample(
                'Extra Small (8px)',
                AppSpacing.spaceExtraSmall,
              ),
              _buildSpacingExample('Small (12px)', AppSpacing.spaceSmall),
              _buildSpacingExample('Medium (16px)', AppSpacing.spaceMedium),
              _buildSpacingExample('Large (24px)', AppSpacing.spaceLarge),
              _buildSpacingExample(
                'Extra Large (32px)',
                AppSpacing.spaceExtraLarge,
              ),
              _buildSpacingExample(
                'Extra Large 2 (40px)',
                AppSpacing.spaceExtraLarge2,
              ),
              _buildSpacingExample(
                'Extra Large 3 (48px)',
                AppSpacing.spaceExtraLarge3,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BaseLightTokens.frameElevated,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  /// Build a section with contrast background color (for showcasing contrast mode components)
  Widget _buildContrastSection(String title, Widget child) {
    final brightness = Theme.of(context).brightness;
    final backgroundColor = brightness == Brightness.light
        ? BaseLightTokens.frameContrast
        : BaseDarkTokens.frameContrast;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildColorSwatch(String name, Color color) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            name,
            style: AppTypography.textSmall,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildSpacingExample(String label, double spacing) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(label, style: AppTypography.textMedium),
          ),
          Container(
            width: spacing == 0 ? 1 : spacing,
            height: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
