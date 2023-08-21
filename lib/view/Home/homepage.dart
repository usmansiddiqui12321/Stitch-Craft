import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stitch_craft/view/Home/Components/discount_box.dart';
import 'package:stitch_craft/view/Home/Components/near_by_you.dart';
import 'package:stitch_craft/view/Home/Components/near_by_you_heading.dart';
import 'package:stitch_craft/view/Home/Components/seemore_button.dart';
import 'package:stitch_craft/view/Home/Components/tailor.dart';
import 'package:stitch_craft/view/Home/Components/tailor_heading.dart';
import 'package:stitch_craft/view/Home/drawer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DateTime? _lastPressedAt;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        bottomOpacity: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Stitch Craft",
          style: GoogleFonts.aBeeZee(fontSize: 25),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt!) >
                  const Duration(seconds: 1)) {
            // show toast message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Press back again to exit"),
              ),
            );

            // save the current time
            _lastPressedAt = DateTime.now();
            return false;
          } else {
            // close the app
            await SystemNavigator.pop();
            return true;
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //! Discount Container
                const DiscountBox(),
                const SizedBox(height: 20),
                //! Heading
                const TailorHeading(
                  title: "Tailors",
                  color: Colors.black,
                ),
                //! Tailor
                const Tailor(),
                //! Heading
                SeemoreButton(size: size),
                const SizedBox(height: 20),
                //! Heading
                const NearByYouHeading(),
                //! Near By You
                NearByYou(
                  height: size.height * .185,
                  width: size.width * .85,
                  axis: Axis.horizontal,
                  ItemCount: 3,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
