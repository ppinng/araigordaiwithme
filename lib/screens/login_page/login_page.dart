import 'package:araigordaiwithme/constant.dart';
import 'package:araigordaiwithme/screens/more_info_page/more_info.dart';
import 'package:araigordaiwithme/screens/register_page/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Home_page/home_page.dart';
import '../forgotpassword_page/forgot_page.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final Size size = MediaQuery.of(context).size;

    Future<User> handleSignInEmail(String email, String password) async {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;

      return user;
    }

    Future googleSignIn() async {
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential user = await auth.signInWithCredential(credential);
        if (user.additionalUserInfo!.isNewUser) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MoreInfo()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: kButtonColor,
              content: Text(
                  'The account already exists with a different credential.')));
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: kButtonColor,
              content: Text(
                  'Error occurred while accessing credentials. Try again.')));
        } else if (e.code == GoogleSignIn.kNetworkError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: kButtonColor,
              content: Text(
                  'A network error (such as timeout, interrupted connection or unreachable host) has occurred.')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: kButtonColor,
              content: Text('Something went wrong.')));
        }
      }
    }

    return Scaffold(
      key: UniqueKey(),
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
      body: SingleChildScrollView(
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
                  child: Column(
                    children: [
                      Form(
                        key: keyForm,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFormField(
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
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: kBoxColor,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide.none),
                                    hintText: 'Password',
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.0, right: 12.0, bottom: 3),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotMain()));
                                },
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return kBackgroundColor;
                                    },
                                  ),
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: kButtonColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                              if (keyForm.currentState!.validate()) {
                                handleSignInEmail(emailController.text,
                                        passwordController.text)
                                    .then((User user) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()));
                                }).catchError((e) async {
                                  return await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: kBoxColor,
                                      title: const Text(
                                        "Sign in failed",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      content: const Text(
                                        "Please check your email and password",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              "OK",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.green),
                                            ))
                                      ],
                                    ),
                                  );
                                });
                              }
                            }),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignupScreen()));
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return kBackgroundColor;
                                },
                              ),
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: const Text(
                              'Create one',
                              style: TextStyle(
                                fontSize: 16,
                                color: kButtonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text('OR',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                      ),
                      SizedBox(
                        width: 255,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kButtonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              googleSignIn();
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 40,
                                    height: 40,
                                    child:
                                        Image.asset("images/google_logo.png")),
                                const Text(
                                  'Sign in with Google',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
