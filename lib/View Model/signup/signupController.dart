import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:stitch_craft/routes/utils.dart';
import 'package:stitch_craft/view/Home/homepage.dart';

import '../Services/sessionManager.dart';

class SignUpController extends ChangeNotifier {
  FocusNode emailFocusNode = FocusNode();

  TextEditingController usernameController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void signUp(String username, String email, String password,
      BuildContext context) async {
    setLoading(true);
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      setLoading(false);

      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'username': usernameController.text,
        'email': emailController.text
      });

      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Homepage(),
          ));

      // * After creating the Account we need to set Firebase database for the current user

      SessionController().userID = userCredential.user!.uid.toString();
    } on FirebaseException catch (e) {
      setLoading(false);
      Utils.toastmessage(e.toString());
    }
  }
}
