import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TailorHeading extends StatelessWidget {
  const TailorHeading({
    super.key, required this.title, required this.color,
  });
final String title;
final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 20),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          title,
          
          style: GoogleFonts.dmSerifDisplay(fontSize: 30 , color: color),
        ),
      ),
    );
  }
}