import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:stitch_craft/View%20Model/Services/sessionManager.dart';
import 'package:stitch_craft/Widgets/RoundButton.dart';
import 'package:stitch_craft/res/color.dart';
import 'package:stitch_craft/routes/route_name.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 138, 60, 55),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "Stitch Craft",
                    style: GoogleFonts.dmSerifDisplay(
                        fontSize: 28, color: Colors.white),
                  ),
                  const SizedBox(height: 25),
                  Lottie.asset('assets/introanimation.json'),
                  const SizedBox(height: 25),
                  Text(
                    "Lets Stitch them Together",
                    style: GoogleFonts.dmSerifDisplay(
                        fontSize: 44, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Unleash Your Creativity with Stitch Craft: Where Threads Meet Imagination!",
                    style: TextStyle(color: Colors.grey[300], height: 2),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: RoundButton(
                  onpress: () {
                    if (user != null) {
                      SessionController().userID = user.uid.toString();
                      Navigator.pushNamed(context, Routename.homepage);
                    } else {
                      Navigator.pushNamed(context, Routename.loginScreen);
                    }
                  },
                  title: "Get Started",
                  buttonColor: AppColors.primaryButtonColor,
                  width: size.width * .9,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
