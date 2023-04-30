import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
//import screens
import 'package:araigordaiwithme/screens/register_page/register_page.dart';
import 'package:araigordaiwithme/screens/login_page/login_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: size.width,
                height: 200,
                child: Image.asset("images/AppLogo.png")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                    },
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
