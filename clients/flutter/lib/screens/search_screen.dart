import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:omsa_demo_app/widgets/quickbuy_card.dart';
import 'package:omsa_demo_app/widgets/travel_search.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/services/omsa_api_service.dart';
import 'package:omsa_icons/omsa_icons.dart';
import 'package:omsa_demo_app/widgets/departure_time_drawer.dart';
import 'package:omsa_demo_app/widgets/traveler_picker_drawer.dart';
import 'package:omsa_demo_app/theme/wayfare_tokens.dart';
import 'package:omsa_demo_app/models/traveler_model.dart';
import 'package:omsa_demo_app/providers/offer_selection_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();

  // Default location: Stavanger Lufthavn Sola (in Nord-Jæren zone)
  String? _fromZoneId = 'KOL:FareZone:4'; // Nord-Jæren (Stavanger Airport)
  String? _fromZoneName = 'Nord-Jæren';
  String? _toZoneId;
  String? _toZoneName;

  TimeType _timeType = TimeType.now;
  DateTime _selectedDateTime = DateTime.now().add(const Duration(minutes: 30));

  // Travelers - start with one default traveler (signed-in user mock)
  late List<Traveler> _travelers;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _travelers = [Traveler.defaultTraveler()];
  }

  final List<Map<String, String>> _zones = [
    {'id': 'KOL:FareZone:1', 'name': 'Haugalandet'},
    {'id': 'KOL:FareZone:2', 'name': 'Nærsone Haugesund'},
    {'id': 'KOL:FareZone:3', 'name': 'Ryfylke'},
    {'id': 'KOL:FareZone:4', 'name': 'Nord-Jæren'},
    {'id': 'KOL:FareZone:5', 'name': 'Jæren'},
    {'id': 'KOL:FareZone:6', 'name': 'Dalane'},
    {'id': 'KOL:FareZone:7', 'name': 'Nærsone Egersund'},
  ];

  final List<Map<String, String>> _quickbuyItems = [
    {
      'from': 'Haugalandet',
      'to': 'Ryfylke',
      'time': 'Now',
      'travellers': '1 Adult',
      'ticketType': 'single',
    },
    {
      'from': 'Haugalandet',
      'to': 'Haugalandet',
      'time': 'Now',
      'travellers': '1 Adult',
      'ticketType': '24H',
    },
    {
      'from': 'Jæren',
      'to': 'Nord-Jæren',
      'time': 'Now',
      'travellers': '1 Adult, 2 children',
      'ticketType': 'single',
    },
  ];

  Future<void> _openTravelerPicker() async {
    final result = await TravelerPickerDrawer.show(
      context,
      initialTravelers: _travelers,
    );

    if (result != null) {
      setState(() {
        _travelers = result.travelers;
      });
    }
  }

  Future<void> _openTimePicker() async {
    final result = await DepartureTimeDrawer.show(
      context,
      initialTimeType: _timeType,
      initialDateTime: _selectedDateTime,
    );

    if (result != null) {
      setState(() {
        _timeType = result.timeType;
        if (result.selectedDateTime != null) {
          _selectedDateTime = result.selectedDateTime!;
        }
      });
    }
  }

  String _getTimeDisplayText() {
    if (_timeType == TimeType.now) {
      return 'Departure now';
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final selectedDate = DateTime(
      _selectedDateTime.year,
      _selectedDateTime.month,
      _selectedDateTime.day,
    );

    String dateStr;
    if (selectedDate == today) {
      dateStr = 'today';
    } else if (selectedDate == tomorrow) {
      dateStr = 'tomorrow';
    } else {
      dateStr = '${_selectedDateTime.day}/${_selectedDateTime.month}';
    }

    final timeStr =
        '${_selectedDateTime.hour.toString().padLeft(2, '0')}:${_selectedDateTime.minute.toString().padLeft(2, '0')}';

    return _timeType == TimeType.departure
        ? 'Departure $dateStr at $timeStr'
        : 'Arrival $dateStr at $timeStr';
  }

  String _getTravelersDisplayText() {
    final result = TravelerPickerResult(travelers: _travelers);
    return result.displayText;
  }

  Future<void> _searchOffers() async {
    if (!_formKey.currentState!.validate()) return;

    if (_fromZoneId == null || _toZoneId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your departure and destination zones'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      DateTime startTime, endTime;

      switch (_timeType) {
        case TimeType.now:
          startTime = DateTime.now();
          endTime = DateTime.now().add(const Duration(hours: 2));
          break;
        case TimeType.departure:
          startTime = _selectedDateTime;
          endTime = _selectedDateTime.add(const Duration(hours: 2));
          break;
        case TimeType.arrival:
          endTime = _selectedDateTime;
          startTime = _selectedDateTime.subtract(const Duration(hours: 2));
          break;
      }

      // Convert app travelers to API travelers
      final travellers = OmsaApiService.createTravellersFromModel(_travelers);

      final offerCollection = await OmsaApiService.searchOffers(
        fromZoneId: _fromZoneId!,
        toZoneId: _toZoneId!,
        startTime: startTime,
        endTime: endTime,
        travellers: travellers,
      );

      if (mounted) {
        context.read<OfferSelectionProvider>().setOfferCollection(
          offerCollection,
        );
        context.push('/offers');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/wayfare_combined_header.svg'),
                      OmsaBadge(
                        variant: OmsaBadgeVariant.information,
                        child: "Demo",
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  Text(
                    'Where are you going?',
                    style: AppTypography.textExtraLarge,
                  ),

                  const SizedBox(height: 16),

                  TravelSearch(
                    zones: _zones,
                    initialFromZoneId: _fromZoneId,
                    initialFromZoneName: _fromZoneName,
                    initialToZoneId: _toZoneId,
                    initialToZoneName: _toZoneName,
                    onChanged: (result) {
                      setState(() {
                        _fromZoneId = result.fromZoneId;
                        _fromZoneName = result.fromZoneName;
                        _toZoneId = result.toZoneId;
                        _toZoneName = result.toZoneName;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  OmsaButton(
                    onPressed: _openTravelerPicker,
                    variant: OmsaButtonVariant.secondary,
                    contentAlignment: OmsaButtonContentAlignment.spaceBetween,
                    leadingIcon: OmsaIcons.User(
                      size: 20,
                      color: context.wayfareTokens.brandPrimary,
                    ),
                    trailingIcon: Text(
                      "Change",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: context.wayfareTokens.brandPrimary,
                      ),
                    ),
                    child: Text(
                      _getTravelersDisplayText(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: context.tokens.textSubdued,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  OmsaButton(
                    onPressed: _openTimePicker,
                    variant: OmsaButtonVariant.secondary,
                    contentAlignment: OmsaButtonContentAlignment.spaceBetween,
                    leadingIcon: OmsaIcons.Clock(
                      size: 20,
                      color: context.wayfareTokens.brandPrimary,
                    ),
                    trailingIcon: Text(
                      "Change",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: context.wayfareTokens.brandPrimary,
                      ),
                    ),
                    child: Text(
                      _getTimeDisplayText(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: context.tokens.textSubdued,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  OmsaButton(
                    onPressed: _isLoading ? null : _searchOffers,
                    isLoading: _isLoading,
                    width: OmsaButtonWidth.fluid,
                    leadingIcon: OmsaIcons.Search(size: 20),
                    child: const Text('Search'),
                  ),

                  const SizedBox(height: 32),

                  Text('Quickbuy', style: AppTypography.textExtraLarge),

                  const SizedBox(height: 16),

                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _quickbuyItems.length,
                    itemBuilder: (context, index) {
                      return QuickbuyCard(
                        key: ValueKey<int>(index),
                        onTap: () {
                          // Navigate to the quickbuy screen
                        },
                        travellers: _quickbuyItems[index]['travellers'] ?? '',
                        from: _quickbuyItems[index]['from'] ?? '',
                        to: _quickbuyItems[index]['to'] ?? '',
                        time: _quickbuyItems[index]['time'] ?? '',
                        ticketType: _quickbuyItems[index]['ticketType'] ?? '',
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 8);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
