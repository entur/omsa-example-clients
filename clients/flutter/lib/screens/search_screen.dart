import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omsa_demo_app/widgets/demo_badge.dart';
import 'package:omsa_demo_app/widgets/quickbuy_card.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/services/omsa_api_service.dart';
import 'package:omsa_demo_app/screens/offers_screen.dart';
import 'package:omsa_icons/omsa_icons.dart';
import 'package:omsa_demo_app/widgets/departure_time_drawer.dart';
import 'package:omsa_demo_app/widgets/traveler_picker_drawer.dart';
import 'package:omsa_demo_app/theme/wayfare_tokens.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();

  OmsaDropdownItem<String>? _fromZone;
  OmsaDropdownItem<String>? _toZone;
  TimeType _timeType = TimeType.now;
  DateTime _selectedDateTime = DateTime.now().add(const Duration(minutes: 30));
  int _adults = 1;
  int _children = 0;
  int _infants = 0;
  bool _isLoading = false;

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
      initialAdults: _adults,
      initialChildren: _children,
      initialInfants: _infants,
    );

    if (result != null) {
      setState(() {
        _adults = result.adults;
        _children = result.children;
        _infants = result.infants;
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
    final result = TravelerPickerResult(
      adults: _adults,
      children: _children,
      infants: _infants,
    );
    return result.displayText;
  }

  Future<void> _searchOffers() async {
    if (!_formKey.currentState!.validate()) return;

    if (_fromZone == null || _toZone == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select both zones')));
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

      // Use average age of 30 for adults, 12 for children, 3 for infants
      final avgAge =
          ((_adults * 30) + (_children * 12) + (_infants * 3)) /
          (_adults + _children + _infants);

      final offerCollection = await OmsaApiService.searchOffers(
        fromZoneId: _fromZone!.value,
        toZoneId: _toZone!.value,
        startTime: startTime,
        endTime: endTime,
        travelerAge: avgAge.round(),
      );

      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OffersScreen(offers: offerCollection),
          ),
        );
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
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.zero,
          child: SvgPicture.asset('assets/wayfare_combined_header.svg'),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: DemoBadge(text: "Demo"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),

              Text('Where are you going?', style: AppTypography.textExtraLarge),

              const SizedBox(height: 16),

              OmsaButton(
                onPressed: _openTravelerPicker,
                variant: OmsaButtonVariant.secondary,
                contentAlignment: OmsaButtonContentAlignment.spaceBetween,
                leadingIcon: OmsaIcons.User(
                  color: context.wayfareTokens.brandPrimary,
                ),
                trailingIcon: Text(
                  "Change",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.wayfareTokens.brandPrimary,
                  ),
                ),
                child: Text(
                  _getTravelersDisplayText(),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: context.wayfareTokens.brandPrimary,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              OmsaButton(
                onPressed: _openTimePicker,
                variant: OmsaButtonVariant.secondary,
                contentAlignment: OmsaButtonContentAlignment.spaceBetween,
                leadingIcon: OmsaIcons.Clock(
                  color: context.wayfareTokens.brandPrimary,
                ),
                trailingIcon: Text(
                  "Change",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.wayfareTokens.brandPrimary,
                  ),
                ),
                child: Text(
                  _getTimeDisplayText(),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: context.wayfareTokens.brandPrimary,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              OmsaButton(
                onPressed: _isLoading ? null : _searchOffers,
                isLoading: _isLoading,
                width: OmsaButtonWidth.fluid,
                leadingIcon: OmsaIcons.Search(),
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
    );
  }
}
