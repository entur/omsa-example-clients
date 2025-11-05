import 'package:flutter/material.dart';
import 'package:omsa_icons/omsa_icons.dart';
import 'package:omsa_demo_app/screens/search_screen.dart';
import 'package:omsa_demo_app/screens/tickets_screen.dart';
import 'package:omsa_demo_app/screens/profile_screen.dart';

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
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: OmsaIcons.Search(size: 24),
            selectedIcon: OmsaIcons.SearchFilled(size: 24),
            label: 'Search',
          ),
          NavigationDestination(
            icon: OmsaIcons.ValidTicket(size: 24),
            selectedIcon: OmsaIcons.ValidTicketFilled(size: 24),
            label: 'Tickets',
          ),
          NavigationDestination(
            icon: OmsaIcons.User(size: 24),
            selectedIcon: OmsaIcons.User(size: 24),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}