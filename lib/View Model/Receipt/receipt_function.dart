import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:stitch_craft/View%20Model/Receipt/receipt_model.dart';
import 'package:stitch_craft/routes/utils.dart';

import '../Services/sessionManager.dart';

class ReceiptFunctions {
  Future<void> addReceipt(Receipt receipt) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(SessionController().userID.toString())
          .collection('Receipt')
          .add(receipt.toJson());
    } on FirebaseException catch (error) {
      Utils.toastmessage(error.toString());
    }
  }

  Future<List<Receipt>> fetchReceipts() async {
    List<Receipt> receipts = [];

    try {
      QuerySnapshot receiptSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(SessionController().userID.toString())
          .collection('Receipt')
          .get();

      for (var receiptDoc in receiptSnapshot.docs) {
        Map<String, dynamic>? receiptData =
            receiptDoc.data() as Map<String, dynamic>?;
        if (receiptData != null) {
          Receipt receipt = Receipt(
            tailorName: receiptData['tailorName'],
            tailorLocation: receiptData['tailorLocation'],
            tailorEmail: receiptData['tailorEmail'],
            username: receiptData['username'],
            userDetails: receiptData['userDetails'],
            userage: receiptData['userage'],
            useremail: receiptData['useremail'],
            totalprice: receiptData['totalprice']
          );
          receipts.add(receipt);
        }
      }

      return receipts;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching receipts: $e');
      }
      return [];
    }
  }
}
