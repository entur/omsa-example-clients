import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/widgets/component_showcase.dart';
import 'package:omsa_icons/omsa_icons.dart';

class BadgeTagShowcase extends ComponentShowcase {
  const BadgeTagShowcase({super.key});

  @override
  String get title => 'Badges & Tags';

  @override
  State<BadgeTagShowcase> createState() => _BadgeTagShowcaseState();
}

class _BadgeTagShowcaseState extends State<BadgeTagShowcase> {
  int _notificationCount = 5;
  bool _hideBadge = false;

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

        // Tags Section
        Text(
          'Tags',
          style: AppTypography.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        ComponentExample(
          label: 'Basic Tags',
          child: VariantShowcase(
            children: [
              const OmsaTag(child: Text('Default')),
              OmsaTag(
                leadingIcon: OmsaIcons.Check(size: 16),
                child: const Text('With Leading Icon'),
              ),
              OmsaTag(
                trailingIcon: OmsaIcons.Close(size: 16),
                child: const Text('With Trailing Icon'),
              ),
              OmsaTag(
                leadingIcon: OmsaIcons.MapPin(size: 14),
                trailingIcon: OmsaIcons.Close(size: 14),
                child: const Text('Both Icons'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Compact Tags (for tables)',
          child: VariantShowcase(
            children: [
              const OmsaTag(compact: true, child: Text('Compact')),
              OmsaTag(
                compact: true,
                leadingIcon: OmsaIcons.Check(size: 12),
                child: const Text('With Icon'),
              ),
              const OmsaTag(compact: true, child: Text('Active')),
              const OmsaTag(compact: true, child: Text('Pending')),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Tags (Contrast Mode)',
          mode: OmsaComponentMode.contrast,
          child: VariantShowcase(
            children: [
              const OmsaTag(
                mode: OmsaComponentMode.contrast,
                child: Text('Contrast'),
              ),
              OmsaTag(
                mode: OmsaComponentMode.contrast,
                leadingIcon: OmsaIcons.Check(size: 16),
                child: const Text('With Icon'),
              ),
              const OmsaTag(
                mode: OmsaComponentMode.contrast,
                compact: true,
                child: Text('Compact'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Badges Section
        Text(
          'Badges',
          style: AppTypography.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        ComponentExample(
          label: 'Status Badges',
          child: VariantShowcase(
            children: const [
              OmsaStatusBadge(
                variant: OmsaBadgeVariant.primary,
                child: Text('Primary'),
              ),
              OmsaStatusBadge(
                variant: OmsaBadgeVariant.success,
                child: Text('Success'),
              ),
              OmsaStatusBadge(
                variant: OmsaBadgeVariant.warning,
                child: Text('Warning'),
              ),
              OmsaStatusBadge(
                variant: OmsaBadgeVariant.negative,
                child: Text('Error'),
              ),
              OmsaStatusBadge(
                variant: OmsaBadgeVariant.information,
                child: Text('Info'),
              ),
              OmsaStatusBadge(
                variant: OmsaBadgeVariant.neutral,
                child: Text('Neutral'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Status Badges (Contrast Mode)',
          mode: OmsaComponentMode.contrast,
          child: VariantShowcase(
            children: const [
              OmsaStatusBadge(
                variant: OmsaBadgeVariant.primary,
                mode: OmsaComponentMode.contrast,
                child: Text('Primary'),
              ),
              OmsaStatusBadge(
                variant: OmsaBadgeVariant.success,
                mode: OmsaComponentMode.contrast,
                child: Text('Success'),
              ),
              OmsaStatusBadge(
                variant: OmsaBadgeVariant.warning,
                mode: OmsaComponentMode.contrast,
                child: Text('Warning'),
              ),
              OmsaStatusBadge(
                variant: OmsaBadgeVariant.negative,
                mode: OmsaComponentMode.contrast,
                child: Text('Error'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Notification Badges',
          child: VariantShowcase(
            children: [
              OmsaNotificationBadge(
                variant: OmsaBadgeVariant.primary,
                child: _notificationCount,
                hide: _hideBadge,
              ),
              const OmsaNotificationBadge(
                variant: OmsaBadgeVariant.negative,
                child: 99,
              ),
              const OmsaNotificationBadge(
                variant: OmsaBadgeVariant.warning,
                child: 150,
                max: 99,
              ),
              const OmsaNotificationBadge(
                variant: OmsaBadgeVariant.success,
                child: 0,
                showZero: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Interactive controls
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _notificationCount++;
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('Increment'),
            ),
            ElevatedButton.icon(
              onPressed: _notificationCount > 0
                  ? () {
                      setState(() {
                        _notificationCount--;
                      });
                    }
                  : null,
              icon: const Icon(Icons.remove),
              label: const Text('Decrement'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _hideBadge = !_hideBadge;
                });
              },
              icon: Icon(_hideBadge ? Icons.visibility : Icons.visibility_off),
              label: Text(_hideBadge ? 'Show' : 'Hide'),
            ),
          ],
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Notification Badges (Contrast Mode)',
          mode: OmsaComponentMode.contrast,
          child: VariantShowcase(
            children: const [
              OmsaNotificationBadge(
                variant: OmsaBadgeVariant.primary,
                mode: OmsaComponentMode.contrast,
                child: 5,
              ),
              OmsaNotificationBadge(
                variant: OmsaBadgeVariant.negative,
                mode: OmsaComponentMode.contrast,
                child: 42,
              ),
              OmsaNotificationBadge(
                variant: OmsaBadgeVariant.success,
                mode: OmsaComponentMode.contrast,
                child: 100,
                max: 99,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Bullet Badges',
          child: VariantShowcase(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              OmsaBulletBadge(
                variant: OmsaBadgeVariant.primary,
                child: Text('Primary bullet point item'),
              ),
              OmsaBulletBadge(
                variant: OmsaBadgeVariant.success,
                child: Text('Success bullet point item'),
              ),
              OmsaBulletBadge(
                variant: OmsaBadgeVariant.warning,
                child: Text('Warning bullet point item'),
              ),
              OmsaBulletBadge(
                variant: OmsaBadgeVariant.negative,
                child: Text('Negative bullet point item'),
              ),
              OmsaBulletBadge(
                variant: OmsaBadgeVariant.information,
                child: Text('Information bullet point item'),
              ),
              OmsaBulletBadge(
                variant: OmsaBadgeVariant.neutral,
                child: Text('Neutral bullet point item'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ComponentExample(
          label: 'Bullet Badges (Contrast Mode)',
          mode: OmsaComponentMode.contrast,
          child: VariantShowcase(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              OmsaBulletBadge(
                variant: OmsaBadgeVariant.primary,
                mode: OmsaComponentMode.contrast,
                child: Text('Primary bullet point'),
              ),
              OmsaBulletBadge(
                variant: OmsaBadgeVariant.success,
                mode: OmsaComponentMode.contrast,
                child: Text('Success bullet point'),
              ),
              OmsaBulletBadge(
                variant: OmsaBadgeVariant.warning,
                mode: OmsaComponentMode.contrast,
                child: Text('Warning bullet point'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
