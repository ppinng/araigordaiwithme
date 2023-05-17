import 'package:araigordaiwithme/screens/pages/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant.dart';

class FoodDetail extends StatelessWidget {
  FoodDetail({super.key, required this.documentId});
  bool isFavorite = false;
  final String assetName = 'images/notfound23.svg';
  final firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final String documentId;

  Widget buildFavoriteButton(String foodId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Favorites')
          .where('uid', isEqualTo: userId)
          .where('foodid', isEqualTo: foodId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          // Item is in favorites
          return IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.favorite,
              size: 30,
              color: Colors.red,
            ),
            onPressed: () async {
              // Remove the item from favorites
              final docId = snapshot.data!.docs[0].id;
              await FirebaseFirestore.instance
                  .collection('Favorites')
                  .doc(docId)
                  .delete();
              print('Removed from favorites');
            },
          );
        } else {
          // Item is not in favorites
          return IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.favorite_outline,
              size: 30,
              color: Colors.grey,
            ),
            onPressed: () async {
              // Add the item to favorites
              await FirebaseFirestore.instance.collection('Favorites').add({
                'uid': userId,
                'foodid': foodId,
              });
              print('Added to favorites');
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference food = FirebaseFirestore.instance.collection('Food');
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black,
              size: 26,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DocumentSnapshot>(
          future: food.doc(documentId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              String foodId =
                  snapshot.data!.id; // Obtaining foodId from the snapshot
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.network(
                        data['image'],
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: kBackgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "${data['name']}",
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                          ),
                          buildFavoriteButton(foodId),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    color: kBackgroundColor,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                ),
                                Text(
                                  "${data['canteen']}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.store_mall_directory,
                                  color: kButtonColor,
                                ),
                                Text(
                                  "${data['stall']}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.local_fire_department_sharp,
                              color: Colors.red,
                            ),
                            Text(
                              "${data['calories']} Kcal",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
