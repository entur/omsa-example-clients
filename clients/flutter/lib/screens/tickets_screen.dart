import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OmsaIcons.ValidTicket(
              size: 64,
              color: AppTheme.light().colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text('Tickets', style: AppTypography.headlineLarge),
            const SizedBox(height: 8),
            Text(
              'Your tickets will appear here',
              style: AppTypography.bodyMedium.copyWith(
                color: AppTheme.light().colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
