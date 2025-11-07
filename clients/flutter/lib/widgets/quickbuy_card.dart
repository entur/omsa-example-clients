import 'package:flutter/material.dart';
import 'package:omsa_demo_app/theme/wayfare_tokens.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';

class QuickbuyCard extends StatelessWidget {
  const QuickbuyCard({
    super.key,
    required this.onTap,
    required this.travellers,
    required this.from,
    required this.to,
    required this.time,
    required this.ticketType,
  });

  final VoidCallback onTap;
  final String travellers;
  final String from;
  final String to;
  final String time;
  final String ticketType;

  String get ticketTypeText {
    return ticketType == 'single' ? 'Single ticket' : '24-hour ticket';
  }

  String get destinationText {
    return to == from ? to : '$from to $to';
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return ListTile(
      dense: true,
      tileColor: isLight ? Colors.transparent : tokens.frameTint,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 2, color: isLight ? tokens.strokeSubdued : tokens.frameTint),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      leading: OmsaIcons.ValidTicket(size: 20, color: context.wayfareTokens.brandPrimary),
      horizontalTitleGap: 8,
      title: Text(destinationText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      subtitle: Text(
        '$ticketTypeText ⋅ $travellers',
        style: TextStyle(
          fontSize: 14,
          color: tokens.textSubdued,
          fontWeight: FontWeight.normal,
        ),
      ),
      trailing: OmsaIcons.RightArrow(size: 20, color: context.wayfareTokens.brandPrimary),
      onTap: onTap,
    );
  }
}
