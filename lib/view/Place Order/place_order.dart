import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stitch_craft/View%20Model/Receipt/receipt_function.dart';
import 'package:stitch_craft/View%20Model/Receipt/receipt_model.dart';
import 'package:stitch_craft/View%20Model/discount.dart';
import 'package:stitch_craft/Widgets/RoundButton.dart';
import 'package:stitch_craft/res/color.dart';
import 'package:stitch_craft/view/Place%20Order/Components/detail_field.dart';
import 'package:http/http.dart' as http;

class PlaceOrder extends StatefulWidget {
  const PlaceOrder(
      {super.key,
      required this.tailoremail,
      required this.tailorname,
      required this.tailorlocation,
      required this.price,
      required this.hips,
      required this.inseam,
      required this.sleeveLength,
      required this.chest,
      required this.waist,
      required this.neck});
  final String tailoremail, tailorname, tailorlocation;
  final double hips, inseam, sleeveLength, chest, waist, neck;
  final int price;
  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailConntroller = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    TextEditingController detailController = TextEditingController();

    ReceiptFunctions receipt = ReceiptFunctions();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Place Order",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Enter Your Details",
                  style: GoogleFonts.dmSerifDisplay(
                      fontSize: 25, color: AppColors.primaryColor),
                ),
                const SizedBox(height: 25),
                DetailField(
                    type: TextInputType.text,
                    controller: nameController,
                    maxlines: 1,
                    hinttext: "Enter Your Name",
                    heading: "Name"),
                const SizedBox(height: 25),
                DetailField(
                    type: TextInputType.emailAddress,
                    controller: emailConntroller,
                    maxlines: 1,
                    hinttext: "Enter your Email",
                    heading: "Email"),
                const SizedBox(height: 25),
                DetailField(
                    type: TextInputType.number,
                    controller: ageController,
                    maxlines: 1,
                    hinttext: "Enter your age",
                    heading: "Age"),
                const SizedBox(height: 25),
                DetailField(
                    type: TextInputType.streetAddress,
                    controller: addressController,
                    maxlines: 1,
                    hinttext: "Enter Your Address",
                    heading: "Address"),
                const SizedBox(height: 25),
                DetailField(
                    type: TextInputType.multiline,
                    controller: detailController,
                    maxlines: 5,
                    hinttext: "Enter Details about your size",
                    heading: "Details"),
                const SizedBox(height: 25),
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
                            int discountedPrice = isAvailed
                                ? (widget.price * 0.78).toInt()
                                : widget.price;

                            return Center(
                              child: RoundButton(
                                onpress: () {
                                  //Send Email
                                  sendEmail(
                                    username: nameController.text,
                                    useremail: emailConntroller.text,
                                    userage: ageController.text,
                                    userdetails: detailController.text,
                                    tailoremail: widget.tailoremail,
                                    tailorname: widget.tailorname,
                                    address: addressController.text,
                                    tailorprice: discountedPrice,
                                    tailorlocation: widget.tailorlocation,
                                    chest: widget.chest,
                                    waist: widget.waist,
                                    hips: widget.hips,
                                    inseam: widget.inseam,
                                    sleeveLength: widget.sleeveLength,
                                    neck: widget.neck,
                                  ).then((value) {
                                    Receipt newReceipt = Receipt(
                                      totalprice: discountedPrice,
                                      tailorName: widget.tailorname,
                                      tailorLocation: widget.tailorlocation,
                                      tailorEmail: widget.tailoremail,
                                      username: nameController.text,
                                      userDetails: detailController.text,
                                      userage: ageController.text,
                                      useremail: emailConntroller.text,
                                      address: addressController.text,
                                      chest: widget.chest,
                                      waist: widget.waist,
                                      hips: widget.hips,
                                      inseam: widget.inseam,
                                      sleeveLength: widget.sleeveLength,
                                      neck: widget.neck,
                                    );
                                    receipt.addReceipt(newReceipt);
                                  }).then((value) {
                                    nameController.clear();
                                    emailConntroller.clear();
                                    ageController.clear();
                                    detailController.clear();
                                    addressController.clear();
                                  });
                                },
                                title: "Place Order",
                                buttonColor: AppColors.primaryColor,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future sendEmail({
  required String username,
  required String useremail,
  required String userage,
  required String address,
  required String userdetails,
  required String tailoremail,
  required String tailorname,
  required int tailorprice,
  required String tailorlocation,
  required double hips,
  required double chest,
  required double waist,
  required double inseam,
  required double sleeveLength,
  required double neck,
}) async {
  const serviceId = 'service_a5gcrtq';
  const templateId = 'template_ucfdmq9';
  const userId = 's1CpTKtqxpymvX0Ft';

  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  final response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        'origin': 'http://localhost'
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'customer_name': username,
          'customer_email': useremail,
          'customer_age': userage,
          'order_detail': userdetails,
          'tailor_name': tailorname,
          'tailor_email': tailoremail,
          'tailor_price': tailorprice,
          'tailor_location': tailorlocation,
          "neck": neck,
          "waist": waist,
          "sleeves": sleeveLength,
          "inseam": inseam,
          "chest": chest,
          "hips": hips,
          "address": address
        }
      }));
  if (kDebugMode) {
    print(response.body);
  }
}
