import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stitch_craft/routes/route_name.dart';
import 'package:stitch_craft/routes/utils.dart';
import '../Services/sessionManager.dart';

class LoginController extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(String email, String password, BuildContext context) async {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                SessionController().userID = value.user!.uid.toString(),
                setLoading(false),
                Navigator.pushNamed(context, Routename.homepage)
              })
          .onError((error, stackTrace) =>
              {setLoading(false), Utils.toastmessage(error.toString())});
    } catch (e) {
      setLoading(false);

      Utils.toastmessage(e.toString());
    }
  }

  void logout(BuildContext context) async {
    try {
      auth.signOut().then((value) => {
            SessionController().userID = '',
            Navigator.pushNamed(context, Routename.loginScreen)
          });
    } catch (e) {
      print("Some Error Occurred");
    }
  }
}
