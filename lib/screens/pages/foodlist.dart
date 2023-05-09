import 'package:araigordaiwithme/screens/pages/userpage.dart';
import 'package:araigordaiwithme/screens/welcome_page/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/Tag_button.dart';
import '../../components/menu_bar.dart';
import '../../components/random.dart';

class Menu {
  final int id;
  final String name;
  final String image;
  final int calories;
  final double price;
  final String location;

  Menu(
      {required this.id,
      required this.name,
      required this.image,
      required this.calories,
      required this.price,
      required this.location});
}

class FoodList extends StatelessWidget {
  // Color _iconColor = Colors.grey;

  // void _handleTap() {
  //   setState(() {
  //     _iconColor = Color.fromARGB(255, 243, 33, 33);
  //   });
  // }

  final List<Menu> menus = [
    Menu(
        id: 1,
        name: 'Spicy fried chicken with basil leaves',
        image: 'images/krapao.png',
        calories: 250,
        price: 10.99,
        location: 'New York'),
    Menu(
        id: 2,
        name: 'Spicy Chicken Wings',
        image: 'images/wingsaps.png',
        calories: 350,
        price: 14.99,
        location: 'Los Angeles'),
    Menu(
        id: 3,
        name: 'Grilled Chicken',
        image: 'images/kaiyang.png',
        calories: 450,
        price: 19.99,
        location: 'Chicago'),
    Menu(
        id: 4,
        name: 'Chicken rice ',
        image: 'images/kaowmungai.png',
        calories: 550,
        price: 24.99,
        location: 'Houston'),
    Menu(
        id: 5,
        name: 'Papaya Salad',
        image: 'images/papayasalad.png',
        calories: 650,
        price: 29.99,
        location: 'Miami'),
  ];

  // FoodList({super.key});
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black, size: 38),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: kBackgroundColor,
          ),
        ),
        title: SearchField(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const UserPage()));
            },
            icon: Image.asset("images/forgot.png"),
          ),
        ],
      ),
      drawer: const DrawerBar(),
      backgroundColor: kBackgroundColor,
      body: Column(
        //
        children: [
          MyButtonLayout(),
          // RandomButton(
          //   menus: [],
          // ),

          RandomButton(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menus.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      width: 348,
                      height: 100,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            //Food image
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Image.asset(
                                  menus[index].image,
                                  height: 75,
                                  width: 100,
                                  colorBlendMode: BlendMode.darken,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              //Food Name
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      menus[index].name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    //Food Calories
                                    Text(
                                      'Calories: ${menus[index].calories}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          //Grey Box bottom right
                          const FavoriteButton(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // void setState(Null Function() param0) {}
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
            borderSide: const BorderSide(width: 2, color: Colors.grey),
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

//favorite heart in grey box
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15),
              ),
            ),
            child: IconButton(
              alignment: Alignment.center,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite,
                size: 20,
                color: isFavorite ? Colors.red : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
                if (isFavorite == true) {
                  print('Add to Favorite');
                } else {
                  print('Remove from Favorite');
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
