import 'package:flutter/material.dart';

/// Wayfare-specific brand color tokens with dark mode support.
class WayfareTokens {
  final bool _isLight;

  const WayfareTokens._(this._isLight);

  factory WayfareTokens.of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return WayfareTokens._(brightness == Brightness.light);
  }

  factory WayfareTokens.from(Brightness brightness) {
    return WayfareTokens._(brightness == Brightness.light);
  }

  /// Primary brand color for Wayfare
  /// Light mode: #E90037 (vibrant red)
  /// Dark mode: #FF3355 (slightly lighter, more visible red)
  Color get brandPrimary =>
      _isLight ? const Color(0xFFE90037) : const Color(0xFFFF3355);
}

extension BuildContextWayfareTokens on BuildContext {
  /// Access Wayfare-specific tokens that automatically adapt to light/dark theme
  WayfareTokens get wayfareTokens => WayfareTokens.of(this);
}
