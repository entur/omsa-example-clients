import 'package:flutter/material.dart';
import 'package:omsa_demo_app/theme/wayfare_tokens.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';

class TravelSearchResult {
  final String fromZoneId;
  final String fromZoneName;
  final String toZoneId;
  final String toZoneName;

  TravelSearchResult({
    required this.fromZoneId,
    required this.fromZoneName,
    required this.toZoneId,
    required this.toZoneName,
  });
}

class TravelSearch extends StatefulWidget {
  final String? initialFromZoneId;
  final String? initialFromZoneName;
  final String? initialToZoneId;
  final String? initialToZoneName;
  final List<Map<String, String>> zones;
  final ValueChanged<TravelSearchResult>? onChanged;

  const TravelSearch({
    super.key,
    this.initialFromZoneId,
    this.initialFromZoneName,
    this.initialToZoneId,
    this.initialToZoneName,
    required this.zones,
    this.onChanged,
  });

  @override
  State<TravelSearch> createState() => _TravelSearchState();
}

class _TravelSearchState extends State<TravelSearch> {
  String? _fromZoneId;
  String? _fromZoneName;
  String? _toZoneId;
  String? _toZoneName;

  @override
  void initState() {
    super.initState();
    _fromZoneId = widget.initialFromZoneId;
    _fromZoneName = widget.initialFromZoneName;
    _toZoneId = widget.initialToZoneId;
    _toZoneName = widget.initialToZoneName;
  }

  Future<void> _openFromLocationPicker() async {
    final result = await TravelSearchDrawer.show(
      context,
      zones: widget.zones,
      title: 'From',
      subtitle: 'Your position',
    );

    if (result != null) {
      setState(() {
        _fromZoneId = result['id'];
        _fromZoneName = result['name'];
      });
      _notifyChanged();
    }
  }

  Future<void> _openToLocationPicker() async {
    final result = await TravelSearchDrawer.show(
      context,
      zones: widget.zones,
      title: 'To',
      subtitle: 'Destination',
    );

    if (result != null) {
      setState(() {
        _toZoneId = result['id'];
        _toZoneName = result['name'];
      });
      _notifyChanged();
    }
  }

  void _notifyChanged() {
    if (_fromZoneId != null &&
        _fromZoneName != null &&
        _toZoneId != null &&
        _toZoneName != null) {
      widget.onChanged?.call(
        TravelSearchResult(
          fromZoneId: _fromZoneId!,
          fromZoneName: _fromZoneName!,
          toZoneId: _toZoneId!,
          toZoneName: _toZoneName!,
        ),
      );
    }
  }

  Widget _buildLocationButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required String label,
    required String value,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.wayfareTokens.brandPrimary),
                ),
                const SizedBox(width: 12),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: context.tokens.textSubdued,
                  ),
                ),
              ],
            ),
            OmsaIcons.RightArrow(size: 20, color: context.wayfareTokens.brandPrimary),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      decoration: BoxDecoration(
        color: isLight ? Colors.transparent : context.tokens.frameTint,
        border: Border.all(color: isLight ? context.tokens.strokeSubdued : context.tokens.frameTint, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLocationButton(
            context: context,
            onPressed: _openFromLocationPicker,
            label: 'From',
            value: _fromZoneName ?? 'Your position',
          ),
          Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: isLight ? context.tokens.strokeSubduedAlt : context.tokens.frameSubdued,
          ),
          _buildLocationButton(
            context: context,
            onPressed: _openToLocationPicker,
            label: 'To',
            value: _toZoneName ?? 'Destination',
          ),
        ],
      ),
    );
  }
}

class TravelSearchDrawer extends StatefulWidget {
  final List<Map<String, String>> zones;
  final String title;
  final String subtitle;

  const TravelSearchDrawer({
    super.key,
    required this.zones,
    required this.title,
    required this.subtitle,
  });

  @override
  State<TravelSearchDrawer> createState() => _TravelSearchDrawerState();

  static Future<Map<String, String>?> show(
    BuildContext context, {
    required List<Map<String, String>> zones,
    required String title,
    required String subtitle,
  }) {
    return showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: context.tokens.frameTint,
      builder: (context) =>
          TravelSearchDrawer(zones: zones, title: title, subtitle: subtitle),
    );
  }
}

class _TravelSearchDrawerState extends State<TravelSearchDrawer> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredZones = [];

  final List<Map<String, String>> _shortcuts = [
    {'name': 'Stavanger stasjon', 'id': 'KOL:FareZone:4'},
    {'name': 'Egersund stasjon', 'id': 'KOL:FareZone:7'},
    {'name': 'Klepp stasjon', 'id': 'KOL:FareZone:5'},
    {'name': 'Veavågen (Karmøy)', 'id': 'KOL:FareZone:1'},
    {'name': 'Haugesund bussterminal', 'id': 'KOL:FareZone:2'},
  ];

  @override
  void initState() {
    super.initState();
    _filteredZones = widget.zones;
    _searchController.addListener(_filterZones);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get _isSearching => _searchController.text.isNotEmpty;

  void _filterZones() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredZones = widget.zones;
      } else {
        _filteredZones = widget.zones
            .where((zone) => zone['name']!.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _selectZone(Map<String, String> zone) {
    Navigator.of(context).pop(zone);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final isLight = Theme.of(context).brightness == Brightness.light;

    // Recent searches for demo purposes
    final recentSearches = [
      {'name': 'Stavanger stasjon', 'id': 'KOL:FareZone:4'},
      {'name': 'Haugesund bussterminal', 'id': 'KOL:FareZone:2'},
    ];

    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              // Sticky header section
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Drag handle
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Center(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
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
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: OmsaTextField(
                      controller: _searchController,
                      label: 'Search',
                      hint: 'Where do you want to go?',
                      prepend: OmsaIcons.Search(size: 20, color: tokens.textSubdued),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 32,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(left: 24),
                      scrollDirection: Axis.horizontal,
                      itemCount: _shortcuts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final shortcut = _shortcuts[index];
                        return OmsaActionChip(
                          label: Text(shortcut['name']!),
                          onPressed: () => _selectZone(shortcut),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
              // Scrollable content
              Expanded(
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    // Recent section - only show when not searching
                    if (!_isSearching) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Recent',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final item = recentSearches[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: OmsaIcons.MapPin(
                                  color: context.wayfareTokens.brandPrimary,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                title: Text(
                                  item['name']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  'Zone ${item['id']!.split(':')[2]}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: tokens.textSubdued,
                                  ),
                                ),
                                onTap: () => _selectZone(item),
                              ),
                              if (index < recentSearches.length - 1)
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  indent: 16,
                                  endIndent: 16,
                                  color: isLight ? tokens.strokeSubduedAlt : tokens.frameSubdued,
                                ),
                            ],
                          );
                        }, childCount: recentSearches.length),
                      ),
                    ],
                    // Zones section - show heading only when not searching
                    if (!_isSearching)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                          child: Text(
                            'Zones',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    // Zones list - show results or empty state
                    if (_filteredZones.isEmpty && _isSearching)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/turtle_searching.png',
                                width: 200,
                                height: 200,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Oops!",
                                style: AppTypography.titleMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "We can't find any places with that name...",
                                style: AppTypography.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final zone = _filteredZones[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: OmsaIcons.MapPin(
                                  color: context.wayfareTokens.brandPrimary,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                title: Text(
                                  zone['name']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  'Zone ${zone['id']!.split(':')[2]}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: tokens.textSubdued,
                                  ),
                                ),
                                onTap: () => _selectZone(zone),
                              ),
                              if (index < _filteredZones.length - 1)
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  indent: 16,
                                  endIndent: 16,
                                  color: isLight ? tokens.strokeSubduedAlt : tokens.frameSubdued,
                                ),
                            ],
                          );
                        }, childCount: _filteredZones.length),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
