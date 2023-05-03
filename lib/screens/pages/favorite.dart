import 'package:araigordaiwithme/screens/pages/userpage.dart';
import 'package:araigordaiwithme/screens/welcome_page/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black, size: 38),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: kBackgroundColor,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Favorite",
              style: TextStyle(color: Colors.black, fontSize: 30),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => UserPage()));
            },
            icon: Image.asset("images/forgot.png"),
          ),
        ],
      ),
      drawer: NavigationDrawer(
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
                        padding: EdgeInsets.only(left: 20),
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
                      padding: EdgeInsets.only(left: 20),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const WelcomeScreen()));
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
      ),
      backgroundColor: kBackgroundColor,
      body: Container(child: Text("test")),
    );
  }
}
