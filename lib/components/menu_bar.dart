import 'package:araigordaiwithme/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/pages/userpage.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      backgroundColor: kBackgroundColor,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 55, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset("images/forgot.png"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.user,
                      size: 36,
                      color: kBoxColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const UserPage()));
                        },
                        child: const Text(
                          'Profile',
                          style: TextStyle(
                            color: kBoxColor,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.arrowRightFromBracket,
                    size: 36,
                    color: kBoxColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          print('Signed out');
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/'));
                        });
                      },
                      child: const Text(
                        'Log out',
                        style: TextStyle(
                          color: kBoxColor,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
