import 'package:araigordaiwithme/components/menu_bar.dart';
import 'package:araigordaiwithme/screens/pages/userpage.dart';
import 'package:araigordaiwithme/screens/welcome_page/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool isFavorite = false;
  final String assetName = 'images/notfound23.svg';
  final firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

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
            icon: Container(
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('UsersInfo')
                    .doc(userId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.data() == null) {
                    return CircularProgressIndicator();
                  }
                  final userImage = (snapshot.data!.data()
                      as Map<String, dynamic>)['userimage'];
                  if (userImage is String) {
                    return CircleAvatar(
                      backgroundColor: kBoxColor,
                      foregroundImage: NetworkImage(userImage),
                      child: const Icon(
                        Icons.person,
                        color: kButtonColor,
                      ),
                    );
                  } else {
                    return const CircleAvatar(
                      backgroundColor: kBoxColor,
                      foregroundImage: AssetImage("images/user.jpg"),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      drawer: const DrawerBar(),
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Favorites')
            .where('uid', isEqualTo: userId) // Filter by current user's UID
            .snapshots(),
        builder: (context, favoritesSnapshot) {
          if (favoritesSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!favoritesSnapshot.hasData ||
              favoritesSnapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 250,
                      height: 250,
                      child: SvgPicture.asset(assetName)),
                  const Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Not Found',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ))
                ],
              ),
            );
          }

          final favoriteDocs = favoritesSnapshot.data!.docs;
          final foodIds = favoriteDocs.map((doc) => doc['foodid']).toList();

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Food')
                .where(FieldPath.documentId,
                    whereIn: foodIds) // Filter by foodIds
                .snapshots(),
            builder: (context, foodSnapshot) {
              if (foodSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final foodDocs = foodSnapshot.data!.docs;

              return Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: favoriteDocs.length,
                      itemBuilder: (context, index) {
                        final viewHistoryData =
                            favoriteDocs[index].data() as Map<String, dynamic>;
                        final foodId = viewHistoryData['foodid'];
                        final foodDoc =
                            foodDocs.firstWhere((doc) => doc.id == foodId);
                        final foodData = foodDoc.data() as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () async {
                            if (foodData != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FoodDetail(documentId: foodDoc.id),
                                ),
                              );

                              final user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                final foodId = foodDoc.id;
                                final viewHistoryRef = FirebaseFirestore
                                    .instance
                                    .collection('ViewHistory');
                                final querySnapshot = await viewHistoryRef
                                    .where('uid', isEqualTo: user.uid)
                                    .where('foodid', isEqualTo: foodId)
                                    .get();
                                if (querySnapshot.docs.isNotEmpty) {
                                  final documentId = querySnapshot.docs[0].id;
                                  await viewHistoryRef.doc(documentId).update({
                                    'viewat': Timestamp.now(),
                                  });
                                } else {
                                  final viewAt = Timestamp.now();
                                  await viewHistoryRef.add({
                                    'uid': user.uid,
                                    'foodid': foodId,
                                    'viewat': viewAt,
                                  });
                                }
                              }
                            }
                          },
                          child: Container(
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
                                  children: [
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
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            foodData['name'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
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
                                // const FavoriteButton(),
                                Stack(
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
                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('Favorites')
                                              .where('uid', isEqualTo: userId)
                                              .where('foodid',
                                                  isEqualTo: foodId)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                snapshot
                                                    .data!.docs.isNotEmpty) {
                                              // Item is in favorites
                                              return IconButton(
                                                alignment: Alignment.center,
                                                icon: const Icon(
                                                  Icons.favorite,
                                                  size: 20,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () async {
                                                  // Remove the item from favorites
                                                  final docId =
                                                      snapshot.data!.docs[0].id;
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Favorites')
                                                      .doc(docId)
                                                      .delete();
                                                  print(
                                                      'Removed from favorites');
                                                },
                                              );
                                            } else {
                                              // Item is not in favorites
                                              return IconButton(
                                                alignment: Alignment.center,
                                                icon: const Icon(
                                                  Icons.favorite,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () async {
                                                  // Add the item to favorites
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Favorites')
                                                      .add({
                                                    'uid': userId,
                                                    'foodid': foodId,
                                                  });
                                                  print('Added to favorites');
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
