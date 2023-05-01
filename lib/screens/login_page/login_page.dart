// Add GoRouter configuration outside the App class
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../Home_page/home_page.dart';

import 'package:araigordaiwithme/constant.dart';
import 'package:araigordaiwithme/screens/register_page/register_page.dart';
import 'package:araigordaiwithme/screens/welcome_page/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../forgotpassword_page/forgot_page.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();
    final email = useState('');
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: SizedBox(
                    width: size.width,
                    height: 200,
                    child: Image.asset("images/AppLogo.png")),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Text('Arai Gor Dai.',
                    style: TextStyle(
                        color: kAppColor,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold)),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                    child: TextFormField(
                      controller: _emailController,
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
                      onChanged: (value) => email.value = value,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter some text';
                      //   }
                      //   bool emailValid = RegExp(
                      //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      //       .hasMatch(value);

                      //   if (!emailValid) {
                      //     return 'Please enter a valid email';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 18, 32, 0),
                    child: TextFormField(
                      controller: _passwordController,
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
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const forgotMain()));
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return kBackgroundColor;
                        },
                      ),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 32, 0),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 15,
                          color: kButtonColor,
                        ),
                      ),
                    ),
                  ),
                  // RichText(
                  //     text: const TextSpan(
                  //         text: 'Forgot Password?',
                  //         style: TextStyle(
                  //           decoration: TextDecoration.underline,
                  //           decorationThickness: 2,
                  //           color: kButtonColor,
                  //           fontSize: 14,

                  //         )),

                  //         ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
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
                              'Sign In',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const WelcomeScreen()));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 9),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black)),
                                TextSpan(
                                    text: 'Create one',
                                    style: const TextStyle(
                                        fontSize: 16, color: kButtonColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignupScreen()));
                                      })
                              ],
                            ),
                          ),
                        ),
                        const Text('OR',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        SizedBox(
                          width: 250,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kButtonColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                signInWithGoogle();
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                          "images/google_logo.png")),
                                  const Text(
                                    'Login with Google',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),

                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  //     child: RichText(
                  //       text: TextSpan(
                  //         children: <TextSpan>[
                  //           const TextSpan(
                  //               text: "Don't have an account? ",
                  //               style: TextStyle(
                  //                   fontSize: 15, color: Colors.black)),
                  //           TextSpan(
                  //               text: 'Create one',
                  //               style: const TextStyle(
                  //                   fontSize: 16, color: kButtonColor),
                  //               recognizer: TapGestureRecognizer()
                  //                 ..onTap = () {
                  //                   Navigator.of(context).push(
                  //                       MaterialPageRoute(
                  //                           builder: (context) =>
                  //                               const WelcomeScreen()));
                  //                 })
                  //         ],
                  //       ),
                  //     ),
                  //   ),

                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // debugPrint(userCredential.user?.displayName);
    // Not finish yet
    // if(userCredential.user != null) {
    //   Navigator.of(context).push(
    //                                         MaterialPageRoute(
    //                                             builder: (context) =>
    //                                                  SignupScreen()));
    // }
  }
}



                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       _formKey.currentState!.save();
                  //       print(_emailController.text);
                  //       print(_passwordController.text);
                  //     }
                  //   },
                  //   child: const Text('Save'),
                  // ),