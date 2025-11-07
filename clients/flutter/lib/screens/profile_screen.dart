import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';
import 'package:omsa_demo_app/providers/theme_provider.dart';
import 'package:omsa_demo_app/widgets/theme_picker_drawer.dart';
import 'package:provider/provider.dart';
import 'package:omsa_demo_app/theme/wayfare_tokens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final isLight = Theme.brightnessOf(context) == Brightness.light;

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
                Image.asset('assets/turtle_signed_in.png', width: 130),
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
                        child: Text(
                          'CUSTOMER: 3518474',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: context.wayfareTokens.brandPrimary,
                          ),
                        ),
                      ),
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
                OmsaBadge(variant: OmsaBadgeVariant.information, child: "Demo"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SettingsTile(
            leading: OmsaIcons.ClosedLock(size: 20),
            title: const Text('Username and password'),
            onTap: () {},
          ),
          Divider(
            color: isLight
                ? context.tokens.strokeSubduedAlt
                : context.tokens.frameSubdued,
            indent: 16,
            endIndent: 16,
            height: 1,
          ),
          _SettingsTile(
            leading: OmsaIcons.Banknote(size: 20),
            title: const Text('Card and payment'),
            onTap: () {},
          ),
          Divider(
            height: 1,
            color: isLight
                ? context.tokens.strokeSubduedAlt
                : context.tokens.frameSubdued,
            indent: 16,
            endIndent: 16,
          ),
          _SettingsTile(
            leading: OmsaIcons.Bell(size: 20),
            title: const Text('Notifications'),
            onTap: () {},
          ),
          Divider(
            color: isLight
                ? context.tokens.strokeSubduedAlt
                : context.tokens.frameSubdued,
            indent: 16,
            endIndent: 16,
            height: 1,
          ),
          _SettingsTile(
            leading: OmsaIcons.ShoppingCart(size: 20),
            title: const Text('Purchases and receipts'),
            onTap: () {},
          ),
          Divider(
            color: isLight
                ? context.tokens.strokeSubduedAlt
                : context.tokens.frameSubdued,
            indent: 16,
            endIndent: 16,
            height: 1,
          ),
          _SettingsTile(
            leading: OmsaIcons.ColorPicker(size: 20),
            title: const Text('Theme'),
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
          Divider(
            color: isLight
                ? context.tokens.strokeSubduedAlt
                : context.tokens.frameSubdued,
            indent: 16,
            endIndent: 16,
            height: 1,
          ),
          _SettingsTile(
            leading: OmsaIcons.Value(size: 20),
            title: const Text('Advantages'),
            onTap: () {},
          ),
          Divider(
            color: isLight
                ? context.tokens.strokeSubduedAlt
                : context.tokens.frameSubdued,
            indent: 16,
            endIndent: 16,
            height: 1,
          ),
          _SettingsTile(
            leading: OmsaIcons.Norway(size: 20),
            title: const Text('Language'),
            onTap: () {},
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Version 0.0.1",
              textAlign: TextAlign.center,
              style: AppTypography.textSmall.copyWith(
                color: context.tokens.textSubdued,
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
  });

  final Widget title;
  final Widget leading;
  final VoidCallback onTap;
  final Widget? trailing = null;
  final Widget? subtitle = null;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: context.tokens.textAccent,
      ),
      horizontalTitleGap: 8,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
