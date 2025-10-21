import 'package:flutter/material.dart';
import 'package:omsa_design_system/src/theme/app_semantic_colors.dart';

/// Extension methods for accessing theme extensions easily
extension ThemeExtensions on BuildContext {
  /// Get semantic colors from theme
  AppSemanticColors get semanticColors =>
      Theme.of(this).extension<AppSemanticColors>() ??
      AppSemanticColors.light;
}
