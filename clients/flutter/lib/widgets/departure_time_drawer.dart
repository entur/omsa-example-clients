import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';

enum TimeType { now, departure, arrival }

class DepartureTimeDrawerResult {
  final TimeType timeType;
  final DateTime? selectedDateTime;

  DepartureTimeDrawerResult({required this.timeType, this.selectedDateTime});
}

class DepartureTimeDrawer extends StatefulWidget {
  final TimeType initialTimeType;
  final DateTime? initialDateTime;

  const DepartureTimeDrawer({
    super.key,
    this.initialTimeType = TimeType.now,
    this.initialDateTime,
  });

  @override
  State<DepartureTimeDrawer> createState() => _DepartureTimeDrawerState();

  static Future<DepartureTimeDrawerResult?> show(
    BuildContext context, {
    TimeType initialTimeType = TimeType.now,
    DateTime? initialDateTime,
  }) {
    return showModalBottomSheet<DepartureTimeDrawerResult>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: context.tokens.frameTint,
      builder: (context) => DepartureTimeDrawer(
        initialTimeType: initialTimeType,
        initialDateTime: initialDateTime,
      ),
    );
  }
}

class _DepartureTimeDrawerState extends State<DepartureTimeDrawer> {
  late TimeType _selectedTimeType;
  late DateTime _selectedDate;
  late int _selectedHour;
  late int _selectedMinute;

  late FixedExtentScrollController _dateController;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  @override
  void initState() {
    super.initState();
    _selectedTimeType = widget.initialTimeType;
    final initialTime = widget.initialDateTime ?? DateTime.now();
    _selectedDate = DateTime(
      initialTime.year,
      initialTime.month,
      initialTime.day,
    );
    _selectedHour = initialTime.hour;
    _selectedMinute = initialTime.minute;

    final dates = _getAvailableDates();
    final dateIndex = dates.indexWhere((d) => d == _selectedDate);

    _dateController = FixedExtentScrollController(
      initialItem: dateIndex >= 0 ? dateIndex : 0,
    );
    _hourController = FixedExtentScrollController(initialItem: _selectedHour);
    _minuteController = FixedExtentScrollController(
      initialItem: _selectedMinute,
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_selectedTimeType == TimeType.now) {
      Navigator.of(context).pop(
        DepartureTimeDrawerResult(
          timeType: TimeType.now,
          selectedDateTime: null,
        ),
      );
    } else {
      final dateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedHour,
        _selectedMinute,
      );
      Navigator.of(context).pop(
        DepartureTimeDrawerResult(
          timeType: _selectedTimeType,
          selectedDateTime: dateTime,
        ),
      );
    }
  }

  List<DateTime> _getAvailableDates() {
    final now = DateTime.now();
    final dates = <DateTime>[];
    for (int i = 0; i < 5; i++) {
      dates.add(DateTime(now.year, now.month, now.day + i));
    }
    return dates;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    if (date == today) {
      return 'I dag';
    } else if (date == tomorrow) {
      return 'I morgen';
    } else {
      final weekdays = ['man.', 'tir.', 'ons.', 'tor.', 'fre.', 'lør.', 'søn.'];
      final months = [
        'jan',
        'feb',
        'mar',
        'apr',
        'mai',
        'jun',
        'jul',
        'aug',
        'sep',
        'okt',
        'nov',
        'des',
      ];
      return '${weekdays[date.weekday - 1]} ${date.day}. ${months[date.month - 1]}';
    }
  }

  bool _isAnimatingToNow = false;

  void _animateToNow() {
    final now = DateTime.now();
    final dates = _getAvailableDates();
    final today = DateTime(now.year, now.month, now.day);
    final dateIndex = dates.indexWhere((d) => d == today);

    _isAnimatingToNow = true;

    setState(() {
      _selectedTimeType = TimeType.now;
      _selectedDate = today;
      _selectedHour = now.hour;
      _selectedMinute = now.minute;
    });

    // Animate all three pickers to current time
    if (dateIndex >= 0) {
      _dateController.animateToItem(
        dateIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    _hourController.animateToItem(
      now.hour,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    _minuteController.animateToItem(
      now.minute,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    // Reset flag after animation completes
    Future.delayed(const Duration(milliseconds: 350), () {
      _isAnimatingToNow = false;
    });
  }

  Widget _buildPickerColumn({
    required FixedExtentScrollController controller,
    required int itemCount,
    required Widget Function(int) itemBuilder,
    required void Function(int) onSelectedItemChanged,
  }) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: 40,
      physics: const FixedExtentScrollPhysics(),
      diameterRatio: 1.5,
      onSelectedItemChanged: onSelectedItemChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) => itemBuilder(index),
        childCount: itemCount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableDates = _getAvailableDates();
    final tokens = context.tokens;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: tokens.strokeSubdued,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dato og tid',
                  style: AppTypography.textExtraLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                OmsaIconButton(
                  icon: OmsaIcons.CloseSmall(),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // "Now" chip and Segmented Control row
            Row(
              children: [
                OmsaChoiceChip(
                  value: 'now',
                  groupValue: _selectedTimeType == TimeType.now
                      ? 'now'
                      : 'other',
                  onSelected: (value) {
                    if (value == 'now') {
                      _animateToNow();
                    }
                  },
                  leadingIcon: OmsaIcons.Clock(size: 16),
                  label: const Text('Now'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OmsaSegmentedControl(
                    value: _selectedTimeType == TimeType.now
                        ? 'departure'
                        : (_selectedTimeType == TimeType.departure
                              ? 'departure'
                              : 'arrival'),
                    onChanged: (value) {
                      setState(() {
                        _selectedTimeType = value == 'departure'
                            ? TimeType.departure
                            : TimeType.arrival;
                      });
                    },
                    children: const [
                      OmsaSegmentedChoice(
                        value: 'departure',
                        child: Text('Departure'),
                      ),
                      OmsaSegmentedChoice(
                        value: 'arrival',
                        child: Text('Arrival'),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // iOS-style picker with 3 columns (always visible)
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  // Three columns for date, hour, minute
                  Row(
                    children: [
                      // Date column
                      Expanded(
                        flex: 3,
                        child: _buildPickerColumn(
                          controller: _dateController,
                          itemCount: availableDates.length,
                          itemBuilder: (index) => Center(
                            child: Text(
                              _formatDate(availableDates[index]),
                              style: AppTypography.textMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedDate = availableDates[index];
                              // If user manually scrolls, exit "now" mode
                              if (_selectedTimeType == TimeType.now &&
                                  !_isAnimatingToNow) {
                                _selectedTimeType = TimeType.departure;
                              }
                            });
                          },
                        ),
                      ),
                      // Hour column
                      Expanded(
                        flex: 2,
                        child: _buildPickerColumn(
                          controller: _hourController,
                          itemCount: 24,
                          itemBuilder: (index) => Center(
                            child: Text(
                              index.toString().padLeft(2, '0'),
                              style: AppTypography.textMedium,
                            ),
                          ),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedHour = index;
                              // If user manually scrolls, exit "now" mode
                              if (_selectedTimeType == TimeType.now &&
                                  !_isAnimatingToNow) {
                                _selectedTimeType = TimeType.departure;
                              }
                            });
                          },
                        ),
                      ),
                      // Minute column
                      Expanded(
                        flex: 2,
                        child: _buildPickerColumn(
                          controller: _minuteController,
                          itemCount: 60,
                          itemBuilder: (index) => Center(
                            child: Text(
                              index.toString().padLeft(2, '0'),
                              style: AppTypography.textMedium,
                            ),
                          ),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedMinute = index;
                              // If user manually scrolls, exit "now" mode
                              if (_selectedTimeType == TimeType.now &&
                                  !_isAnimatingToNow) {
                                _selectedTimeType = TimeType.departure;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  // Selection indicator (center highlight) - segmented lines with gaps
                  Center(
                    child: Row(
                      children: [
                        // Date column lines
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: tokens.strokeSubdued,
                                  width: 2,
                                ),
                                bottom: BorderSide(
                                  color: tokens.strokeSubdued,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Hour column lines
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: tokens.strokeSubdued,
                                  width: 2,
                                ),
                                bottom: BorderSide(
                                  color: tokens.strokeSubdued,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Minute column lines
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: tokens.strokeSubdued,
                                  width: 2,
                                ),
                                bottom: BorderSide(
                                  color: tokens.strokeSubdued,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Top fade gradient
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 80,
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              tokens.frameTint,
                              tokens.frameTint.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Bottom fade gradient
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 80,
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              tokens.frameTint,
                              tokens.frameTint.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            OmsaButton(
              onPressed: _submit,
              width: OmsaButtonWidth.fluid,
              child: Text(
                _selectedTimeType == TimeType.now
                    ? 'Search for travel'
                    : 'Confirm time',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
