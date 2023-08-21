import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stitch_craft/view/Detailed%20Page/detailed_page.dart';

class NearByYou extends StatelessWidget {
  const NearByYou(
      {super.key,
      required this.axis,
      required this.height,
      required this.width,
      required this.ItemCount});
  final Axis axis;
  final double height;
  final double width;
  final int ItemCount;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('stitchers')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
                      // Reverse the order of the documents
                      List<QueryDocumentSnapshot> reversedDocs =
                          docs.reversed.toList();

                      return ListView.builder(
                        scrollDirection: axis,
                        itemCount: reversedDocs.length,
                        itemBuilder: (context, index) {
                          final tailor = reversedDocs[index];

                          return TopRated(tailor: tailor, size: size);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TopRated extends StatelessWidget {
  const TopRated({
    super.key,
    required this.tailor,
    required this.size,
  });

  final QueryDocumentSnapshot tailor;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedPage(
              tailoremail: tailor['email'],
              name: tailor['name'],
              location: tailor['location'],
              image: tailor["image"],
              rating: tailor['rating'],
              price: tailor['price'],
              description: tailor['description'],
            ),
          ),
        );
      },
      child: Container(
        width: size.width * .8,
        margin: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Image(image: NetworkImage(tailor["image"]), height: 60),
              const SizedBox(width: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tailor["name"],
                      style: GoogleFonts.dmSerifDisplay(fontSize: 18)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        tailor["rating"],
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.star,
                        color: Colors.yellow[700],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios)
        ]),
      ),
    );
  }
}
