import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';

class WidgetDesignScreen extends StatefulWidget {
  const WidgetDesignScreen({super.key});

  @override
  State<WidgetDesignScreen> createState() => _WidgetDesignScreenState();
}

class _WidgetDesignScreenState extends State<WidgetDesignScreen> {
  String _selectedCategory = 'Buttons';

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
    final semanticColors = context.semanticColors;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Design Lab'),
        backgroundColor: semanticColors.frameElevatedAlt,
      ),
      body: Row(
        children: [
          Container(
            width: 200,
            color: semanticColors.frameElevatedAlt,
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;

                return ListTile(
                  title: Text(
                    category,
                    style: AppTypography.textMedium.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : semanticColors.textAccent,
                    ),
                  ),
                  selected: isSelected,
                  selectedTileColor: semanticColors.frameElevated,
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
          'Primary Buttons',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Large Size:'),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                size: OmsaButtonSize.large,
                child: const Text('Large Primary Button'),
              ),
              const SizedBox(height: 16),

              const Text('Medium Size:'),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                size: OmsaButtonSize.medium,
                child: const Text('Medium Primary Button'),
              ),
              const SizedBox(height: 16),

              const Text('Small Size:'),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: () {},
                size: OmsaButtonSize.small,
                child: const Text('Small Primary Button'),
              ),
              const SizedBox(height: 16),

              const Text('Disabled:'),
              const SizedBox(height: 8),
              OmsaButton(
                onPressed: null,
                child: const Text('Disabled Button'),
              ),
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
          'Secondary Buttons',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OmsaButton(
                onPressed: () {},
                variant: OmsaButtonVariant.secondary,
                child: const Text('Secondary Button'),
              ),
              const SizedBox(height: 16),

              OmsaButton(
                onPressed: null,
                variant: OmsaButtonVariant.secondary,
                child: const Text('Disabled Secondary'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        _buildSection(
          'Success & Negative Buttons',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OmsaButton(
                onPressed: () {},
                variant: OmsaButtonVariant.success,
                child: const Text('Success Button'),
              ),
              const SizedBox(height: 16),

              OmsaButton(
                onPressed: () {},
                variant: OmsaButtonVariant.negative,
                child: const Text('Negative Button'),
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
                child: const Text('Full Width Button'),
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
          'Floating Action Buttons',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Standard Size:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  OmsaFloatingButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                  OmsaFloatingButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                  OmsaFloatingButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                  ),
                  OmsaFloatingButton(
                    onPressed: null,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text('Small Size:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  OmsaFloatingButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    size: OmsaFloatingButtonSize.small,
                  ),
                  OmsaFloatingButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    size: OmsaFloatingButtonSize.small,
                  ),
                  OmsaFloatingButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                    size: OmsaFloatingButtonSize.small,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text('Extended with Labels:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  OmsaFloatingButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: 'Add Item',
                  ),
                  OmsaFloatingButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: 'Edit',
                  ),
                  OmsaFloatingButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                    label: 'Share',
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text('Loading State:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  OmsaFloatingButton(
                    onPressed: () {},
                    icon: const Icon(Icons.save),
                    isLoading: true,
                  ),
                  OmsaFloatingButton(
                    onPressed: () {},
                    icon: const Icon(Icons.save),
                    label: 'Saving...',
                    isLoading: true,
                    size: OmsaFloatingButtonSize.small,
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
          'Text Fields',
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
                label: 'Number Field',
                hint: '123',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              OmsaTextField(
                label: 'With Validator',
                hint: 'Required field',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
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
                items: const [
                  DropdownMenuItem(value: '1', child: Text('Option 1')),
                  DropdownMenuItem(value: '2', child: Text('Option 2')),
                  DropdownMenuItem(value: '3', child: Text('Option 3')),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),

              OmsaDropdown<String>(
                label: 'With Selected Value',
                value: '2',
                items: const [
                  DropdownMenuItem(value: '1', child: Text('Option 1')),
                  DropdownMenuItem(value: '2', child: Text('Option 2')),
                  DropdownMenuItem(value: '3', child: Text('Option 3')),
                ],
                onChanged: (value) {},
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
              OmsaChip(
                label: const Text('Default Chip'),
                onDeleted: () {},
              ),
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
    final semanticColors = context.semanticColors;

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
              _buildColorSwatch('Primary', Theme.of(context).colorScheme.primary),
              _buildColorSwatch('Primary Container', Theme.of(context).colorScheme.primaryContainer),
              _buildColorSwatch('On Primary', Theme.of(context).colorScheme.onPrimary),
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
              _buildColorSwatch('Secondary', Theme.of(context).colorScheme.secondary),
              _buildColorSwatch('Secondary Container', Theme.of(context).colorScheme.secondaryContainer),
              _buildColorSwatch('On Secondary', Theme.of(context).colorScheme.onSecondary),
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
              _buildColorSwatch('Accent', semanticColors.shapeAccent),
              _buildColorSwatch('Highlight', semanticColors.shapeHighlight),
              _buildColorSwatch('Light', semanticColors.shapeLight),
              _buildColorSwatch('Disabled', semanticColors.shapeDisabled),
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
              _buildColorSwatch('Text Accent', semanticColors.textAccent),
              _buildColorSwatch('Text Subdued', semanticColors.textSubdued),
              _buildColorSwatch('Text Disabled', semanticColors.textDisabled),
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
              _buildColorSwatch('Frame Default', semanticColors.frameDefault),
              _buildColorSwatch('Frame Elevated', semanticColors.frameElevated),
              _buildColorSwatch('Frame Elevated Alt', semanticColors.frameElevatedAlt),
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
              _buildSpacingExample('Extra Small 2 (4px)', AppSpacing.spaceExtraSmall2),
              _buildSpacingExample('Extra Small (8px)', AppSpacing.spaceExtraSmall),
              _buildSpacingExample('Small (12px)', AppSpacing.spaceSmall),
              _buildSpacingExample('Medium (16px)', AppSpacing.spaceMedium),
              _buildSpacingExample('Large (24px)', AppSpacing.spaceLarge),
              _buildSpacingExample('Extra Large (32px)', AppSpacing.spaceExtraLarge),
              _buildSpacingExample('Extra Large 2 (40px)', AppSpacing.spaceExtraLarge2),
              _buildSpacingExample('Extra Large 3 (48px)', AppSpacing.spaceExtraLarge3),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, Widget child) {
    final semanticColors = context.semanticColors;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: semanticColors.frameElevated,
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
            child: Text(
              label,
              style: AppTypography.textMedium,
            ),
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
