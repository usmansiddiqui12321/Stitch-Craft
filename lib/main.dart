import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stitch_craft/Theme/light_theme.dart';
import 'package:stitch_craft/firebase_options.dart';
import 'package:stitch_craft/routes/route_name.dart';
import 'package:stitch_craft/routes/routes.dart';
import 'package:stitch_craft/view/splash_screen.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Hide the navigation bar, but keep the status bar (notification bar)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: SplashScreen(),
      initialRoute: Routename.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
