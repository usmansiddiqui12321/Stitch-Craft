import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stitch_craft/View%20Model/discount.dart';
import 'package:stitch_craft/Widgets/RoundButton.dart';
import 'package:stitch_craft/res/color.dart';

class DiscountBox extends StatefulWidget {
  const DiscountBox({
    super.key,
  });

  @override
  State<DiscountBox> createState() => _DiscountBoxState();
}

class _DiscountBoxState extends State<DiscountBox> {
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
                "Get 22% Promo",
                style: GoogleFonts.dmSerifDisplay(
                    fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ChangeNotifierProvider(
                create: (_) => Discount(),
                child: Consumer<Discount>(
                  builder: (context, provider, child) {
                    return FutureBuilder<bool>(
                      future: provider
                          .getvalue(), // Call your getvalue() method here
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Display a loading indicator while fetching data
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          bool isAvailed = snapshot.data ?? false;
                          String availedText = isAvailed ? "Availed" : "Redeem";

                          return RoundButton(
                              onpress: () {
                                provider.setvalue().then((value) {
                                  setState(() {});
                                });
                              },
                              title: availedText);
                        }
                      },
                    );
                  },
                ),
              )
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
