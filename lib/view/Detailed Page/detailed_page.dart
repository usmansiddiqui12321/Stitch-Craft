import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stitch_craft/View%20Model/discount.dart';
import 'package:stitch_craft/Widgets/RoundButton.dart';
import 'package:stitch_craft/res/color.dart';
import 'package:stitch_craft/view/BodySize/body_size.dart';

class DetailedPage extends StatefulWidget {
  final String name, location, image, rating, description, tailoremail;
  final int price;
  const DetailedPage({
    super.key,
    required this.name,
    required this.location,
    required this.image,
    required this.rating,
    required this.price,
    required this.description,
    required this.tailoremail,
  });

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView(
                children: [
                  Image(image: NetworkImage(widget.image), height: 200),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Location : ${widget.location}",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Row(
                        children: [
                          Text(
                            "Rating: ",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Icon(Icons.star, color: Colors.yellow[700]),
                          const SizedBox(width: 5),
                          Text(
                            widget.rating,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  // food name
                  Text(widget.name,
                      style: GoogleFonts.dmSerifDisplay(fontSize: 28)),
                  const SizedBox(height: 25),

                  //Description
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: 14, height: 2),
                  ),
                ],
              ),
            ),
          ),

          // Place Order Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            color: AppColors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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

                            return Text(
                              isAvailed
                                  ? "Rs ${widget.price * .78}"
                                  : "Rs ${widget.price}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                // Text(
                //   "Rs ${widget.price.toString()}",
                //   style: const TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 18),
                // ),
                RoundButton(
                  onpress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BodySize(
                            tailoremail: widget.tailoremail,
                            tailorname: widget.name,
                            tailorlocation: widget.location,
                            price: widget.price as int,
                          ),
                        ));
                  },
                  title: "Place Order",
                  textColor: Colors.white,
                  buttonColor: AppColors.primaryButtonColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
