import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stitch_craft/View%20Model/login/loginController.dart';
import 'package:stitch_craft/Widgets/RoundButton.dart';
import 'package:stitch_craft/Widgets/custom_form_field.dart';
import 'package:stitch_craft/routes/route_name.dart';
import 'package:stitch_craft/routes/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DateTime? _lastPressedAt;

  final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    passwordController.dispose();
  }

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) >
                const Duration(seconds: 1)) {
          // show toast message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Press back again to exit"),
            ),
          );

          // save the current time
          _lastPressedAt = DateTime.now();
          return false;
        } else {
          // close the app
          await SystemNavigator.pop();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/loginimage.png"),
                  SizedBox(height: size.height * .03),
                  Text(
                    "WelCome to\n Stitch Craft",
                    style: GoogleFonts.dmSerifDisplay(
                        fontSize: 44, color: const Color.fromARGB(255, 138, 60, 55)),
                  ),
                  SizedBox(height: size.height * .01),
                  Text(
                    "Enter your Email Address\nto Login to your Account",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSerifDisplay(
                        fontSize: 20, color: const Color.fromARGB(255, 138, 60, 55)),
                  ),
                  SizedBox(height: size.height * .01),
                  Form(
                    key: formkey,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * .06),
                      child: Column(
                        children: [
                          CustomFormField(
                            onChanged: (value) {},
                            controller: emailController,
                            onFieldSubmitted: (value) {
                              Utils.fieldfoucs(
                                  context, emailFocusNode, passwordFocusNode);
                            },
                            enabledBorderColor:
                                Colors.white,
                        
                            focusNode: emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                            label: "Email",
                            hint: "Enter Email",
                            prefixIcon: Icons.email_outlined,
                            validator: (value) {
                              return value.isEmpty ? 'Enter Email' : null;
                            },
                          ),
                          SizedBox(height: size.height * .01),
                          CustomFormField(
                            onFieldSubmitted: (value) {},
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            keyboardType: TextInputType.visiblePassword,
                            inputAction: TextInputAction.done,
                            enabledBorderColor:
                                const Color.fromARGB(255, 138, 60, 55),
                            isObscure: true,
                            prefixIcon: Icons.lock_open_rounded,
                            onChanged: (value) {},
                            label: "Password",
                            hint: "Enter Password",
                            validator: (value) {
                              return value.isEmpty ? 'Enter Email' : null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routename.forgotScreen);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                                color: const Color.fromARGB(255, 138, 60, 55)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => LoginController(),
                    child: Consumer<LoginController>(
                      builder: (context, provider, child) {
                        return RoundButton(
                          loading: provider.loading,
                          onpress: () {
                            if (formkey.currentState!.validate()) {
                              provider.login(emailController.text,
                                  passwordController.text, context);
                            }
                          },
                          title: "Login",
                          buttonColor: const Color.fromARGB(255, 138, 60, 55),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont have an Account",
                        style:
                            TextStyle(color: Color.fromARGB(255, 138, 60, 55)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routename.signUp);
                        },
                        child: Text(
                          "Sign Up",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontSize: 15,
                                  color: const Color.fromARGB(255, 138, 60, 55),
                                  decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
