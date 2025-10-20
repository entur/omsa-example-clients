import 'package:flutter/material.dart';

/// Semantic color system for OMSA Design System
/// Generated from base_colors.json with light and dark mode support
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    // Frame (Background) Colors
    required this.frameContrast,
    required this.frameContrastAlt,
    required this.frameContrastAlt2,
    required this.frameDefault,
    required this.frameElevated,
    required this.frameElevatedAlt,
    required this.frameSubdued,
    required this.frameTint,
    // Shape Colors - General
    required this.shapeAccent,
    required this.shapeDisabled,
    required this.shapeDisabledAlt,
    required this.shapeHighlight,
    required this.shapeLight,
    required this.shapeMask,
    required this.shapeMaskAlt,
    required this.shapeSubdued,
    required this.shapeSubduedAlt,
    // Shape Colors - Transport Modes
    required this.shapeBicycleContrast,
    required this.shapeBicycleDefault,
    required this.shapeBusContrast,
    required this.shapeBusDefault,
    required this.shapeCablewayContrast,
    required this.shapeCablewayDefault,
    required this.shapeFerryContrast,
    required this.shapeFerryDefault,
    required this.shapeFunicularContrast,
    required this.shapeFunicularDefault,
    required this.shapeHelicopterContrast,
    required this.shapeHelicopterDefault,
    required this.shapeMetroContrast,
    required this.shapeMetroDefault,
    required this.shapeMobilityContrast,
    required this.shapeMobilityDefault,
    required this.shapePlaneContrast,
    required this.shapePlaneDefault,
    required this.shapeTaxiContrast,
    required this.shapeTaxiDefault,
    required this.shapeTrainContrast,
    required this.shapeTrainDefault,
    required this.shapeTramContrast,
    required this.shapeTramDefault,
    required this.shapeWalkContrast,
    required this.shapeWalkDefault,
    required this.shapeAirportLinkBusContrast,
    required this.shapeAirportLinkBusDefault,
    required this.shapeAirportLinkRailContrast,
    required this.shapeAirportLinkRailDefault,
    // Stroke (Border) Colors
    required this.strokeContrast,
    required this.strokeDefault,
    required this.strokeDisabled,
    required this.strokeFocusContrast,
    required this.strokeFocusStandard,
    required this.strokeHighlight,
    required this.strokeLight,
    required this.strokeSubdued,
    required this.strokeSubduedAlt,
    // Text Colors
    required this.textAccent,
    required this.textDisabled,
    required this.textDisabledAlt,
    required this.textHighlight,
    required this.textLight,
    required this.textSubdued,
    required this.textSubduedAlt,
  });

  // Frame (Background) Colors
  final Color frameContrast;
  final Color frameContrastAlt;
  final Color frameContrastAlt2;
  final Color frameDefault;
  final Color frameElevated;
  final Color frameElevatedAlt;
  final Color frameSubdued;
  final Color frameTint;

  // Shape Colors - General
  final Color shapeAccent;
  final Color shapeDisabled;
  final Color shapeDisabledAlt;
  final Color shapeHighlight;
  final Color shapeLight;
  final Color shapeMask;
  final Color shapeMaskAlt;
  final Color shapeSubdued;
  final Color shapeSubduedAlt;

  // Shape Colors - Transport Modes
  final Color shapeBicycleContrast;
  final Color shapeBicycleDefault;
  final Color shapeBusContrast;
  final Color shapeBusDefault;
  final Color shapeCablewayContrast;
  final Color shapeCablewayDefault;
  final Color shapeFerryContrast;
  final Color shapeFerryDefault;
  final Color shapeFunicularContrast;
  final Color shapeFunicularDefault;
  final Color shapeHelicopterContrast;
  final Color shapeHelicopterDefault;
  final Color shapeMetroContrast;
  final Color shapeMetroDefault;
  final Color shapeMobilityContrast;
  final Color shapeMobilityDefault;
  final Color shapePlaneContrast;
  final Color shapePlaneDefault;
  final Color shapeTaxiContrast;
  final Color shapeTaxiDefault;
  final Color shapeTrainContrast;
  final Color shapeTrainDefault;
  final Color shapeTramContrast;
  final Color shapeTramDefault;
  final Color shapeWalkContrast;
  final Color shapeWalkDefault;
  final Color shapeAirportLinkBusContrast;
  final Color shapeAirportLinkBusDefault;
  final Color shapeAirportLinkRailContrast;
  final Color shapeAirportLinkRailDefault;

  // Stroke (Border) Colors
  final Color strokeContrast;
  final Color strokeDefault;
  final Color strokeDisabled;
  final Color strokeFocusContrast;
  final Color strokeFocusStandard;
  final Color strokeHighlight;
  final Color strokeLight;
  final Color strokeSubdued;
  final Color strokeSubduedAlt;

  // Text Colors
  final Color textAccent;
  final Color textDisabled;
  final Color textDisabledAlt;
  final Color textHighlight;
  final Color textLight;
  final Color textSubdued;
  final Color textSubduedAlt;

  /// Light mode semantic colors
  static const AppSemanticColors light = AppSemanticColors(
    // Frame Colors
    frameContrast: Color(0xFF181C56),
    frameContrastAlt: Color(0xFF393D79),
    frameContrastAlt2: Color(0xFF292B6A),
    frameDefault: Color(0xFFFFFFFF),
    frameElevated: Color(0xFFFFFFFF),
    frameElevatedAlt: Color(0xFFF6F6F9),
    frameSubdued: Color(0xFFD9DAE8),
    frameTint: Color(0xFFF6F6F9),
    // Shape Colors - General
    shapeAccent: Color(0xFF181C56),
    shapeDisabled: Color(0xFF6E6F73),
    shapeDisabledAlt: Color(0xFFB6B8BA),
    shapeHighlight: Color(0xFFFF5959),
    shapeLight: Color(0xFFFFFFFF),
    shapeMask: Color(0xFFFFFFFF),
    shapeMaskAlt: Color(0xFFFFFFFF),
    shapeSubdued: Color(0xFF626493),
    shapeSubduedAlt: Color(0xFFD9DAE8),
    // Transport Mode Colors
    shapeBicycleContrast: Color(0xFF00DB9B),
    shapeBicycleDefault: Color(0xFF388F76),
    shapeBusContrast: Color(0xFFFF6392),
    shapeBusDefault: Color(0xFFC5044E),
    shapeCablewayContrast: Color(0xFFB482FB),
    shapeCablewayDefault: Color(0xFF78469A),
    shapeFerryContrast: Color(0xFF6FDFFF),
    shapeFerryDefault: Color(0xFF0C6693),
    shapeFunicularContrast: Color(0xFFB482FB),
    shapeFunicularDefault: Color(0xFF78469A),
    shapeHelicopterContrast: Color(0xFFFBAFEA),
    shapeHelicopterDefault: Color(0xFF800664),
    shapeMetroContrast: Color(0xFFF08901),
    shapeMetroDefault: Color(0xFFBF5826),
    shapeMobilityContrast: Color(0xFF00DB9B),
    shapeMobilityDefault: Color(0xFF388F76),
    shapePlaneContrast: Color(0xFFFBAFEA),
    shapePlaneDefault: Color(0xFF800664),
    shapeTaxiContrast: Color(0xFFFFE082),
    shapeTaxiDefault: Color(0xFF3D3E40),
    shapeTrainContrast: Color(0xFF42A5F5),
    shapeTrainDefault: Color(0xFF00367F),
    shapeTramContrast: Color(0xFFB482FB),
    shapeTramDefault: Color(0xFF78469A),
    shapeWalkContrast: Color(0xFF8284AB),
    shapeWalkDefault: Color(0xFF8D8E9C),
    shapeAirportLinkBusContrast: Color(0xFFFBAFEA),
    shapeAirportLinkBusDefault: Color(0xFF800664),
    shapeAirportLinkRailContrast: Color(0xFFFBAFEA),
    shapeAirportLinkRailDefault: Color(0xFF800664),
    // Stroke Colors
    strokeContrast: Color(0xFFAEB7E2),
    strokeDefault: Color(0xFF181C56),
    strokeDisabled: Color(0xFF949699),
    strokeFocusContrast: Color(0xFFAEB7E2),
    strokeFocusStandard: Color(0xFF181C56),
    strokeHighlight: Color(0xFFFF5959),
    strokeLight: Color(0xFFFFFFFF),
    strokeSubdued: Color(0xFF8284AB),
    strokeSubduedAlt: Color(0xFFE3E6E8),
    // Text Colors
    textAccent: Color(0xFF181C56),
    textDisabled: Color(0xFF6E6F73),
    textDisabledAlt: Color(0xFFB6B8BA),
    textHighlight: Color(0xFFFF5959),
    textLight: Color(0xFFFFFFFF),
    textSubdued: Color(0xFF626493),
    textSubduedAlt: Color(0xFFD9DAE8),
  );

  /// Dark mode semantic colors
  static const AppSemanticColors dark = AppSemanticColors(
    // Frame Colors
    frameContrast: Color(0xFF212233),
    frameContrastAlt: Color(0xFF141527),
    frameContrastAlt2: Color(0xFF08091C),
    frameDefault: Color(0xFF08091C),
    frameElevated: Color(0x26E5E5E9), // Transparent with alpha
    frameElevatedAlt: Color(0xFF464755),
    frameSubdued: Color(0xFF2D2E3E),
    frameTint: Color(0xFF141527),
    // Shape Colors - General
    shapeAccent: Color(0xFFE5E5E9),
    shapeDisabled: Color(0xFFB6B8BA),
    shapeDisabledAlt: Color(0xFFB3B4BD),
    shapeHighlight: Color(0xFFFF9494),
    shapeLight: Color(0xFFE5E5E9),
    shapeMask: Color(0xFF2D2E3E),
    shapeMaskAlt: Color(0xFF393A49),
    shapeSubdued: Color(0xFFB3B4BD),
    shapeSubduedAlt: Color(0xFFB3B4BD),
    // Transport Mode Colors
    shapeBicycleContrast: Color(0xFF4DB295),
    shapeBicycleDefault: Color(0xFF4DB295),
    shapeBusContrast: Color(0xFFEF7398),
    shapeBusDefault: Color(0xFFEF7398),
    shapeCablewayContrast: Color(0xFFB898E5),
    shapeCablewayDefault: Color(0xFFB898E5),
    shapeFerryContrast: Color(0xFF8CCFE2),
    shapeFerryDefault: Color(0xFF8CCFE2),
    shapeFunicularContrast: Color(0xFFB898E5),
    shapeFunicularDefault: Color(0xFFB898E5),
    shapeHelicopterContrast: Color(0xFFF2B8E5),
    shapeHelicopterDefault: Color(0xFFF2B8E5),
    shapeMetroContrast: Color(0xFFDD973C),
    shapeMetroDefault: Color(0xFFDD973C),
    shapeMobilityContrast: Color(0xFF4DB295),
    shapeMobilityDefault: Color(0xFF4DB295),
    shapePlaneContrast: Color(0xFFF2B8E5),
    shapePlaneDefault: Color(0xFFF2B8E5),
    shapeTaxiContrast: Color(0xFFFFE082),
    shapeTaxiDefault: Color(0xFFFFE082),
    shapeTrainContrast: Color(0xFF60A2D7),
    shapeTrainDefault: Color(0xFF60A2D7),
    shapeTramContrast: Color(0xFFB898E5),
    shapeTramDefault: Color(0xFFB898E5),
    shapeWalkContrast: Color(0xFF8D8E9C),
    shapeWalkDefault: Color(0xFF8D8E9C),
    shapeAirportLinkBusContrast: Color(0xFFF2B8E5),
    shapeAirportLinkBusDefault: Color(0xFFF2B8E5),
    shapeAirportLinkRailContrast: Color(0xFFF2B8E5),
    shapeAirportLinkRailDefault: Color(0xFFF2B8E5),
    // Stroke Colors
    strokeContrast: Color(0xFFAEB7E2),
    strokeDefault: Color(0xFFB3B4BD),
    strokeDisabled: Color(0xFFE3E6E8),
    strokeFocusContrast: Color(0xFFAEB7E2),
    strokeFocusStandard: Color(0xFFAEB7E2),
    strokeHighlight: Color(0xFFFF9494),
    strokeLight: Color(0xFFB3B4BD),
    strokeSubdued: Color(0xFF81828F),
    strokeSubduedAlt: Color(0xFF949699),
    // Text Colors
    textAccent: Color(0xFFE5E5E9),
    textDisabled: Color(0xFFB6B8BA),
    textDisabledAlt: Color(0xFFB6B8BA),
    textHighlight: Color(0xFFFF9494),
    textLight: Color(0xFFE5E5E9),
    textSubdued: Color(0xFFB3B4BD),
    textSubduedAlt: Color(0xFFB3B4BD),
  );

  @override
  ThemeExtension<AppSemanticColors> copyWith({
    Color? frameContrast,
    Color? frameContrastAlt,
    Color? frameContrastAlt2,
    Color? frameDefault,
    Color? frameElevated,
    Color? frameElevatedAlt,
    Color? frameSubdued,
    Color? frameTint,
    Color? shapeAccent,
    Color? shapeDisabled,
    Color? shapeDisabledAlt,
    Color? shapeHighlight,
    Color? shapeLight,
    Color? shapeMask,
    Color? shapeMaskAlt,
    Color? shapeSubdued,
    Color? shapeSubduedAlt,
    Color? shapeBicycleContrast,
    Color? shapeBicycleDefault,
    Color? shapeBusContrast,
    Color? shapeBusDefault,
    Color? shapeCablewayContrast,
    Color? shapeCablewayDefault,
    Color? shapeFerryContrast,
    Color? shapeFerryDefault,
    Color? shapeFunicularContrast,
    Color? shapeFunicularDefault,
    Color? shapeHelicopterContrast,
    Color? shapeHelicopterDefault,
    Color? shapeMetroContrast,
    Color? shapeMetroDefault,
    Color? shapeMobilityContrast,
    Color? shapeMobilityDefault,
    Color? shapePlaneContrast,
    Color? shapePlaneDefault,
    Color? shapeTaxiContrast,
    Color? shapeTaxiDefault,
    Color? shapeTrainContrast,
    Color? shapeTrainDefault,
    Color? shapeTramContrast,
    Color? shapeTramDefault,
    Color? shapeWalkContrast,
    Color? shapeWalkDefault,
    Color? shapeAirportLinkBusContrast,
    Color? shapeAirportLinkBusDefault,
    Color? shapeAirportLinkRailContrast,
    Color? shapeAirportLinkRailDefault,
    Color? strokeContrast,
    Color? strokeDefault,
    Color? strokeDisabled,
    Color? strokeFocusContrast,
    Color? strokeFocusStandard,
    Color? strokeHighlight,
    Color? strokeLight,
    Color? strokeSubdued,
    Color? strokeSubduedAlt,
    Color? textAccent,
    Color? textDisabled,
    Color? textDisabledAlt,
    Color? textHighlight,
    Color? textLight,
    Color? textSubdued,
    Color? textSubduedAlt,
  }) {
    return AppSemanticColors(
      frameContrast: frameContrast ?? this.frameContrast,
      frameContrastAlt: frameContrastAlt ?? this.frameContrastAlt,
      frameContrastAlt2: frameContrastAlt2 ?? this.frameContrastAlt2,
      frameDefault: frameDefault ?? this.frameDefault,
      frameElevated: frameElevated ?? this.frameElevated,
      frameElevatedAlt: frameElevatedAlt ?? this.frameElevatedAlt,
      frameSubdued: frameSubdued ?? this.frameSubdued,
      frameTint: frameTint ?? this.frameTint,
      shapeAccent: shapeAccent ?? this.shapeAccent,
      shapeDisabled: shapeDisabled ?? this.shapeDisabled,
      shapeDisabledAlt: shapeDisabledAlt ?? this.shapeDisabledAlt,
      shapeHighlight: shapeHighlight ?? this.shapeHighlight,
      shapeLight: shapeLight ?? this.shapeLight,
      shapeMask: shapeMask ?? this.shapeMask,
      shapeMaskAlt: shapeMaskAlt ?? this.shapeMaskAlt,
      shapeSubdued: shapeSubdued ?? this.shapeSubdued,
      shapeSubduedAlt: shapeSubduedAlt ?? this.shapeSubduedAlt,
      shapeBicycleContrast: shapeBicycleContrast ?? this.shapeBicycleContrast,
      shapeBicycleDefault: shapeBicycleDefault ?? this.shapeBicycleDefault,
      shapeBusContrast: shapeBusContrast ?? this.shapeBusContrast,
      shapeBusDefault: shapeBusDefault ?? this.shapeBusDefault,
      shapeCablewayContrast:
          shapeCablewayContrast ?? this.shapeCablewayContrast,
      shapeCablewayDefault: shapeCablewayDefault ?? this.shapeCablewayDefault,
      shapeFerryContrast: shapeFerryContrast ?? this.shapeFerryContrast,
      shapeFerryDefault: shapeFerryDefault ?? this.shapeFerryDefault,
      shapeFunicularContrast:
          shapeFunicularContrast ?? this.shapeFunicularContrast,
      shapeFunicularDefault:
          shapeFunicularDefault ?? this.shapeFunicularDefault,
      shapeHelicopterContrast:
          shapeHelicopterContrast ?? this.shapeHelicopterContrast,
      shapeHelicopterDefault:
          shapeHelicopterDefault ?? this.shapeHelicopterDefault,
      shapeMetroContrast: shapeMetroContrast ?? this.shapeMetroContrast,
      shapeMetroDefault: shapeMetroDefault ?? this.shapeMetroDefault,
      shapeMobilityContrast:
          shapeMobilityContrast ?? this.shapeMobilityContrast,
      shapeMobilityDefault: shapeMobilityDefault ?? this.shapeMobilityDefault,
      shapePlaneContrast: shapePlaneContrast ?? this.shapePlaneContrast,
      shapePlaneDefault: shapePlaneDefault ?? this.shapePlaneDefault,
      shapeTaxiContrast: shapeTaxiContrast ?? this.shapeTaxiContrast,
      shapeTaxiDefault: shapeTaxiDefault ?? this.shapeTaxiDefault,
      shapeTrainContrast: shapeTrainContrast ?? this.shapeTrainContrast,
      shapeTrainDefault: shapeTrainDefault ?? this.shapeTrainDefault,
      shapeTramContrast: shapeTramContrast ?? this.shapeTramContrast,
      shapeTramDefault: shapeTramDefault ?? this.shapeTramDefault,
      shapeWalkContrast: shapeWalkContrast ?? this.shapeWalkContrast,
      shapeWalkDefault: shapeWalkDefault ?? this.shapeWalkDefault,
      shapeAirportLinkBusContrast:
          shapeAirportLinkBusContrast ?? this.shapeAirportLinkBusContrast,
      shapeAirportLinkBusDefault:
          shapeAirportLinkBusDefault ?? this.shapeAirportLinkBusDefault,
      shapeAirportLinkRailContrast:
          shapeAirportLinkRailContrast ?? this.shapeAirportLinkRailContrast,
      shapeAirportLinkRailDefault:
          shapeAirportLinkRailDefault ?? this.shapeAirportLinkRailDefault,
      strokeContrast: strokeContrast ?? this.strokeContrast,
      strokeDefault: strokeDefault ?? this.strokeDefault,
      strokeDisabled: strokeDisabled ?? this.strokeDisabled,
      strokeFocusContrast: strokeFocusContrast ?? this.strokeFocusContrast,
      strokeFocusStandard: strokeFocusStandard ?? this.strokeFocusStandard,
      strokeHighlight: strokeHighlight ?? this.strokeHighlight,
      strokeLight: strokeLight ?? this.strokeLight,
      strokeSubdued: strokeSubdued ?? this.strokeSubdued,
      strokeSubduedAlt: strokeSubduedAlt ?? this.strokeSubduedAlt,
      textAccent: textAccent ?? this.textAccent,
      textDisabled: textDisabled ?? this.textDisabled,
      textDisabledAlt: textDisabledAlt ?? this.textDisabledAlt,
      textHighlight: textHighlight ?? this.textHighlight,
      textLight: textLight ?? this.textLight,
      textSubdued: textSubdued ?? this.textSubdued,
      textSubduedAlt: textSubduedAlt ?? this.textSubduedAlt,
    );
  }

  @override
  ThemeExtension<AppSemanticColors> lerp(
    ThemeExtension<AppSemanticColors>? other,
    double t,
  ) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      frameContrast: Color.lerp(frameContrast, other.frameContrast, t)!,
      frameContrastAlt:
          Color.lerp(frameContrastAlt, other.frameContrastAlt, t)!,
      frameContrastAlt2:
          Color.lerp(frameContrastAlt2, other.frameContrastAlt2, t)!,
      frameDefault: Color.lerp(frameDefault, other.frameDefault, t)!,
      frameElevated: Color.lerp(frameElevated, other.frameElevated, t)!,
      frameElevatedAlt:
          Color.lerp(frameElevatedAlt, other.frameElevatedAlt, t)!,
      frameSubdued: Color.lerp(frameSubdued, other.frameSubdued, t)!,
      frameTint: Color.lerp(frameTint, other.frameTint, t)!,
      shapeAccent: Color.lerp(shapeAccent, other.shapeAccent, t)!,
      shapeDisabled: Color.lerp(shapeDisabled, other.shapeDisabled, t)!,
      shapeDisabledAlt:
          Color.lerp(shapeDisabledAlt, other.shapeDisabledAlt, t)!,
      shapeHighlight: Color.lerp(shapeHighlight, other.shapeHighlight, t)!,
      shapeLight: Color.lerp(shapeLight, other.shapeLight, t)!,
      shapeMask: Color.lerp(shapeMask, other.shapeMask, t)!,
      shapeMaskAlt: Color.lerp(shapeMaskAlt, other.shapeMaskAlt, t)!,
      shapeSubdued: Color.lerp(shapeSubdued, other.shapeSubdued, t)!,
      shapeSubduedAlt: Color.lerp(shapeSubduedAlt, other.shapeSubduedAlt, t)!,
      shapeBicycleContrast:
          Color.lerp(shapeBicycleContrast, other.shapeBicycleContrast, t)!,
      shapeBicycleDefault:
          Color.lerp(shapeBicycleDefault, other.shapeBicycleDefault, t)!,
      shapeBusContrast:
          Color.lerp(shapeBusContrast, other.shapeBusContrast, t)!,
      shapeBusDefault: Color.lerp(shapeBusDefault, other.shapeBusDefault, t)!,
      shapeCablewayContrast:
          Color.lerp(shapeCablewayContrast, other.shapeCablewayContrast, t)!,
      shapeCablewayDefault:
          Color.lerp(shapeCablewayDefault, other.shapeCablewayDefault, t)!,
      shapeFerryContrast:
          Color.lerp(shapeFerryContrast, other.shapeFerryContrast, t)!,
      shapeFerryDefault:
          Color.lerp(shapeFerryDefault, other.shapeFerryDefault, t)!,
      shapeFunicularContrast:
          Color.lerp(shapeFunicularContrast, other.shapeFunicularContrast, t)!,
      shapeFunicularDefault:
          Color.lerp(shapeFunicularDefault, other.shapeFunicularDefault, t)!,
      shapeHelicopterContrast: Color.lerp(
        shapeHelicopterContrast,
        other.shapeHelicopterContrast,
        t,
      )!,
      shapeHelicopterDefault:
          Color.lerp(shapeHelicopterDefault, other.shapeHelicopterDefault, t)!,
      shapeMetroContrast:
          Color.lerp(shapeMetroContrast, other.shapeMetroContrast, t)!,
      shapeMetroDefault:
          Color.lerp(shapeMetroDefault, other.shapeMetroDefault, t)!,
      shapeMobilityContrast:
          Color.lerp(shapeMobilityContrast, other.shapeMobilityContrast, t)!,
      shapeMobilityDefault:
          Color.lerp(shapeMobilityDefault, other.shapeMobilityDefault, t)!,
      shapePlaneContrast:
          Color.lerp(shapePlaneContrast, other.shapePlaneContrast, t)!,
      shapePlaneDefault:
          Color.lerp(shapePlaneDefault, other.shapePlaneDefault, t)!,
      shapeTaxiContrast:
          Color.lerp(shapeTaxiContrast, other.shapeTaxiContrast, t)!,
      shapeTaxiDefault:
          Color.lerp(shapeTaxiDefault, other.shapeTaxiDefault, t)!,
      shapeTrainContrast:
          Color.lerp(shapeTrainContrast, other.shapeTrainContrast, t)!,
      shapeTrainDefault:
          Color.lerp(shapeTrainDefault, other.shapeTrainDefault, t)!,
      shapeTramContrast:
          Color.lerp(shapeTramContrast, other.shapeTramContrast, t)!,
      shapeTramDefault:
          Color.lerp(shapeTramDefault, other.shapeTramDefault, t)!,
      shapeWalkContrast:
          Color.lerp(shapeWalkContrast, other.shapeWalkContrast, t)!,
      shapeWalkDefault:
          Color.lerp(shapeWalkDefault, other.shapeWalkDefault, t)!,
      shapeAirportLinkBusContrast: Color.lerp(
        shapeAirportLinkBusContrast,
        other.shapeAirportLinkBusContrast,
        t,
      )!,
      shapeAirportLinkBusDefault: Color.lerp(
        shapeAirportLinkBusDefault,
        other.shapeAirportLinkBusDefault,
        t,
      )!,
      shapeAirportLinkRailContrast: Color.lerp(
        shapeAirportLinkRailContrast,
        other.shapeAirportLinkRailContrast,
        t,
      )!,
      shapeAirportLinkRailDefault: Color.lerp(
        shapeAirportLinkRailDefault,
        other.shapeAirportLinkRailDefault,
        t,
      )!,
      strokeContrast: Color.lerp(strokeContrast, other.strokeContrast, t)!,
      strokeDefault: Color.lerp(strokeDefault, other.strokeDefault, t)!,
      strokeDisabled: Color.lerp(strokeDisabled, other.strokeDisabled, t)!,
      strokeFocusContrast:
          Color.lerp(strokeFocusContrast, other.strokeFocusContrast, t)!,
      strokeFocusStandard:
          Color.lerp(strokeFocusStandard, other.strokeFocusStandard, t)!,
      strokeHighlight: Color.lerp(strokeHighlight, other.strokeHighlight, t)!,
      strokeLight: Color.lerp(strokeLight, other.strokeLight, t)!,
      strokeSubdued: Color.lerp(strokeSubdued, other.strokeSubdued, t)!,
      strokeSubduedAlt:
          Color.lerp(strokeSubduedAlt, other.strokeSubduedAlt, t)!,
      textAccent: Color.lerp(textAccent, other.textAccent, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      textDisabledAlt: Color.lerp(textDisabledAlt, other.textDisabledAlt, t)!,
      textHighlight: Color.lerp(textHighlight, other.textHighlight, t)!,
      textLight: Color.lerp(textLight, other.textLight, t)!,
      textSubdued: Color.lerp(textSubdued, other.textSubdued, t)!,
      textSubduedAlt: Color.lerp(textSubduedAlt, other.textSubduedAlt, t)!,
    );
  }
}
