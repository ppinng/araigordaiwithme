import 'dart:ffi';

import 'package:araigordaiwithme/screens/pages/detail.dart';
import 'package:araigordaiwithme/screens/pages/search.dart';
import 'package:araigordaiwithme/screens/pages/userpage.dart';
import 'package:araigordaiwithme/screens/welcome_page/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/Tag_button.dart';
import '../../components/menu_bar.dart';
import '../../components/random.dart';

class FoodList extends StatelessWidget {
  // Color _iconColor = Colors.grey;

  // void _handleTap() {
  //   setState(() {
  //     _iconColor = Color.fromARGB(255, 243, 33, 33);
  //   });
  // }

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
            icon: CircleAvatar(backgroundImage: AssetImage("images/user.jpg")),
          ),
        ],
      ),
      drawer: const DrawerBar(),
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Food').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      MyButtonLayout(),
                      RandomButton(),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshots.data!.docs.length - 1,
                          itemBuilder: (context, index) {
                            var data = snapshots.data!.docs[index].data()
                                as Map<String, dynamic>;
                            return Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    if (user != null) {
                                      final viewAt = Timestamp.now();
                                      final foodId =
                                          snapshots.data!.docs[index].id;
                                      final viewHistoryRef = FirebaseFirestore
                                          .instance
                                          .collection('ViewHistory');
                                      await viewHistoryRef.add({
                                        'uid': user.uid,
                                        'foodid': foodId,
                                        'viewat': viewAt,
                                      });
                                    }

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => FoodDetail(
                                          documentId:
                                              snapshots.data!.docs[index].id,
                                        ),
                                      ),
                                    );
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
                                          //Food image
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Image.network(
                                                data['image'],
                                                height: 75,
                                                width: 100,
                                                colorBlendMode:
                                                    BlendMode.darken,
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
                                                    data['name'],
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
                                                    'Calories: ${data['calories']}',
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
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
          }),
    );
  }

  // void setState(Null Function() param0) {}
}

class SearchField extends StatefulWidget {
  SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: TextField(
        readOnly: true,
        controller: _searchController,
        autofocus: false,
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
          hintText: 'Search',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Search()));
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

  CollectionReference food = FirebaseFirestore.instance.collection('Food');
  CollectionReference foodJoin = FirebaseFirestore.instance.collection('Food');

  Future updateFavorite() {
    return food.doc('5bddBd4Znc1lKI1n5KrN').update({'favorite': !isFavorite});
  }

  List<String> favoriteStatus = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Food')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              // print(document.reference);
              favoriteStatus.add(document.reference.id);
            }));
  }

  // @override
  // void initState() {
  //   getDocId();
  //   super.initState();
  // }

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
                  updateFavorite();
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
