import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/widgets/component_showcase.dart';

class ChipShowcase extends ComponentShowcase {
  const ChipShowcase({super.key});

  @override
  String get title => 'Chips';

  @override
  State<ChipShowcase> createState() => _ChipShowcaseState();
}

class _ChipShowcaseState extends State<ChipShowcase> {
  static const List<String> _defaultTags = ['Oslo', 'Bergen', 'Trondheim'];

  String _selectedChoice = 'bus';
  String _selectedChoiceContrast = 'bus';

  final Set<String> _selectedFilters = {'bus'};
  final Set<String> _selectedFiltersContrast = {'bus'};

  final List<String> _tags = List.of(_defaultTags);
  final List<String> _contrastTags = List.of(_defaultTags);

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
          label: 'Action Chips',
          child: VariantShowcase(
            children: [
              OmsaActionChip(label: const Text('Default'), onPressed: () {}),
              OmsaActionChip(
                label: const Text('Leading icon'),
                onPressed: () {},
                leadingIcon: const Icon(Icons.directions_bus),
              ),
              OmsaActionChip(
                label: const Text('Trailing icon'),
                onPressed: () {},
                trailingIcon: const Icon(Icons.arrow_forward),
              ),
              OmsaActionChip(
                label: const Text('Loading'),
                onPressed: () {},
                loading: true,
              ),
              OmsaActionChip(
                label: const Text('Disabled'),
                onPressed: () {},
                disabled: true,
              ),
              OmsaActionChip(
                size: OmsaChipSize.small,
                label: const Text('Small'),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Action Chips (Contrast Mode)',
          mode: OmsaComponentMode.contrast,
          child: VariantShowcase(
            children: [
              OmsaActionChip(
                mode: OmsaComponentMode.contrast,
                label: const Text('Default'),
                onPressed: () {},
              ),
              OmsaActionChip(
                mode: OmsaComponentMode.contrast,
                label: const Text('Loading'),
                onPressed: () {},
                loading: true,
              ),
              OmsaActionChip(
                mode: OmsaComponentMode.contrast,
                label: const Text('Disabled'),
                onPressed: () {},
                disabled: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Choice Chips',
          child: OmsaChoiceChipGroup(
            value: _selectedChoice,
            onChanged: (value) {
              setState(() {
                _selectedChoice = value;
              });
            },
            label: const Text('Preferred transport'),
            children: [
              OmsaChoiceChip(
                value: 'bus',
                label: const Text('Bus'),
                leadingIcon: const Icon(Icons.directions_bus),
              ),
              OmsaChoiceChip(value: 'train', label: const Text('Train')),
              OmsaChoiceChip(
                value: 'tram',
                label: const Text('Tram'),
                size: OmsaChipSize.small,
              ),
              OmsaChoiceChip(
                value: 'disabled',
                label: const Text('Disabled'),
                disabled: true,
                size: OmsaChipSize.small,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Choice Chips (Contrast Mode)',
          mode: OmsaComponentMode.contrast,
          child: OmsaChoiceChipGroup(
            mode: OmsaComponentMode.contrast,
            value: _selectedChoiceContrast,
            onChanged: (value) {
              setState(() {
                _selectedChoiceContrast = value;
              });
            },
            label: const Text('Preferred transport'),
            children: [
              OmsaChoiceChip(
                mode: OmsaComponentMode.contrast,
                value: 'bus',
                label: const Text('Bus'),
                leadingIcon: const Icon(Icons.directions_bus),
              ),
              OmsaChoiceChip(
                mode: OmsaComponentMode.contrast,
                value: 'train',
                label: const Text('Train'),
              ),
              OmsaChoiceChip(
                mode: OmsaComponentMode.contrast,
                value: 'tram',
                label: const Text('Tram'),
                size: OmsaChipSize.small,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Filter Chips',
          child: VariantShowcase(
            children: _buildFilterChips(
              values: const ['Bus', 'Train', 'Metro', 'Ferry'],
              selectedSet: _selectedFilters,
              mode: OmsaComponentMode.standard,
            ),
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Filter Chips (Contrast Mode)',
          mode: OmsaComponentMode.contrast,
          child: VariantShowcase(
            children: _buildFilterChips(
              values: const ['Bus', 'Train', 'Metro', 'Ferry'],
              selectedSet: _selectedFiltersContrast,
              mode: OmsaComponentMode.contrast,
            ),
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Tag Chips',
          child: VariantShowcase(
            children: _buildTagChips(
              tags: _tags,
              mode: OmsaComponentMode.standard,
              includeLeadingIcon: true,
              onClose: (tag) {
                setState(() {
                  _tags.remove(tag);
                });
              },
              onReset: () {
                setState(() {
                  _tags
                    ..clear()
                    ..addAll(_defaultTags);
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Tag Chips (Contrast Mode)',
          mode: OmsaComponentMode.contrast,
          child: VariantShowcase(
            children: _buildTagChips(
              tags: _contrastTags,
              mode: OmsaComponentMode.contrast,
              onClose: (tag) {
                setState(() {
                  _contrastTags.remove(tag);
                });
              },
              onReset: () {
                setState(() {
                  _contrastTags
                    ..clear()
                    ..addAll(_defaultTags);
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFilterChips({
    required Iterable<String> values,
    required Set<String> selectedSet,
    required OmsaComponentMode mode,
  }) {
    return values.map((value) {
      final key = value.toLowerCase();
      return OmsaFilterChip(
        mode: mode,
        value: key,
        label: Text(value),
        selected: selectedSet.contains(key),
        onSelected: (selected) {
          setState(() {
            if (selected) {
              selectedSet.add(key);
            } else {
              selectedSet.remove(key);
            }
          });
        },
        leadingIcon: const Icon(Icons.tune),
      );
    }).toList();
  }

  List<Widget> _buildTagChips({
    required List<String> tags,
    required OmsaComponentMode mode,
    required void Function(String tag) onClose,
    required VoidCallback onReset,
    bool includeLeadingIcon = false,
  }) {
    final List<Widget> chips = tags
        .map(
          (tag) => OmsaTagChip(
            mode: mode,
            label: Text(tag),
            leadingIcon: includeLeadingIcon
                ? const Icon(Icons.location_on_outlined)
                : null,
            onClose: () => onClose(tag),
          ),
        )
        .toList();

    if (chips.isEmpty) {
      chips.add(
        OmsaActionChip(
          mode: mode,
          label: const Text('Reset tags'),
          onPressed: onReset,
        ),
      );
    }

    return chips;
  }
}
