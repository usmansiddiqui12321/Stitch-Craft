import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stitch_craft/Widgets/RoundButton.dart';
import 'package:stitch_craft/res/color.dart';
import 'package:stitch_craft/view/BodySize/Components/body_size_comp.dart';
import 'package:stitch_craft/view/Place%20Order/place_order.dart';

class BodySize extends StatelessWidget {
  const BodySize(
      {super.key,
      required this.tailoremail,
      required this.tailorname,
      required this.tailorlocation,
      required this.price});
  final String tailoremail, tailorname, tailorlocation;
  final int price;

  @override
  Widget build(BuildContext context) {
    TextEditingController hipController = TextEditingController();
    TextEditingController inseamController = TextEditingController();
    TextEditingController sleeveLengthController = TextEditingController();
    TextEditingController chestController = TextEditingController();
    TextEditingController waistController = TextEditingController();
    TextEditingController neckController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Enter your Sizes",
                  style: GoogleFonts.dmSerifDisplay(
                      fontSize: 30, color: AppColors.primaryColor),
                ),
              ),
              SizesofBody(
                  firsttitle: "Neck",
                  secondtitle: "Chest",
                  firstController: neckController,
                  secondController: chestController),
              const SizedBox(height: 20),
              SizesofBody(
                  firsttitle: "Sleeve",
                  secondtitle: "waist",
                  firstController: sleeveLengthController,
                  secondController: waistController),
              const SizedBox(height: 20),
              SizesofBody(
                  firsttitle: "Hips",
                  secondtitle: "Inseam",
                  firstController: hipController,
                  secondController: inseamController),
              const SizedBox(height: 20),
              Center(
                child: RoundButton(
                  onpress: () {
                    FocusScope.of(context).unfocus();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaceOrder(
                          tailoremail: tailoremail,
                          tailorname: tailorname,
                          tailorlocation: tailorlocation,
                          price: price,
                          hips: double.tryParse(hipController.text) ?? 0,
                          inseam: double.tryParse(inseamController.text) ?? 0,
                          sleeveLength:
                              double.tryParse(sleeveLengthController.text) ?? 0,
                          chest: double.tryParse(chestController.text) ?? 0,
                          waist: double.tryParse(waistController.text) ?? 0,
                          neck: double.tryParse(neckController.text) ?? 0,
                        ),
                      ),
                    ).then((value) {
                      hipController.clear();
                      waistController.clear();
                      inseamController.clear();
                      neckController.clear();
                      chestController.clear();
                      sleeveLengthController.clear();
                    });
                  },
                  title: "Details",
                  buttonColor: AppColors.primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
