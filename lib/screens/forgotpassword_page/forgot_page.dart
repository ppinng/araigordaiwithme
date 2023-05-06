import 'package:araigordaiwithme/constant.dart';

import 'package:araigordaiwithme/screens/welcome_page/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotMain extends StatelessWidget {
  const ForgotMain({super.key});

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
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 18, 32, 0),
              child: forgotEmail(),
            )
          ],
        ),
      ),
    );
  }
}

class forgotEmail extends StatefulWidget {
  const forgotEmail({super.key});

  @override
  State<forgotEmail> createState() => _forgotEmailState();
}

class _forgotEmailState extends State<forgotEmail> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                  color: kTextFieldColor,
                  borderRadius: BorderRadius.circular(50.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Email',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                      return "Enter Correct Email Address";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   // showDialog(

                      //   // showDialog(
                      //   //     context: context,
                      //   //     builder: (context) {
                      //   //       return AlertDialog(
                      //   //         content: Text("${emailController.text}"),
                      //   //       );
                      //   //     });
                      // }
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const forgotMain2()));
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class forgotMain2 extends StatelessWidget {
  const forgotMain2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
                'New password',
                style: TextStyle(
                    color: kAppColor,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 18, 32, 0),
              child: forgotPassword(),
            )
          ],
        ),
      ),
    );
  }
}

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                  color: kTextFieldColor,
                  borderRadius: BorderRadius.circular(50.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Enter new password',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
                            .hasMatch(value)) {
                      return "Enter Valid Password";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                  color: kTextFieldColor,
                  borderRadius: BorderRadius.circular(50.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: TextFormField(
                  controller: repasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Re-enter new password',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value != passwordController.text) {
                      return "Password does not match";
                    } else {
                      return null;
                    }
                  },
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
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   // showDialog(
                  //   //     context: context,
                  //   //     builder: (context) {
                  //   //       return AlertDialog(
                  //   //         content: Text("${emailController.text}"),
                  //   //       );
                  //   //     });
                  // }
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()));
                },
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value ?? '')) {
    return 'Enter Valid Email';
  } else {
    return null;
  }
}
