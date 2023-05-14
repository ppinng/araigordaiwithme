import 'package:araigordaiwithme/components/menu_bar.dart';
import 'package:araigordaiwithme/screens/pages/userpage.dart';
import 'package:araigordaiwithme/screens/welcome_page/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
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
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const UserPage()),
              );
            },
            icon: Image.asset("images/forgot.png"),
          ),
        ],
      ),
      drawer: const DrawerBar(),
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Food').snapshots(),
        builder: (context, foodSnapshots) {
          if (foodSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Favorites')
                  .snapshots(),
              builder: (context, favoritesSnapshots) {
                if (favoritesSnapshots.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // Get a list of favorite food ids
                  final List<int> favoriteFoodIds = favoritesSnapshots
                      .data!.docs
                      .map((doc) => doc['foodid'] as int)
                      .toList();

                  // Filter the food snapshots based on favorite food ids
                  final List<QueryDocumentSnapshot> filteredFoodSnapshots =
                      foodSnapshots.data!.docs
                          .where(
                              (doc) => favoriteFoodIds.contains(doc['foodid']))
                          .toList();

                  return ListView.builder(
                    itemCount: filteredFoodSnapshots.length,
                    itemBuilder: (BuildContext context, int index) {
                      var foodData = filteredFoodSnapshots[index].data()
                          as Map<String, dynamic>;

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
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Image.network(
                                        foodData['image'],
                                        height: 75,
                                        width: 100,
                                        colorBlendMode: BlendMode.darken,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    //Food Name
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            foodData['name'],
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
                                            'Calories: ${foodData['calories']}',
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
                  );
                }
              },
            );
          }
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

  Future<bool> checkIfFavorite(String foodId) async {
    // Replace 'YOUR_COLLECTION_NAME' with the actual collection name in Firebase
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('YOUR_COLLECTION_NAME')
        .where('foodId', isEqualTo: foodId)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final String foodId = ''; // Add the foodId here for comparison

    return FutureBuilder<bool>(
      future: checkIfFavorite(foodId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data == true) {
          return buildFavoriteButton(true);
        } else {
          return buildFavoriteButton(false);
        }
      },
    );
  }

  Widget buildFavoriteButton(bool isFavorite) {
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
                color: isFavorite ? Colors.white : Colors.red,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
                if (isFavorite) {
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
