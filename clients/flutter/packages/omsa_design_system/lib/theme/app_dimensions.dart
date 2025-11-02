import 'package:flutter/material.dart';

/// Dimension constants for the OMSA Design System
/// Includes border widths, border radiuses, z-indexes, and breakpoints
class AppDimensions {
  AppDimensions._();

  // Border Widths
  /// 1px - Small border width
  static const double borderWidthsSmall = 1.0;

  /// 2px - Default/Medium border width
  static const double borderWidthsDefault = 2.0;

  /// 2px - Medium border width (alias)
  static const double borderWidthsMedium = 2.0;

  /// 4px - Large border width
  static const double borderWidthsLarge = 4.0;

  // Border Radii (raw values)
  /// 1px - Small border radius
  static const double borderRadiusesSmall = 1.0;

  /// 1px - Default border radius
  static const double borderRadiusesDefault = 1.0;

  /// 4px - Medium border radius
  static const double borderRadiusesMedium = 4.0;

  /// 8px - Large border radius
  static const double borderRadiusesLarge = 8.0;

  // Flutter BorderRadius helpers
  /// BorderRadius with small radius (1px)
  static BorderRadius get borderRadiusSmall =>
      BorderRadius.circular(borderRadiusesSmall);

  /// BorderRadius with default radius (1px)
  static BorderRadius get borderRadiusDefault =>
      BorderRadius.circular(borderRadiusesDefault);

  /// BorderRadius with medium radius (4px)
  static BorderRadius get borderRadiusMedium =>
      BorderRadius.circular(borderRadiusesMedium);

  /// BorderRadius with large radius (8px)
  static BorderRadius get borderRadiusLarge =>
      BorderRadius.circular(borderRadiusesLarge);

  /// Rounded borders (large radius) for top-left and top-right only
  static BorderRadius get borderRadiusLargeTop => const BorderRadius.only(
    topLeft: Radius.circular(borderRadiusesLarge),
    topRight: Radius.circular(borderRadiusesLarge),
  );

  /// Rounded borders (large radius) for bottom-left and bottom-right only
  static BorderRadius get borderRadiusLargeBottom => const BorderRadius.only(
    bottomLeft: Radius.circular(borderRadiusesLarge),
    bottomRight: Radius.circular(borderRadiusesLarge),
  );

  // Z-Indexes (for stacking order)
  /// Behind content
  static const int zIndexesBehind = -1;

  /// Default layer
  static const int zIndexesDefault = 0;

  /// Sticky elements
  static const int zIndexesSticky = 10;

  /// Popovers and tooltips
  static const int zIndexesPopover = 20;

  /// Overlays
  static const int zIndexesOverlay = 30;

  /// Modals and dialogs
  static const int zIndexesModal = 40;

  /// Toasts and notifications
  static const int zIndexesToast = 50;

  // Breakpoints
  /// 800px - Large screen breakpoint
  static const double breakpointsLarge = 800.0;

  /// 1200px - Extra large screen breakpoint
  static const double breakpointsExtraLarge = 1200.0;
}
