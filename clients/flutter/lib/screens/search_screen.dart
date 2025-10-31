import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/services/omsa_api_service.dart';
import 'package:omsa_demo_app/screens/offers_screen.dart';
import 'package:omsa_demo_app/screens/widget_design_screen.dart';

enum DepartureType { now, leaveAt, arriveBy }

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _fromZone;
  String? _toZone;
  DepartureType _departureType = DepartureType.now;
  DateTime _selectedDateTime = DateTime.now().add(const Duration(minutes: 30));
  int _travelerAge = 30;
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

      switch (_departureType) {
        case DepartureType.now:
          startTime = DateTime.now();
          endTime = DateTime.now().add(const Duration(hours: 2));
          break;
        case DepartureType.leaveAt:
          startTime = _selectedDateTime;
          endTime = _selectedDateTime.add(const Duration(hours: 2));
          break;
        case DepartureType.arriveBy:
          endTime = _selectedDateTime;
          startTime = _selectedDateTime.subtract(const Duration(hours: 2));
          break;
      }

      final offerCollection = await OmsaApiService.searchOffers(
        fromZoneId: _fromZone!,
        toZoneId: _toZone!,
        startTime: startTime,
        endTime: endTime,
        travelerAge: _travelerAge,
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

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (date == null) return;

    if (mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OMSA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            tooltip: 'Widget Design Lab',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const WidgetDesignScreen(),
                ),
              );
            },
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
              Text(
                'Where are you going?',
                style: AppTypography.textLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),

              OmsaDropdown<String>(
                label: 'From Zone',
                value: _fromZone,
                items: _zones.map((zone) {
                  return DropdownMenuItem(
                    value: zone['id'],
                    child: Text(zone['name']!),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _fromZone = value),
              ),
              const SizedBox(height: 16),

              OmsaDropdown<String>(
                label: 'To Zone',
                value: _toZone,
                items: _zones.map((zone) {
                  return DropdownMenuItem(
                    value: zone['id'],
                    child: Text(zone['name']!),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _toZone = value),
              ),
              const SizedBox(height: 16),

              Text(
                'Departure',
                style: AppTypography.textLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              SegmentedButton<DepartureType>(
                segments: const [
                  ButtonSegment(
                    value: DepartureType.now,
                    label: Text('Now'),
                    icon: Icon(Icons.schedule),
                  ),
                  ButtonSegment(
                    value: DepartureType.leaveAt,
                    label: Text('Leave at'),
                    icon: Icon(Icons.departure_board),
                  ),
                  ButtonSegment(
                    value: DepartureType.arriveBy,
                    label: Text('Arrive by'),
                    icon: Icon(Icons.flag),
                  ),
                ],
                selected: {_departureType},
                onSelectionChanged: (value) {
                  setState(() {
                    _departureType = value.first;
                  });
                },
              ),
              const SizedBox(height: 16),

              if (_departureType != DepartureType.now) ...[
                ListTile(
                  title: Text(
                    _departureType == DepartureType.leaveAt
                        ? 'Departure Time'
                        : 'Arrival Time',
                  ),
                  subtitle: Text(_selectedDateTime.toString().substring(0, 16)),
                  trailing: const Icon(Icons.access_time),
                  onTap: _selectDateTime,
                  tileColor: BaseLightTokens.frameElevatedAlt,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              OmsaTextField(
                label: 'Traveler Age',
                keyboardType: TextInputType.number,
                initialValue: _travelerAge.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  final age = int.tryParse(value);
                  if (age == null || age < 0 || age > 120) {
                    return 'Enter valid age';
                  }
                  return null;
                },
                onChanged: (value) {
                  final age = int.tryParse(value);
                  if (age != null) _travelerAge = age;
                },
              ),
              const SizedBox(height: 32),

              OmsaButton(
                onPressed: _isLoading ? null : _searchOffers,
                isLoading: _isLoading,
                width: OmsaButtonWidth.fluid,
                size: OmsaButtonSize.large,
                child: const Text('Search Offers'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
