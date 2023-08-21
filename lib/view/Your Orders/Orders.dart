import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stitch_craft/View%20Model/Receipt/receipt_function.dart';
import 'package:stitch_craft/View%20Model/Services/sessionManager.dart';
import 'package:stitch_craft/res/color.dart';
import 'package:stitch_craft/view/Home/Components/tailor_heading.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  ReceiptFunctions receipt = ReceiptFunctions();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const TailorHeading(
            title: "Your Orders",
            color: AppColors.primaryColor,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(SessionController().userID.toString())
                  .collection('Receipt')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final receipt = snapshot.data!.docs[index];
                        return ReceiptGeneration(receipt: receipt);
                      },
                    );
                  } else {
                    return const Text("No Receipt found");
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
        ],
      ),
    );
  }
}

class ReceiptGeneration extends StatelessWidget {
  const ReceiptGeneration({
    super.key,
    required this.receipt,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> receipt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        bottom: 20,
        left: 20,
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Receipt",
                style: GoogleFonts.dmSerifDisplay(fontSize: 25),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Tailor Information",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.primaryColor),
            ),
            const SizedBox(height: 10),
            ReuseableRow(detail: "${receipt['tailorname']}", title: "Name"),
            ReuseableRow(detail: "${receipt['tailoremail']}", title: "Email:"),
            ReuseableRow(
                detail: "${receipt['tailorlocation']}", title: "Location:"),
            const SizedBox(height: 20),
            const Text(
              "User Information",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.primaryColor),
            ),
            const SizedBox(height: 10),
            ReuseableRow(title: "Name:", detail: "${receipt['username']}"),
            ReuseableRow(detail: "${receipt['userage']}", title: "Age: "),
            ReuseableRow(detail: "${receipt['useremail']}", title: "Email"),
            const SizedBox(height: 10),
            const Text(
              "Details:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.primaryColor),
            ),
            const SizedBox(height: 10),
            Text("${receipt['userdetails']}"),
            const SizedBox(height: 10),
            const Text(
              "Total Price:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.primaryColor),
            ),
            Text(" Rs ${receipt['total']}"),
          ],
        ),
      ),
    );
  }

  Row ReuseableRow({required String detail, required String title}) => Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(width: 5),
          Text(
            detail,
            style: const TextStyle(fontSize: 15),
          )
        ],
      );
}
