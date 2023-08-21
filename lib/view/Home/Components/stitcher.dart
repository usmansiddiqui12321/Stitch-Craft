import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Stitcher extends StatelessWidget {
  const Stitcher(
      {super.key,
      required this.name,
      required this.location,
      required this.image,
      required this.rating,
      required this.onpress,
      required this.price,
      required this.description});
  final String name, location, image, price, rating, description;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: size.height * .5,
        margin: const EdgeInsets.only(left: 25),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: NetworkImage(image), height: 140),
            Text(
              name,
              style: GoogleFonts.dmSerifDisplay(fontSize: 20),
            ),
            //* price + rating
            SizedBox(
              width: size.width * .4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rs $price",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                  Row(
                    children: [
                      Text(
                        "rating",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),
                      Text(
                        rating,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
