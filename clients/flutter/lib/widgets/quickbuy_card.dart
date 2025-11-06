import 'package:flutter/material.dart';
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
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 2, color: BaseLightTokens.strokeSubdued),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      leading: OmsaIcons.ValidTicket(),
      horizontalTitleGap: 8,
      title: Text(destinationText, style: AppTypography.textLarge),
      subtitle: Text(
        '$ticketTypeText ⋅ $travellers',
        style: AppTypography.textMedium.copyWith(
          color: BaseLightTokens.textSubdued,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: OmsaIcons.RightArrow(),
      onTap: onTap,
    );
  }
}
