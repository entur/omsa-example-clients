import 'package:flutter/material.dart';

class DemoBadge extends StatelessWidget {
  const DemoBadge({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFF),
        border: Border.fromBorderSide(
          BorderSide(
            color: Color(0xFFB5C1DC),
            width: 1,
          ),
        ),
        borderRadius: BorderRadius.circular(4)),
        child:
        Text(text, style: TextStyle(color: Color(0xFF181C56), fontWeight: FontWeight.w500)),
    );
  }
}