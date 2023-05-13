import 'package:araigordaiwithme/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotMain extends StatefulWidget {
  const ForgotMain({super.key});

  @override
  State<ForgotMain> createState() => _ForgotMainState();
}

class _ForgotMainState extends State<ForgotMain> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Password reset link sent! Check your email"),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      switch (e.code) {
        case "unknown":
          {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: kBoxColor,
                content: Text(
                  "Please enter your email",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          break;
        case "user-not-found":
          {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: kBoxColor,
                content: Text(
                  "This user does not exist",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          break;
        case "invalid-email":
          {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: kBoxColor,
                content: Text(
                  "Please enter a valid email",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          break;
        default:
          {}
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black,
              size: 26,
            ),
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset('images/forgot.png'),
            ),
            Container(
              child: const Text(
                'Reset password',
                style: TextStyle(
                    color: kAppColor,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 18, 32, 0),
              child: Container(
                decoration: BoxDecoration(
                    color: kTextFieldColor,
                    borderRadius: BorderRadius.circular(50.0)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Email',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: SizedBox(
                width: 160,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: kButtonColor,
                      shadowColor: Colors.black,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: passwordReset,
                  child: const Text(style: TextStyle(fontSize: 20), "Next"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
