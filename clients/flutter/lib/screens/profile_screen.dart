import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';
import 'package:omsa_demo_app/screens/widget_design_screen.dart';

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
  String _language = 'English';

  // Developer options
  int _tapCount = 0;

  final List<String> _categories = [
    'Child (0-15)',
    'Youth (16-19)',
    'Adult (20-66)',
    'Senior (67+)',
    'Student',
  ];

  final List<String> _paymentMethods = [
    'Credit Card ****1234',
    'Debit Card ****5678',
    'Add new payment method',
  ];

  final List<String> _languages = ['English', 'Norwegian', 'Swedish', 'Danish'];

  void _handleVersionTap() {
    setState(() {
      _tapCount++;
    });

    if (_tapCount >= 7) {
      _tapCount = 0;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const WidgetDesignScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User header
            Container(
              padding: const EdgeInsets.all(24),
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              child: Column(
                children: [
                  OmsaIcons.User(size: 64, color: theme.colorScheme.primary),
                  const SizedBox(height: 12),
                  Text('Guest User', style: AppTypography.headlineMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Manage your travel preferences',
                    style: AppTypography.textMedium.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Traveller Settings Section
            _buildSection(
              title: 'Default Traveller Settings',
              children: [
                _buildSettingTile(
                  icon: Icons.person,
                  title: 'Traveller Category',
                  subtitle: _selectedCategory,
                  onTap: () => _showCategoryPicker(context),
                ),
                _buildSettingTile(
                  icon: Icons.cake,
                  title: 'Default Age',
                  subtitle: '$_defaultAge years',
                  onTap: () => _showAgePicker(context),
                ),
                _buildSettingTile(
                  icon: Icons.payment,
                  title: 'Saved Payment Method',
                  subtitle: _paymentMethod ?? 'None',
                  onTap: () => _showPaymentMethodPicker(context),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // App Preferences Section
            _buildSection(
              title: 'App Preferences',
              children: [
                _buildSwitchTile(
                  icon: Icons.notifications,
                  title: 'Push Notifications',
                  subtitle: 'Receive travel updates and offers',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  icon: Icons.dark_mode,
                  title: 'Dark Mode',
                  subtitle: 'Use dark theme',
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
                _buildSettingTile(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: _language,
                  onTap: () => _showLanguagePicker(context),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // About Section
            _buildSection(
              title: 'About',
              children: [
                _buildSettingTile(
                  icon: Icons.info,
                  title: 'Terms of Service',
                  onTap: () {},
                ),
                _buildSettingTile(
                  icon: Icons.privacy_tip,
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
                _buildSettingTile(
                  icon: Icons.help,
                  title: 'Help & Support',
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  title: Text('Version', style: AppTypography.textMedium),
                  subtitle: Text(
                    '1.0.0 (Tap 7 times for developer options)',
                    style: AppTypography.textSmall.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  onTap: _handleVersionTap,
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              title,
              style: AppTypography.textLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          OmsaCard(child: Column(children: children)),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      title: Text(title, style: AppTypography.textMedium),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: AppTypography.textSmall.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: Icon(
        Icons.chevron_right,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);

    return SwitchListTile(
      secondary: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      title: Text(title, style: AppTypography.textMedium),
      subtitle: Text(
        subtitle,
        style: AppTypography.textSmall.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }

  void _showCategoryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        shrinkWrap: true,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return ListTile(
            title: Text(category),
            selected: category == _selectedCategory,
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  void _showAgePicker(BuildContext context) {
    int tempAge = _defaultAge;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Default Age'),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$tempAge years', style: AppTypography.headlineLarge),
                Slider(
                  value: tempAge.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 100,
                  onChanged: (value) {
                    setDialogState(() {
                      tempAge = value.round();
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _defaultAge = tempAge;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethodPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        shrinkWrap: true,
        itemCount: _paymentMethods.length,
        itemBuilder: (context, index) {
          final method = _paymentMethods[index];
          return ListTile(
            leading: const Icon(Icons.credit_card),
            title: Text(method),
            selected: method == _paymentMethod,
            onTap: () {
              setState(() {
                _paymentMethod = method;
              });
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        shrinkWrap: true,
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final lang = _languages[index];
          return ListTile(
            title: Text(lang),
            selected: lang == _language,
            onTap: () {
              setState(() {
                _language = lang;
              });
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
