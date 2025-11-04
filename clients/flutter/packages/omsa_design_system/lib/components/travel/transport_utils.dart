import 'package:omsa_icons/omsa_icons.dart';

enum Transport {
  metro,
  bus,
  plane,
  helicopter,
  tram,
  funicular,
  cableway,
  taxi,
  bicycle,
  walk,
  train,
  ferry,
  carferry,
  mobility,
  airportLinkBus,
  airportLinkRail,
  rail,
  water,
  air,
  citybike,
  none,
}

class TransportStyle {
  final OmsaIconData icon;
  final String ariaLabel;

  const TransportStyle({
    required this.icon,
    required this.ariaLabel,
  });
}

TransportStyle getTransportStyle(Transport transport) {
  switch (transport) {
    case Transport.metro:
      return const TransportStyle(
        icon: OmsaIcons.Metro,
        ariaLabel: 'T-bane',
      );
    case Transport.bus:
      return const TransportStyle(
        icon: OmsaIcons.Bus,
        ariaLabel: 'Buss',
      );
    case Transport.plane:
    case Transport.air:
      return const TransportStyle(
        icon: OmsaIcons.Plane,
        ariaLabel: 'Fly',
      );
    case Transport.helicopter:
      return const TransportStyle(
        icon: OmsaIcons.Helicopter,
        ariaLabel: 'Helikopter',
      );
    case Transport.tram:
      return const TransportStyle(
        icon: OmsaIcons.Tram,
        ariaLabel: 'Trikk',
      );
    case Transport.funicular:
      return const TransportStyle(
        icon: OmsaIcons.Funicular,
        ariaLabel: 'Taubane',
      );
    case Transport.cableway:
      return const TransportStyle(
        icon: OmsaIcons.Cableway,
        ariaLabel: 'Gondol',
      );
    case Transport.taxi:
      return const TransportStyle(
        icon: OmsaIcons.Taxi,
        ariaLabel: 'Taxi',
      );
    case Transport.bicycle:
    case Transport.citybike:
      return const TransportStyle(
        icon: OmsaIcons.Bicycle,
        ariaLabel: 'Sykkel',
      );
    case Transport.walk:
      return const TransportStyle(
        icon: OmsaIcons.Walk,
        ariaLabel: 'Gange',
      );
    case Transport.train:
    case Transport.rail:
      return const TransportStyle(
        icon: OmsaIcons.Train,
        ariaLabel: 'Tog',
      );
    case Transport.ferry:
    case Transport.water:
      return const TransportStyle(
        icon: OmsaIcons.Ferry,
        ariaLabel: 'Ferge',
      );
    case Transport.carferry:
      return const TransportStyle(
        icon: OmsaIcons.Carferry,
        ariaLabel: 'Bilferge',
      );
    case Transport.mobility:
      return const TransportStyle(
        icon: OmsaIcons.Mobility,
        ariaLabel: 'El-sparkesykkel',
      );
    case Transport.airportLinkBus:
      return const TransportStyle(
        icon: OmsaIcons.Bus,
        ariaLabel: 'Flybuss',
      );
    case Transport.airportLinkRail:
      return const TransportStyle(
        icon: OmsaIcons.Train,
        ariaLabel: 'Flytog',
      );
    case Transport.none:
      return const TransportStyle(
        icon: OmsaIcons.Circle,
        ariaLabel: '',
      );
  }
}

String transportToColorTokenSuffix(Transport transport) {
  switch (transport) {
    case Transport.metro:
      return 'metro';
    case Transport.bus:
      return 'bus';
    case Transport.plane:
    case Transport.air:
      return 'air';
    case Transport.helicopter:
      return 'helicopter';
    case Transport.tram:
      return 'tram';
    case Transport.funicular:
      return 'funicular';
    case Transport.cableway:
      return 'cableway';
    case Transport.taxi:
      return 'taxi';
    case Transport.bicycle:
      return 'bicycle';
    case Transport.citybike:
      return 'citybike';
    case Transport.walk:
      return 'walk';
    case Transport.train:
      return 'train';
    case Transport.rail:
      return 'rail';
    case Transport.ferry:
      return 'ferry';
    case Transport.water:
      return 'water';
    case Transport.carferry:
      return 'carferry';
    case Transport.mobility:
      return 'mobility';
    case Transport.airportLinkBus:
      return 'airportLinkBus';
    case Transport.airportLinkRail:
      return 'airportLinkRail';
    case Transport.none:
      return 'none';
  }
}
