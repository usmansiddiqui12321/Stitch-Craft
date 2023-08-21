import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NearByYouHeading extends StatelessWidget {
  const NearByYouHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 20),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          "Near by you",
          style: GoogleFonts.dmSerifDisplay(fontSize: 30),
        ),
      ),
    );
  }
}