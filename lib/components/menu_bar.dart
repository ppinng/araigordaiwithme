import 'package:araigordaiwithme/constant.dart';
import 'package:araigordaiwithme/services/firebase_services.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 14, 0),
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset("images/AppLogo.png"),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      onPressed: () async {
                        await FirebaseServices().signOut();
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName('/'));
                        // FirebaseAuth.instance.signOut().then((value) {
                        //   print('Signed out');
                        //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const WelcomeScreen()),(route) => false)))
                        //   // Navigator.of(context)
                        //   //     .popUntil(ModalRoute.withName('/'));
                        // });
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
