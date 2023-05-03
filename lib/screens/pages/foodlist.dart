import 'package:araigordaiwithme/screens/pages/userpage.dart';
import 'package:araigordaiwithme/screens/welcome_page/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Menu {
  final String name;
  final String image;
  final int calories;
  final double price;
  final String location;

  Menu(
      {required this.name,
      required this.image,
      required this.calories,
      required this.price,
      required this.location});
}

class FoodList extends StatelessWidget {
  final List<Menu> menus = [
    Menu(
        name: 'Menu 1',
        image: 'images/krapao.png',
        calories: 250,
        price: 10.99,
        location: 'New York'),
    Menu(
        name: 'Menu 2',
        image: 'images/krapao.png',
        calories: 350,
        price: 14.99,
        location: 'Los Angeles'),
    Menu(
        name: 'Menu 3',
        image: 'images/krapao.png',
        calories: 450,
        price: 19.99,
        location: 'Chicago'),
    Menu(
        name: 'Menu 4',
        image: 'images/krapao.png',
        calories: 550,
        price: 24.99,
        location: 'Houston'),
    Menu(
        name: 'Menu 5',
        image: 'images/krapao.png',
        calories: 650,
        price: 29.99,
        location: 'Miami'),
  ];

  FoodList({super.key});

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
      backgroundColor: kBackgroundColor,
      body: ListView.builder(
        itemCount: menus.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Container(
                width: 360,
                height: 100,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: <Widget>[
                    // const SizedBox(width: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Image.asset(
                        menus[index].image,
                        height: 150,
                        width: 100,
                        colorBlendMode: BlendMode.darken,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    // const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          menus[index].name,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Calories: ${menus[index].calories}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        // Text('Price: \฿${menus[index].price.toStringAsFixed(2)}'),
                        // Text('Location: ${menus[index].location}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
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
