import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stitch_craft/View%20Model/Services/sessionManager.dart';
import 'package:stitch_craft/res/color.dart';
import 'package:stitch_craft/view/ListOfTailorPage/list_of_tailor_page.dart';
import 'package:stitch_craft/view/Your%20Orders/Orders.dart';
import 'package:stitch_craft/view/login/login_screen.dart'; 

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  Future<String?> getUsername() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(SessionController().userID)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;
        if (userData != null && userData.containsKey('username')) {
          return userData['username'];
        }
      }
      return null; // User or username not found
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving username: $e');
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;
    FirebaseAuth logout = FirebaseAuth.instance;

    return Drawer(
      child: Container(
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              FutureBuilder(
                future: getUsername(),
                builder: (context, snapshot) {
                  return UserAccountsDrawerHeader(
                    accountName: Text(snapshot.data.toString()),
                    accountEmail: Text(auth!.email.toString()),
                    currentAccountPicture: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors
                          .transparent, // Transparent background for header
                    ),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Handle navigation to home
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.auto_graph_rounded, color: Colors.white),
                title: const Text(
                  "Best sellers",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListOfTailorPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_shopping_cart_outlined,
                    color: Colors.white),
                title: const Text(
                  "Your Orders",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderList()));
                },
              ),
              const Divider(color: Colors.white), // Divider with white color
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Handle logout
                  logout.signOut().then((value) {
                    SessionController().userID = '';
                    SessionController().userName = '';
                  }).then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
