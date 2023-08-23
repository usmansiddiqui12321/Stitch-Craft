import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Discount with ChangeNotifier {
  bool _isAvailed = false;
  bool get isAvailed => _isAvailed;

  void setisAvailed() {
    _isAvailed = true;
    notifyListeners();
  }

  Future<void> setvalue() async {
    // Update the local value first
    setisAvailed();

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
        {
          'isAvailed': _isAvailed,
        },
        SetOptions(merge: true), // Use merge option to update only the specific field
      );
    } catch (error) {
      // Handle error
    }
  }


 Future<bool> getvalue() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

      if (userData != null && userData.containsKey('isAvailed')) {
        return userData['isAvailed'] as bool;
      } else {
        return false; // Default value if 'isAvailed' is not found
      }
    } catch (error) {
      // Handle error
      return false; // Default value if an error occurs
    }
  }
}
