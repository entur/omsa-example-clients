import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/tokens/component_color_tokens.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/travel/transport_utils.dart';

class TravelSwitchColors {
  final Color trackColorTrue;
  final Color trackColorFalse;
  final Color thumbColor;
  final Color iconColor;
  final Color textColor;

  const TravelSwitchColors({
    required this.trackColorTrue,
    required this.trackColorFalse,
    required this.thumbColor,
    required this.iconColor,
    required this.textColor,
  });

  factory TravelSwitchColors.fromTransport(
    BuildContext context,
    Transport transport,
    OmsaComponentMode mode,
  ) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;
    final suffix = transportToColorTokenSuffix(transport);
    final capitalizedSuffix =
        suffix[0].toUpperCase() + suffix.substring(1).toLowerCase();

    if (mode == OmsaComponentMode.contrast) {
      if (isLight) {
        return TravelSwitchColors(
          trackColorTrue: _getContrastBackgroundTrueColor(
            capitalizedSuffix,
            true,
          ),
          trackColorFalse:
              ComponentLightTokens.travelTravelSwitchContrastBackgroundFalse,
          thumbColor:
              ComponentLightTokens.travelTravelSwitchContrastSwitchFillTrue,
          iconColor: _getContrastIconTrueColor(capitalizedSuffix, true),
          textColor: ComponentLightTokens.travelTravelSwitchContrastText,
        );
      } else {
        return TravelSwitchColors(
          trackColorTrue: _getContrastBackgroundTrueColor(
            capitalizedSuffix,
            false,
          ),
          trackColorFalse:
              ComponentDarkTokens.travelTravelSwitchContrastBackgroundFalse,
          thumbColor:
              ComponentDarkTokens.travelTravelSwitchContrastSwitchFillTrue,
          iconColor: _getContrastIconTrueColor(capitalizedSuffix, false),
          textColor: ComponentDarkTokens.travelTravelSwitchContrastText,
        );
      }
    }

    if (isLight) {
      return TravelSwitchColors(
        trackColorTrue: _getStandardBackgroundTrueColor(
          capitalizedSuffix,
          true,
        ),
        trackColorFalse:
            ComponentLightTokens.travelTravelSwitchStandardBackgroundFalse,
        thumbColor:
            ComponentLightTokens.travelTravelSwitchStandardSwitchFillTrue,
        iconColor: _getStandardIconTrueColor(capitalizedSuffix, true),
        textColor: ComponentLightTokens.travelTravelSwitchStandardText,
      );
    } else {
      return TravelSwitchColors(
        trackColorTrue: _getStandardBackgroundTrueColor(
          capitalizedSuffix,
          false,
        ),
        trackColorFalse:
            ComponentDarkTokens.travelTravelSwitchStandardBackgroundFalse,
        thumbColor:
            ComponentDarkTokens.travelTravelSwitchStandardSwitchFillTrue,
        iconColor: _getStandardIconTrueColor(capitalizedSuffix, false),
        textColor: ComponentDarkTokens.travelTravelSwitchStandardText,
      );
    }
  }

  static Color _getStandardBackgroundTrueColor(String transport, bool isLight) {
    switch (transport) {
      case 'Air':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardBackgroundTrueAir
            : ComponentDarkTokens.travelTravelSwitchStandardBackgroundTrueAir;
      case 'Bicycle':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchStandardBackgroundTrueBicycle
            : ComponentDarkTokens
                  .travelTravelSwitchStandardBackgroundTrueBicycle;
      case 'Bus':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardBackgroundTrueBus
            : ComponentDarkTokens.travelTravelSwitchStandardBackgroundTrueBus;
      case 'Cableway':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchStandardBackgroundTrueCableway
            : ComponentDarkTokens
                  .travelTravelSwitchStandardBackgroundTrueCableway;
      case 'Carferry':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchStandardBackgroundTrueCarferry
            : ComponentDarkTokens
                  .travelTravelSwitchStandardBackgroundTrueCarferry;
      case 'Citybike':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchStandardBackgroundTrueCitybike
            : ComponentDarkTokens
                  .travelTravelSwitchStandardBackgroundTrueCitybike;
      case 'Ferry':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardBackgroundTrueFerry
            : ComponentDarkTokens.travelTravelSwitchStandardBackgroundTrueFerry;
      case 'Funicular':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchStandardBackgroundTrueFunicular
            : ComponentDarkTokens
                  .travelTravelSwitchStandardBackgroundTrueFunicular;
      case 'Helicopter':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchStandardBackgroundTrueHelicopter
            : ComponentDarkTokens
                  .travelTravelSwitchStandardBackgroundTrueHelicopter;
      case 'Metro':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardBackgroundTrueMetro
            : ComponentDarkTokens.travelTravelSwitchStandardBackgroundTrueMetro;
      case 'Mobility':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchStandardBackgroundTrueMobility
            : ComponentDarkTokens
                  .travelTravelSwitchStandardBackgroundTrueMobility;
      case 'Plane':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardBackgroundTruePlane
            : ComponentDarkTokens.travelTravelSwitchStandardBackgroundTruePlane;
      case 'Rail':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardBackgroundTrueRail
            : ComponentDarkTokens.travelTravelSwitchStandardBackgroundTrueRail;
      case 'Taxi':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardBackgroundTrueTaxi
            : ComponentDarkTokens.travelTravelSwitchStandardBackgroundTrueTaxi;
      case 'Train':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardBackgroundTrueTrain
            : ComponentDarkTokens.travelTravelSwitchStandardBackgroundTrueTrain;
      case 'Tram':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardBackgroundTrueTram
            : ComponentDarkTokens.travelTravelSwitchStandardBackgroundTrueTram;
      case 'Walk':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardBackgroundTrueWalk
            : ComponentDarkTokens.travelTravelSwitchStandardBackgroundTrueWalk;
      case 'Water':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardBackgroundTrueWater
            : ComponentDarkTokens.travelTravelSwitchStandardBackgroundTrueWater;
      case 'Airportlinkbus':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchStandardBackgroundTrueairportLinkBus
            : ComponentDarkTokens
                  .travelTravelSwitchStandardBackgroundTrueairportLinkBus;
      case 'Airportlinkrail':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchStandardBackgroundTrueairportLinkRail
            : ComponentDarkTokens
                  .travelTravelSwitchStandardBackgroundTrueairportLinkRail;
      default:
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardBackgroundTrueBus
            : ComponentDarkTokens.travelTravelSwitchStandardBackgroundTrueBus;
    }
  }

  static Color _getStandardIconTrueColor(String transport, bool isLight) {
    switch (transport) {
      case 'Air':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueAir
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueAir;
      case 'Bicycle':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueBicycle
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueBicycle;
      case 'Bus':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueBus
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueBus;
      case 'Cableway':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueCableway
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueCableway;
      case 'Carferry':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueCarferry
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueCarferry;
      case 'Citybike':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueCitybike
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueCitybike;
      case 'Ferry':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueFerry
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueFerry;
      case 'Funicular':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueFunicular
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueFunicular;
      case 'Helicopter':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueHelicopter
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueHelicopter;
      case 'Metro':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueMetro
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueMetro;
      case 'Mobility':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueMobility
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueMobility;
      case 'Plane':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTruePlane
            : ComponentDarkTokens.travelTravelSwitchStandardIconTruePlane;
      case 'Taxi':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueTaxi
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueTaxi;
      case 'Train':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueTrain
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueTrain;
      case 'Rail':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueRail
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueRail;
      case 'Tram':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueTram
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueTram;
      case 'Walk':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueWalk
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueWalk;
      case 'Water':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueWater
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueWater;
      case 'Airportlinkbus':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchStandardIconTrueairportLinkBus
            : ComponentDarkTokens
                  .travelTravelSwitchStandardIconTrueairportLinkBus;
      case 'Airportlinkrail':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchStandardIconTrueairportLinkRail
            : ComponentDarkTokens
                  .travelTravelSwitchStandardIconTrueairportLinkRail;
      default:
        return isLight
            ? ComponentLightTokens.travelTravelSwitchStandardIconTrueBus
            : ComponentDarkTokens.travelTravelSwitchStandardIconTrueBus;
    }
  }

  static Color _getContrastBackgroundTrueColor(String transport, bool isLight) {
    switch (transport) {
      case 'Air':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastBackgroundTrueAir
            : ComponentDarkTokens.travelTravelSwitchContrastBackgroundTrueAir;
      case 'Bicycle':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchContrastBackgroundTrueBicycle
            : ComponentDarkTokens
                  .travelTravelSwitchContrastBackgroundTrueBicycle;
      case 'Bus':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastBackgroundTrueBus
            : ComponentDarkTokens.travelTravelSwitchContrastBackgroundTrueBus;
      case 'Cableway':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchContrastBackgroundTrueCableway
            : ComponentDarkTokens
                  .travelTravelSwitchContrastBackgroundTrueCableway;
      case 'Carferry':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchContrastBackgroundTrueCarferry
            : ComponentDarkTokens
                  .travelTravelSwitchContrastBackgroundTrueCarferry;
      case 'Citybike':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchContrastBackgroundTrueCitybike
            : ComponentDarkTokens
                  .travelTravelSwitchContrastBackgroundTrueCitybike;
      case 'Ferry':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastBackgroundTrueFerry
            : ComponentDarkTokens.travelTravelSwitchContrastBackgroundTrueFerry;
      case 'Funicular':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchContrastBackgroundTrueFunicular
            : ComponentDarkTokens
                  .travelTravelSwitchContrastBackgroundTrueFunicular;
      case 'Helicopter':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchContrastBackgroundTrueHelicopter
            : ComponentDarkTokens
                  .travelTravelSwitchContrastBackgroundTrueHelicopter;
      case 'Metro':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastBackgroundTrueMetro
            : ComponentDarkTokens.travelTravelSwitchContrastBackgroundTrueMetro;
      case 'Mobility':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchContrastBackgroundTrueMobility
            : ComponentDarkTokens
                  .travelTravelSwitchContrastBackgroundTrueMobility;
      case 'Plane':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastBackgroundTruePlane
            : ComponentDarkTokens.travelTravelSwitchContrastBackgroundTruePlane;
      case 'Rail':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastBackgroundTrueRail
            : ComponentDarkTokens.travelTravelSwitchContrastBackgroundTrueRail;
      case 'Taxi':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastBackgroundTrueTaxi
            : ComponentDarkTokens.travelTravelSwitchContrastBackgroundTrueTaxi;
      case 'Train':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastBackgroundTrueTrain
            : ComponentDarkTokens.travelTravelSwitchContrastBackgroundTrueTrain;
      case 'Tram':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastBackgroundTrueTram
            : ComponentDarkTokens.travelTravelSwitchContrastBackgroundTrueTram;
      case 'Walk':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastBackgroundTrueWalk
            : ComponentDarkTokens.travelTravelSwitchContrastBackgroundTrueWalk;
      case 'Water':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastBackgroundTrueWater
            : ComponentDarkTokens.travelTravelSwitchContrastBackgroundTrueWater;
      case 'Airportlinkbus':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchContrastBackgroundTrueairportLinkBus
            : ComponentDarkTokens
                  .travelTravelSwitchContrastBackgroundTrueairportLinkBus;
      case 'Airportlinkrail':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchContrastBackgroundTrueairportLinkRail
            : ComponentDarkTokens
                  .travelTravelSwitchContrastBackgroundTrueairportLinkRail;
      default:
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastBackgroundTrueBus
            : ComponentDarkTokens.travelTravelSwitchContrastBackgroundTrueBus;
    }
  }

  static Color _getContrastIconTrueColor(String transport, bool isLight) {
    switch (transport) {
      case 'Air':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueAir
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueAir;
      case 'Bicycle':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueBicycle
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueBicycle;
      case 'Bus':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueBus
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueBus;
      case 'Cableway':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueCableway
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueCableway;
      case 'Carferry':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueCarferry
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueCarferry;
      case 'Citybike':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueCitybike
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueCitybike;
      case 'Ferry':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueFerry
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueFerry;
      case 'Funicular':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueFunicular
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueFunicular;
      case 'Helicopter':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueHelicopter
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueHelicopter;
      case 'Metro':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueMetro
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueMetro;
      case 'Mobility':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueMobility
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueMobility;
      case 'Plane':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTruePlane
            : ComponentDarkTokens.travelTravelSwitchContrastIconTruePlane;
      case 'Rail':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueRail
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueRail;
      case 'Taxi':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueTaxi
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueTaxi;
      case 'Train':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueTrain
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueTrain;
      case 'Tram':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueTram
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueTram;
      case 'Walk':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueWalk
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueWalk;
      case 'Water':
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueWater
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueWater;
      case 'Airportlinkbus':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchContrastIconTrueairportLinkBus
            : ComponentDarkTokens
                  .travelTravelSwitchContrastIconTrueairportLinkBus;
      case 'Airportlinkrail':
        return isLight
            ? ComponentLightTokens
                  .travelTravelSwitchContrastIconTrueairportLinkRail
            : ComponentDarkTokens
                  .travelTravelSwitchContrastIconTrueairportLinkRail;
      default:
        return isLight
            ? ComponentLightTokens.travelTravelSwitchContrastIconTrueBus
            : ComponentDarkTokens.travelTravelSwitchContrastIconTrueBus;
    }
  }
}
