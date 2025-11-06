import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';
import 'package:omsa_demo_app/providers/theme_provider.dart';

class ThemePickerDrawer extends StatefulWidget {
  final AppThemeMode initialThemeMode;

  const ThemePickerDrawer({
    super.key,
    required this.initialThemeMode,
  });

  @override
  State<ThemePickerDrawer> createState() => _ThemePickerDrawerState();

  static Future<AppThemeMode?> show(
    BuildContext context, {
    required AppThemeMode initialThemeMode,
  }) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    return showModalBottomSheet<AppThemeMode>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: isLight
          ? BaseLightTokens.frameTint
          : BaseDarkTokens.frameTint,
      builder: (context) => ThemePickerDrawer(
        initialThemeMode: initialThemeMode,
      ),
    );
  }
}

class _ThemePickerDrawerState extends State<ThemePickerDrawer> {
  late AppThemeMode _selectedThemeMode;

  @override
  void initState() {
    super.initState();
    _selectedThemeMode = widget.initialThemeMode;
  }

  void _submit() {
    Navigator.of(context).pop(_selectedThemeMode);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

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
                  'Choose theme',
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
            OmsaRadioPanelGroup<AppThemeMode>(
              value: _selectedThemeMode,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedThemeMode = value;
                  });
                }
              },
              options: [
                OmsaRadioPanelOption(
                  value: AppThemeMode.light,
                  title: const Text('Light'),
                ),
                OmsaRadioPanelOption(
                  value: AppThemeMode.dark,
                  title: const Text('Dark'),
                ),
                OmsaRadioPanelOption(
                  value: AppThemeMode.system,
                  title: const Text('System'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            OmsaButton(
              onPressed: _submit,
              width: OmsaButtonWidth.fluid,
              child: const Text('Apply theme'),
            ),
          ],
        ),
      ),
    );
  }
}
