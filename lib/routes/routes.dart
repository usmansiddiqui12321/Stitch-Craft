import 'package:flutter/material.dart';
import 'package:stitch_craft/routes/route_name.dart';
import 'package:stitch_craft/view/ForgotPassword/forget_password.dart';
import 'package:stitch_craft/view/Home/homepage.dart';
import 'package:stitch_craft/view/login/login_screen.dart';
import 'package:stitch_craft/view/signup/sign_up_screen.dart';
import 'package:stitch_craft/view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routename.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case Routename.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routename.signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());

      case Routename.forgotScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case Routename.homepage:
        return MaterialPageRoute(builder: (_) => const Homepage());

      

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
