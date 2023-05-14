import 'package:araigordaiwithme/screens/pages/detail.dart';
import 'package:araigordaiwithme/screens/pages/search.dart';
import 'package:araigordaiwithme/screens/pages/userpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../components/Tag_button.dart';
import '../../components/menu_bar.dart';
import '../../components/random.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodList extends HookWidget {
  bool isFavorite = false;
  final String assetName = 'images/notfound23.svg';
  FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    final filteredLocation = useState('');
    final filteredFoodType = useState('');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black, size: 38),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: kBackgroundColor,
          ),
        ),
        title: const SearchField(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const UserPage()));
            },
            icon: const CircleAvatar(
                backgroundImage: AssetImage("images/user.jpg")),
          ),
        ],
      ),
      drawer: const DrawerBar(),
      backgroundColor: kBackgroundColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Food').snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final snapshotData = snapshots.data!.docs;
            List<Map<String, dynamic>> filteredData = [];
            if (filteredLocation.value.isEmpty &&
                filteredFoodType.value.isEmpty) {
              filteredData = snapshotData
                  .map((e) => e.data() as Map<String, dynamic>)
                  .toList();
            } else if (filteredLocation.value.isNotEmpty) {
              filteredData = snapshotData
                  .where((e) =>
                      (e.data() as Map<String, dynamic>)['canteen'] ==
                      filteredLocation.value)
                  .map((e) => e.data() as Map<String, dynamic>)
                  .toList();
              if (filteredFoodType.value.isEmpty) {
                filteredData = filteredData;
              } else {
                filteredData = snapshotData
                    .where((e) =>
                        (e.data() as Map<String, dynamic>)['canteen'] ==
                            filteredLocation.value &&
                        e['foodtype'] == filteredFoodType.value)
                    .map((e) => e.data() as Map<String, dynamic>)
                    .toList();
              }
            } else if (filteredLocation.value.isEmpty &&
                filteredFoodType.value.isNotEmpty) {
              filteredData = snapshotData
                  .where((e) =>
                      (e.data() as Map<String, dynamic>)['foodtype'] ==
                      filteredFoodType.value)
                  .map((e) => e.data() as Map<String, dynamic>)
                  .toList();
            }

            return Column(
              children: [
                MyButtonLayout(
                  filteredLocation: filteredLocation.value,
                  filteredFoodType: filteredFoodType.value,
                  onFilteredChange: (String location, String foodType) {
                    filteredLocation.value = location;
                    filteredFoodType.value = foodType;
                  },
                ),
                const RandomButton(),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: filteredData.isEmpty,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Column(
                      children: [
                        SizedBox(
                            width: 250,
                            height: 250,
                            child: SvgPicture.asset(assetName)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      var data = filteredData[index];

                      return Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              final user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                final viewAt = Timestamp.now();
                                final foodId = snapshots.data!.docs[index].id;
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
                                    documentId: snapshots.data!.docs[index].id,
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
}

class SearchField extends StatefulWidget {
  const SearchField({super.key});

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
    return SizedBox(
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
