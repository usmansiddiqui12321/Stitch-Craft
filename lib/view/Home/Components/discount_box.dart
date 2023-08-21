

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stitch_craft/Widgets/RoundButton.dart';
import 'package:stitch_craft/res/color.dart';

class DiscountBox extends StatelessWidget {
  const DiscountBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Get 32% Promo",
                style: GoogleFonts.dmSerifDisplay(
                    fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 20),
              RoundButton(
                onpress: () {},
                title: "Redeem",
                buttonColor: AppColors.primaryButtonColor,
              ),
            ],
          ),
          Image.asset(
            "assets/loginimage.png",
            height: 100,
          ),
        ],
      ),
    );
  }
}
