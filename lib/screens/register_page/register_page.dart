import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constant.dart';
import '../more_info_page/more_info.dart';

class SignupScreen extends HookWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmpasswordController = useTextEditingController();

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
              )),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("images/register_logo.png"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Text('Register',
                    style: TextStyle(
                        color: kAppColor,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold)),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: kBoxColor,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide.none),
                                hintText: 'E-mail',
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 12.0, bottom: 3),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                  return 'Please enter correct email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32, 18, 32, 0),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: kBoxColor,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide.none),
                                hintText: 'Password',
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 12.0, bottom: 3),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 5),
                              ),
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter some text';
                              //   }
                              //   if (value.length < 6) {
                              //     return "Password must be at least 6 characters";
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32, 18, 32, 10),
                            child: TextFormField(
                              controller: confirmpasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: kBoxColor,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide.none),
                                hintText: 'Confirm Password',
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 12.0, bottom: 3),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                              ),
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter some text';
                              //   }
                              //   if (passwordController.text !=
                              //       confirmpasswordController.text) {
                              //     return "Password does not match";
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        child: const Text(
                          'Next',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (passwordController.text ==
                                confirmpasswordController.text) {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                print('Create account');
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const MoreInfo(),
                                  ),
                                );
                              });
                              
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: kButtonColor,
                                      content:
                                          Text('Password does not match')));
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ); 
  }

}
