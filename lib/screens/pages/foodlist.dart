import 'package:araigordaiwithme/screens/pages/userpage.dart';
import 'package:araigordaiwithme/screens/welcome_page/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodList extends StatefulWidget {
  const FoodList({super.key});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
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
        title: SearchField(),
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
                        size: 44,
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
                      size: 44,
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
      body: Center(child: Text('Food Page')),
      backgroundColor: kBackgroundColor,
    );
  }
}

class SearchField extends StatelessWidget {
  SearchField({super.key});
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onChanged: (value) {
          // Perform search functionality here
        },
      ),
    );
  }
}
