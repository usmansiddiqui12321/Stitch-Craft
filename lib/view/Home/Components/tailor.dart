import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stitch_craft/res/color.dart';
import 'package:stitch_craft/view/Detailed%20Page/detailed_page.dart';
import 'package:stitch_craft/view/Home/Components/stitcher.dart';

class Tailor extends StatelessWidget {
  const Tailor({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Expanded(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('stitchers').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final tailor = snapshot.data!.docs[index];
                    return Stitcher(
                      location: tailor['location'],
                      name: tailor['name'],
                      image: tailor["image"],
                      rating: tailor['rating'],
                      price: tailor['price'] ,
                      description: tailor['description'],
                      onpress: () {
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
                    );
                  },
                );
              } else {
                return const Text("No stitchers found");
              }
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
