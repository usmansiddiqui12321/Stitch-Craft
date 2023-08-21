import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stitch_craft/res/color.dart';
import 'package:stitch_craft/view/Home/Components/near_by_you.dart';
import 'package:stitch_craft/view/Home/Components/tailor_heading.dart';

class ListOfTailorPage extends StatelessWidget {
  const ListOfTailorPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Tailors",
          style: GoogleFonts.dmSerifDisplay(fontSize: 25, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 25),
          const TailorHeading(
            title: "Top Rated",
            color: Colors.black,
          ),
          NearByYou(
            axis: Axis.vertical,
            height: size.height * .75,
            width: size.width,
            ItemCount: 10,
          ),
        ],
      ),
    );
  }
}
