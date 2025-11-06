import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';
import 'package:omsa_demo_app/screens/search_screen.dart';
import 'package:omsa_demo_app/screens/tickets_screen.dart';
import 'package:omsa_demo_app/screens/profile_screen.dart';
import 'package:omsa_demo_app/theme/wayfare_tokens.dart';

class WayfareApp extends StatefulWidget {
  const WayfareApp({super.key});

  @override
  State<WayfareApp> createState() => _WayfareAppState();
}

class _WayfareAppState extends State<WayfareApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    SearchScreen(),
    TicketsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.transparent,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        labelTextStyle: WidgetStateProperty<TextStyle>.fromMap(
          <WidgetStatesConstraint, TextStyle>{
            WidgetState.selected: TextStyle(
              fontSize: 12,
              color: context.wayfareTokens.brandPrimary,
              fontWeight: FontWeight.w600,
            ),
            WidgetState.any: TextStyle(
              fontSize: 12,
              color: context.tokens.textSubdued,
              fontWeight: FontWeight.w500,
            ),
          },
        ),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: OmsaIcons.Search(size: 20, color: context.tokens.textSubdued),
            selectedIcon: OmsaIcons.SearchFilled(
              size: 20,
              color: context.wayfareTokens.brandPrimary,
            ),
            label: 'Search',
          ),
          NavigationDestination(
            icon: OmsaIcons.ValidTicket(
              size: 20,
              color: context.tokens.textSubdued,
            ),
            selectedIcon: OmsaIcons.ValidTicketFilled(
              size: 20,
              color: context.wayfareTokens.brandPrimary,
            ),
            label: 'Tickets',
          ),
          NavigationDestination(
            icon: OmsaIcons.User(size: 20, color: context.tokens.textSubdued),
            selectedIcon: OmsaIcons.User(
              size: 20,
              color: context.wayfareTokens.brandPrimary,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
