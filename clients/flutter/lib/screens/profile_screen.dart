import 'package:flutter/material.dart';
import 'package:omsa_demo_app/widgets/demo_badge.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';
import 'package:omsa_demo_app/screens/widget_design_screen.dart';
import 'package:omsa_demo_app/providers/theme_provider.dart';
import 'package:omsa_demo_app/widgets/theme_picker_drawer.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Traveller settings
  int _defaultAge = 30;
  String _selectedCategory = 'Adult';
  String? _paymentMethod;

  // App preferences
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricsEnabled = false;
  bool _soundEffectsEnabled = true;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 48),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset('assets/turtle_signed_in.png', width: 100),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4,
                    children: [
                      Text(
                        "Hi!",
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Currently logged in as superturtle@wayfare.no",
                        softWrap: true,
                        style: AppTypography.bodySmall,
                      ),
                      OmsaBadge(
                        variant: OmsaBadgeVariant.neutral,
                        child: Text('CUSTOMER: 3518474', style: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFFE90037))),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text('Your profile', style: AppTypography.headingExtraLarge2),
                const SizedBox(width: 12),
                DemoBadge(text: "Demo"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SettingsTile(
            leading: OmsaIcons.ClosedLock(size: 20),
            title: const Text(
              'Username and password',
              style: AppTypography.titleSmall,
            ),
            onTap: () {},
          ),
          const Divider(
            color: BaseLightTokens.strokeSubduedAlt,
            indent: 16,
            endIndent: 16,
            height: 1,
          ),
          _SettingsTile(
            leading: OmsaIcons.Banknote(size: 20),
            title: const Text(
              'Card and payment',
              style: AppTypography.titleSmall,
            ),
            onTap: () {},
          ),
          const Divider(
            height: 1,
            color: BaseLightTokens.strokeSubduedAlt,
            indent: 16,
            endIndent: 16,
          ),
          _SettingsTile(
            leading: OmsaIcons.Bell(size: 20),
            title: const Text('Notifications', style: AppTypography.titleSmall),
            onTap: () {},
          ),
          const Divider(
            color: BaseLightTokens.strokeSubduedAlt,
            indent: 16,
            endIndent: 16,
            height: 1,
          ),
          _SettingsTile(
            leading: OmsaIcons.ShoppingCart(size: 20),
            title: const Text(
              'Purchases and receipts',
              style: AppTypography.titleSmall,
            ),
            onTap: () {},
          ),
          const Divider(
            color: BaseLightTokens.strokeSubduedAlt,
            indent: 16,
            endIndent: 16,
            height: 1,
          ),
          _SettingsTile(
            leading: OmsaIcons.ColorPicker(size: 20),
            title: const Text('Theme', style: AppTypography.titleSmall),
            onTap: () async {
              final themeProvider = context.read<ThemeProvider>();
              final result = await ThemePickerDrawer.show(
                context,
                initialThemeMode: themeProvider.themeMode,
              );
              if (result != null) {
                themeProvider.setThemeMode(result);
              }
            },
          ),
          const Divider(
            color: BaseLightTokens.strokeSubduedAlt,
            indent: 16,
            endIndent: 16,
            height: 1,
          ),
          _SettingsTile(
            leading: OmsaIcons.Value(size: 20),
            title: const Text('Advantages', style: AppTypography.titleSmall),
            onTap: () {},
          ),
          const Divider(
            color: BaseLightTokens.strokeSubduedAlt,
            indent: 16,
            endIndent: 16,
            height: 1,
          ),
          _SettingsTile(
            leading: OmsaIcons.Norway(size: 20),
            title: const Text('Language', style: AppTypography.titleSmall),
            onTap: () {},
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Version 0.0.1",
              textAlign: TextAlign.center,
              style: AppTypography.textSmall.copyWith(
                color: BaseLightTokens.textSubdued,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    required this.leading,
    required this.onTap,
    this.trailing,
    this.subtitle,
  });

  final Widget title;
  final Widget leading;
  final VoidCallback onTap;
  final Widget? trailing;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 8,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
