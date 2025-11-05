import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/widgets/component_showcase.dart';
import 'package:omsa_demo_app/widgets/showcases/showcases.dart';

/// Registry for all component showcases
class ShowcaseRegistry {
  static final List<ComponentShowcase> showcases = [
    const ButtonShowcase(),
    const ChipShowcase(),
    const BadgeTagShowcase(),
    const InputShowcase(),
    const CardShowcase(),
    const DisplayShowcase(),
    const TypographyShowcase(),
    const ColorShowcase(),
    const SpacingShowcase(),
  ];
}

/// Main widget design screen with improved architecture
class WidgetDesignScreen extends StatefulWidget {
  const WidgetDesignScreen({super.key});

  @override
  State<WidgetDesignScreen> createState() => _WidgetDesignScreenState();
}

class _WidgetDesignScreenState extends State<WidgetDesignScreen> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? AppTheme.dark() : AppTheme.light(),
      child: Builder(
        builder: (context) {
          final brightness = Theme.of(context).brightness;
          final backgroundColor = brightness == Brightness.light
              ? BaseLightTokens.frameDefault
              : BaseDarkTokens.frameDefault;
          final sidebarColor = brightness == Brightness.light
              ? BaseLightTokens.frameElevatedAlt
              : BaseDarkTokens.frameElevatedAlt;

          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              title: const Text('Widget Design Lab'),
              backgroundColor: sidebarColor,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.wb_sunny,
                        size: 20,
                        color: !_isDarkMode ? Colors.amber : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Switch(
                        value: _isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            _isDarkMode = value;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.nightlight_round,
                        size: 20,
                        color: _isDarkMode ? Colors.blue : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Row(
              children: [
                _buildSidebar(context, sidebarColor),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: ShowcaseRegistry.showcases[_selectedIndex],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, Color sidebarColor) {
    final brightness = Theme.of(context).brightness;

    return Container(
      width: 200,
      color: sidebarColor,
      child: ListView.builder(
        itemCount: ShowcaseRegistry.showcases.length,
        itemBuilder: (context, index) {
          final showcase = ShowcaseRegistry.showcases[index];
          final isSelected = index == _selectedIndex;
          final textColor = brightness == Brightness.light
              ? BaseLightTokens.textAccent
              : BaseDarkTokens.textAccent;
          final selectedColor = brightness == Brightness.light
              ? BaseLightTokens.frameElevated
              : BaseDarkTokens.frameElevated;

          return ListTile(
            title: Text(
              showcase.title,
              style: AppTypography.textMedium.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : textColor,
              ),
            ),
            selected: isSelected,
            selectedTileColor: selectedColor,
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}
