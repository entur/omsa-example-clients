import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/display/alert/omsa_alert_colors.dart';
import 'package:omsa_design_system/components/display/alert/omsa_base_alert_box.dart';
import 'package:omsa_icons/omsa_icons.dart';

/// Expandable alert box component matching React's ExpandableAlertBox
class OmsaExpandableAlertBox extends StatefulWidget {
  const OmsaExpandableAlertBox({
    super.key,
    required this.variant,
    required this.size,
    required this.title,
    required this.children,
    this.openLabel = 'Les mer',
    this.closeLabel = 'Lukk',
    this.mode = OmsaComponentMode.standard,
  });

  final OmsaAlertVariant variant;
  final OmsaAlertSize size;
  final Widget title;
  final Widget children;
  final String openLabel;
  final String closeLabel;
  final OmsaComponentMode mode;

  @override
  State<OmsaExpandableAlertBox> createState() => _OmsaExpandableAlertBoxState();
}

class _OmsaExpandableAlertBoxState extends State<OmsaExpandableAlertBox>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleOpen() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OmsaBaseAlertBox(
      variant: widget.variant,
      size: widget.size,
      mode: widget.mode,
      title: _ExpandableAlertBoxTitle(
        title: widget.title,
        isOpen: _isOpen,
        openLabel: widget.openLabel,
        closeLabel: widget.closeLabel,
        onToggle: _toggleOpen,
      ),
      children: SizeTransition(
        sizeFactor: _animation,
        axisAlignment: -1.0,
        child: widget.children,
      ),
    );
  }
}

class _ExpandableAlertBoxTitle extends StatelessWidget {
  const _ExpandableAlertBoxTitle({
    required this.title,
    required this.isOpen,
    required this.openLabel,
    required this.closeLabel,
    required this.onToggle,
  });

  final Widget title;
  final bool isOpen;
  final String openLabel;
  final String closeLabel;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(child: title),
        TextButton(
          onPressed: onToggle,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isOpen ? closeLabel : openLabel,
                style: DefaultTextStyle.of(context).style,
              ),
              const SizedBox(width: 4.0),
              AnimatedRotation(
                turns: isOpen ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: OmsaIcons.DownArrow(size: 18.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Banner-sized expandable alert box matching React's BannerExpandableAlertBox
class OmsaBannerExpandableAlertBox extends StatelessWidget {
  const OmsaBannerExpandableAlertBox({
    super.key,
    required this.variant,
    required this.title,
    required this.children,
    this.openLabel = 'Les mer',
    this.closeLabel = 'Lukk',
    this.mode = OmsaComponentMode.standard,
  });

  final OmsaAlertVariant variant;
  final Widget title;
  final Widget children;
  final String openLabel;
  final String closeLabel;
  final OmsaComponentMode mode;

  @override
  Widget build(BuildContext context) {
    return OmsaExpandableAlertBox(
      variant: variant,
      size: OmsaAlertSize.banner,
      title: title,
      openLabel: openLabel,
      closeLabel: closeLabel,
      mode: mode,
      children: children,
    );
  }
}

/// Small-sized expandable alert box matching React's SmallExpandableAlertBox
class OmsaSmallExpandableAlertBox extends StatelessWidget {
  const OmsaSmallExpandableAlertBox({
    super.key,
    required this.variant,
    required this.title,
    required this.children,
    this.openLabel = 'Les mer',
    this.closeLabel = 'Lukk',
    this.mode = OmsaComponentMode.standard,
  });

  final OmsaAlertVariant variant;
  final Widget title;
  final Widget children;
  final String openLabel;
  final String closeLabel;
  final OmsaComponentMode mode;

  @override
  Widget build(BuildContext context) {
    return OmsaExpandableAlertBox(
      variant: variant,
      size: OmsaAlertSize.small,
      title: title,
      openLabel: openLabel,
      closeLabel: closeLabel,
      mode: mode,
      children: children,
    );
  }
}
