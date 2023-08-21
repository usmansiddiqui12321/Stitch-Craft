import 'package:flutter/material.dart';
import 'package:stitch_craft/Widgets/custom_form_field.dart';

class DetailField extends StatelessWidget {
  const DetailField({
    super.key,
    required this.type,
    required this.controller,
    required this.maxlines,
    required this.hinttext,
    required this.heading,
  });
  final TextInputType type;
  final TextEditingController controller;
  final int maxlines;
  final String heading, hinttext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        CustomFormField(
            controller: controller,
            keyboardType: type,
            maxlines: maxlines,
            hint: hinttext,
            hintColor: Colors.grey,
            validator: (value) {},
            onChanged: (value) {},
            onFieldSubmitted: (value) {}),
      ],
    );
  }
}
