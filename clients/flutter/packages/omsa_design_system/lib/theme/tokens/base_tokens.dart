import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/tokens/base_color_tokens.dart';

/// Utility class for accessing theme-aware base color tokens.
/// Automatically selects between BaseLightTokens and BaseDarkTokens
/// based on the current brightness.
class BaseTokens {
  final bool _isLight;

  const BaseTokens._(this._isLight);

  /// Get BaseTokens instance from BuildContext
  factory BaseTokens.of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BaseTokens._(brightness == Brightness.light);
  }

  /// Get BaseTokens instance from explicit Brightness
  factory BaseTokens.from(Brightness brightness) {
    return BaseTokens._(brightness == Brightness.light);
  }

  // Frame tokens
  Color get frameContrast =>
      _isLight ? BaseLightTokens.frameContrast : BaseDarkTokens.frameContrast;
  Color get frameContrastAlt => _isLight
      ? BaseLightTokens.frameContrastAlt
      : BaseDarkTokens.frameContrastAlt;
  Color get frameContrastAlt2 => _isLight
      ? BaseLightTokens.frameContrastAlt2
      : BaseDarkTokens.frameContrastAlt2;
  Color get frameDefault =>
      _isLight ? BaseLightTokens.frameDefault : BaseDarkTokens.frameDefault;
  Color get frameElevated =>
      _isLight ? BaseLightTokens.frameElevated : BaseDarkTokens.frameElevated;
  Color get frameElevatedAlt => _isLight
      ? BaseLightTokens.frameElevatedAlt
      : BaseDarkTokens.frameElevatedAlt;
  Color get frameSubdued =>
      _isLight ? BaseLightTokens.frameSubdued : BaseDarkTokens.frameSubdued;
  Color get frameTint =>
      _isLight ? BaseLightTokens.frameTint : BaseDarkTokens.frameTint;

  // Shape tokens
  Color get shapeAccent =>
      _isLight ? BaseLightTokens.shapeAccent : BaseDarkTokens.shapeAccent;
  Color get shapeBicycleContrast => _isLight
      ? BaseLightTokens.shapeBicycleContrast
      : BaseDarkTokens.shapeBicycleContrast;
  Color get shapeBicycleDefault => _isLight
      ? BaseLightTokens.shapeBicycleDefault
      : BaseDarkTokens.shapeBicycleDefault;
  Color get shapeBusContrast => _isLight
      ? BaseLightTokens.shapeBusContrast
      : BaseDarkTokens.shapeBusContrast;
  Color get shapeBusDefault => _isLight
      ? BaseLightTokens.shapeBusDefault
      : BaseDarkTokens.shapeBusDefault;
  Color get shapeCablewayContrast => _isLight
      ? BaseLightTokens.shapeCablewayContrast
      : BaseDarkTokens.shapeCablewayContrast;
  Color get shapeCablewayDefault => _isLight
      ? BaseLightTokens.shapeCablewayDefault
      : BaseDarkTokens.shapeCablewayDefault;
  Color get shapeDisabled =>
      _isLight ? BaseLightTokens.shapeDisabled : BaseDarkTokens.shapeDisabled;
  Color get shapeDisabledAlt => _isLight
      ? BaseLightTokens.shapeDisabledAlt
      : BaseDarkTokens.shapeDisabledAlt;
  Color get shapeFerryContrast => _isLight
      ? BaseLightTokens.shapeFerryContrast
      : BaseDarkTokens.shapeFerryContrast;
  Color get shapeFerryDefault => _isLight
      ? BaseLightTokens.shapeFerryDefault
      : BaseDarkTokens.shapeFerryDefault;
  Color get shapeFunicularContrast => _isLight
      ? BaseLightTokens.shapeFunicularContrast
      : BaseDarkTokens.shapeFunicularContrast;
  Color get shapeFunicularDefault => _isLight
      ? BaseLightTokens.shapeFunicularDefault
      : BaseDarkTokens.shapeFunicularDefault;
  Color get shapeHelicopterContrast => _isLight
      ? BaseLightTokens.shapeHelicopterContrast
      : BaseDarkTokens.shapeHelicopterContrast;
  Color get shapeHelicopterDefault => _isLight
      ? BaseLightTokens.shapeHelicopterDefault
      : BaseDarkTokens.shapeHelicopterDefault;
  Color get shapeHighlight => _isLight
      ? BaseLightTokens.shapeHighlight
      : BaseDarkTokens.shapeHighlight;
  Color get shapeLight =>
      _isLight ? BaseLightTokens.shapeLight : BaseDarkTokens.shapeLight;
  Color get shapeMask =>
      _isLight ? BaseLightTokens.shapeMask : BaseDarkTokens.shapeMask;
  Color get shapeMaskAlt =>
      _isLight ? BaseLightTokens.shapeMaskAlt : BaseDarkTokens.shapeMaskAlt;
  Color get shapeMetroContrast => _isLight
      ? BaseLightTokens.shapeMetroContrast
      : BaseDarkTokens.shapeMetroContrast;
  Color get shapeMetroDefault => _isLight
      ? BaseLightTokens.shapeMetroDefault
      : BaseDarkTokens.shapeMetroDefault;
  Color get shapeMobilityContrast => _isLight
      ? BaseLightTokens.shapeMobilityContrast
      : BaseDarkTokens.shapeMobilityContrast;
  Color get shapeMobilityDefault => _isLight
      ? BaseLightTokens.shapeMobilityDefault
      : BaseDarkTokens.shapeMobilityDefault;
  Color get shapePlaneContrast => _isLight
      ? BaseLightTokens.shapePlaneContrast
      : BaseDarkTokens.shapePlaneContrast;
  Color get shapePlaneDefault => _isLight
      ? BaseLightTokens.shapePlaneDefault
      : BaseDarkTokens.shapePlaneDefault;
  Color get shapeSubdued =>
      _isLight ? BaseLightTokens.shapeSubdued : BaseDarkTokens.shapeSubdued;
  Color get shapeSubduedAlt => _isLight
      ? BaseLightTokens.shapeSubduedAlt
      : BaseDarkTokens.shapeSubduedAlt;
  Color get shapeTaxiContrast => _isLight
      ? BaseLightTokens.shapeTaxiContrast
      : BaseDarkTokens.shapeTaxiContrast;
  Color get shapeTaxiDefault => _isLight
      ? BaseLightTokens.shapeTaxiDefault
      : BaseDarkTokens.shapeTaxiDefault;
  Color get shapeTrainContrast => _isLight
      ? BaseLightTokens.shapeTrainContrast
      : BaseDarkTokens.shapeTrainContrast;
  Color get shapeTrainDefault => _isLight
      ? BaseLightTokens.shapeTrainDefault
      : BaseDarkTokens.shapeTrainDefault;
  Color get shapeTramContrast => _isLight
      ? BaseLightTokens.shapeTramContrast
      : BaseDarkTokens.shapeTramContrast;
  Color get shapeTramDefault => _isLight
      ? BaseLightTokens.shapeTramDefault
      : BaseDarkTokens.shapeTramDefault;
  Color get shapeWalkContrast => _isLight
      ? BaseLightTokens.shapeWalkContrast
      : BaseDarkTokens.shapeWalkContrast;
  Color get shapeWalkDefault => _isLight
      ? BaseLightTokens.shapeWalkDefault
      : BaseDarkTokens.shapeWalkDefault;
  Color get shapeAirportLinkBusContrast => _isLight
      ? BaseLightTokens.shapeAirportLinkBusContrast
      : BaseDarkTokens.shapeAirportLinkBusContrast;
  Color get shapeAirportLinkBusDefault => _isLight
      ? BaseLightTokens.shapeAirportLinkBusDefault
      : BaseDarkTokens.shapeAirportLinkBusDefault;
  Color get shapeAirportLinkRailContrast => _isLight
      ? BaseLightTokens.shapeAirportLinkRailContrast
      : BaseDarkTokens.shapeAirportLinkRailContrast;
  Color get shapeAirportLinkRailDefault => _isLight
      ? BaseLightTokens.shapeAirportLinkRailDefault
      : BaseDarkTokens.shapeAirportLinkRailDefault;

  // Stroke tokens
  Color get strokeContrast =>
      _isLight ? BaseLightTokens.strokeContrast : BaseDarkTokens.strokeContrast;
  Color get strokeDefault =>
      _isLight ? BaseLightTokens.strokeDefault : BaseDarkTokens.strokeDefault;
  Color get strokeDisabled =>
      _isLight ? BaseLightTokens.strokeDisabled : BaseDarkTokens.strokeDisabled;
  Color get strokeFocusContrast => _isLight
      ? BaseLightTokens.strokeFocusContrast
      : BaseDarkTokens.strokeFocusContrast;
  Color get strokeFocusStandard => _isLight
      ? BaseLightTokens.strokeFocusStandard
      : BaseDarkTokens.strokeFocusStandard;
  Color get strokeHighlight => _isLight
      ? BaseLightTokens.strokeHighlight
      : BaseDarkTokens.strokeHighlight;
  Color get strokeLight =>
      _isLight ? BaseLightTokens.strokeLight : BaseDarkTokens.strokeLight;
  Color get strokeSubdued =>
      _isLight ? BaseLightTokens.strokeSubdued : BaseDarkTokens.strokeSubdued;
  Color get strokeSubduedAlt => _isLight
      ? BaseLightTokens.strokeSubduedAlt
      : BaseDarkTokens.strokeSubduedAlt;

  // Text tokens
  Color get textAccent =>
      _isLight ? BaseLightTokens.textAccent : BaseDarkTokens.textAccent;
  Color get textDisabled =>
      _isLight ? BaseLightTokens.textDisabled : BaseDarkTokens.textDisabled;
  Color get textDisabledAlt => _isLight
      ? BaseLightTokens.textDisabledAlt
      : BaseDarkTokens.textDisabledAlt;
  Color get textHighlight =>
      _isLight ? BaseLightTokens.textHighlight : BaseDarkTokens.textHighlight;
  Color get textLight =>
      _isLight ? BaseLightTokens.textLight : BaseDarkTokens.textLight;
  Color get textSubdued =>
      _isLight ? BaseLightTokens.textSubdued : BaseDarkTokens.textSubdued;
  Color get textSubduedAlt => _isLight
      ? BaseLightTokens.textSubduedAlt
      : BaseDarkTokens.textSubduedAlt;
}

/// Extension on BuildContext for convenient access to theme-aware base tokens
extension BuildContextBaseTokens on BuildContext {
  /// Access base color tokens that automatically adapt to light/dark theme
  BaseTokens get tokens => BaseTokens.of(this);
}
