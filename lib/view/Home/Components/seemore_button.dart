import 'package:flutter/material.dart';
import 'package:stitch_craft/res/color.dart';
import 'package:stitch_craft/view/ListOfTailorPage/list_of_tailor_page.dart';

class SeemoreButton extends StatelessWidget {
  const SeemoreButton({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListOfTailorPage())),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "see more",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.primaryColor,
                )
              ],
            ),
          )),
    );
  }
}
