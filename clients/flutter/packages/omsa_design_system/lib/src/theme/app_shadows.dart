import 'package:flutter/material.dart';

/// Shadow definitions for the OMSA Design System
/// Converted from CSS strings to Flutter BoxShadow objects
class AppShadows {
  AppShadows._();

  // CSS string values (for reference/web compatibility)
  static const String shadowsFocusCss = "0 0 0 0.125rem #ffffff, 0 0 0 0.25rem #181c56";
  static const String shadowsFocusContrastCss = "0 0 0 0.125rem #181c56, 0 0 0 0.25rem #ffffff";
  static const String shadowsCardShadowCss = "0 0.0625rem 0.1875rem 0 rgba(0,0,0, 0.12)";
  static const String shadowsCardShadowHoverCss = "0 0.125rem 1rem 0 rgba(0,0,0, 0.1)";
  static const String shadowsCardShadowContrastCss = "0 0.0625rem 0.1875rem 0 rgba(57,61,121, 1)";
  static const String shadowsCardShadowHoverContrastCss = "0 0.125rem 1rem 0 rgba(57,61,121, 1)";
  static const String shadowsBoxShadowCss = "0 0.0625rem 0.1875rem rgba(0,0,0, 0.25)";
  static const String shadowsBoxShadowContrastCss = "0 0.0625rem 0.1875rem rgba(57,61,121, 1)";

  // Flutter BoxShadow objects
  /// Focus shadow - White inner ring (2px) + primary color outer ring (4px)
  /// Typically used with a List for multiple shadows
  static const List<BoxShadow> shadowsFocus = [
    BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 2, // 0.125rem = 2px
      color: Color(0xFFFFFFFF),
    ),
    BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 4, // 0.25rem = 4px
      color: Color(0xFF181C56),
    ),
  ];

  /// Focus shadow (contrast) - Primary color inner ring + white outer ring
  static const List<BoxShadow> shadowsFocusContrast = [
    BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 2, // 0.125rem = 2px
      color: Color(0xFF181C56),
    ),
    BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 4, // 0.25rem = 4px
      color: Color(0xFFFFFFFF),
    ),
  ];

  /// Card shadow - Subtle elevation shadow
  /// 0 1px 3px 0 rgba(0,0,0, 0.12)
  static const List<BoxShadow> shadowsCardShadow = [
    BoxShadow(
      offset: Offset(0, 1), // 0.0625rem = 1px
      blurRadius: 3, // 0.1875rem = 3px
      spreadRadius: 0,
      color: Color(0x1F000000), // rgba(0,0,0, 0.12)
    ),
  ];

  /// Card shadow (hover) - More prominent shadow on hover
  /// 0 2px 16px 0 rgba(0,0,0, 0.1)
  static const List<BoxShadow> shadowsCardShadowHover = [
    BoxShadow(
      offset: Offset(0, 2), // 0.125rem = 2px
      blurRadius: 16, // 1rem = 16px
      spreadRadius: 0,
      color: Color(0x1A000000), // rgba(0,0,0, 0.1)
    ),
  ];

  /// Card shadow (contrast) - Using primary color instead of black
  /// 0 1px 3px 0 rgba(57,61,121, 1)
  static const List<BoxShadow> shadowsCardShadowContrast = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
      color: Color(0xFF393D79), // rgba(57,61,121, 1)
    ),
  ];

  /// Card shadow hover (contrast) - Using primary color
  /// 0 2px 16px 0 rgba(57,61,121, 1)
  static const List<BoxShadow> shadowsCardShadowHoverContrast = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 16,
      spreadRadius: 0,
      color: Color(0xFF393D79), // rgba(57,61,121, 1)
    ),
  ];

  /// Box shadow - Standard drop shadow
  /// 0 1px 3px rgba(0,0,0, 0.25)
  static const List<BoxShadow> shadowsBoxShadow = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
      color: Color(0x40000000), // rgba(0,0,0, 0.25)
    ),
  ];

  /// Box shadow (contrast) - Using primary color
  /// 0 1px 3px rgba(57,61,121, 1)
  static const List<BoxShadow> shadowsBoxShadowContrast = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
      color: Color(0xFF393D79), // rgba(57,61,121, 1)
    ),
  ];
}