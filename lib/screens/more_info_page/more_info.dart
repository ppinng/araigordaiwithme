import 'package:araigordaiwithme/models/model_userinfo.dart';
import 'package:araigordaiwithme/screens/Home_page/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../constant.dart';

//Animal class
class Food {
  final int id;
  final String name;

  Food({
    required this.id,
    required this.name,
  });
}

class MoreInfo extends StatefulWidget {
  const MoreInfo({super.key});

  @override
  State<MoreInfo> createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  static final List<Food> _foods = [
    Food(id: 1, name: "Egg"),
    Food(id: 2, name: "Fish"),
    Food(id: 3, name: "Pork"),
    Food(id: 4, name: "Beef"),
    Food(id: 5, name: "Shrimp"),
    Food(id: 6, name: "Crab"),
    Food(id: 7, name: "Squid"),
    Food(id: 8, name: "Nuts"),
    Food(id: 9, name: "Wheat"),
  ];
  final _items =
      _foods.map((food) => MultiSelectItem<Food>(food, food.name)).toList();
  List<Food> _selectedFoods = [];
  final CollectionReference _usersInfo =
      FirebaseFirestore.instance.collection('UsersInfo');
  final users = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    _selectedFoods = _foods;
    super.initState();
  }

  final controllerAge = TextEditingController();
  final controllerHeight = TextEditingController();
  final controllerWeight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.black,
                size: 26,
              )),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(25),
                  child: Text('Let us know more about you',
                      style: TextStyle(
                        color: kAppColor,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: controllerAge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      label: const Text("Age"),
                      filled: true,
                      fillColor: kBoxColor,
                      hintText: "Age", //insert this value from firebase
                      suffixIcon: const Icon(Icons.edit),
                      suffixIconColor: kBoxColor,
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: controllerHeight,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: kBoxColor,
                      hintText: "Height", //insert this value from firebase
                      suffixIcon: const Icon(Icons.edit),
                      suffixIconColor: kBoxColor,
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: controllerWeight,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: kBoxColor,
                      hintText: "Weight", //insert this value from firebase
                      suffixIcon: const Icon(Icons.edit),
                      suffixIconColor: kBoxColor,
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: multiSelect(), //Widget
                ),
                const SizedBox(
                  height: 20,
                ),
                //Confirm button
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: kButtonColor,
                        shadowColor: Colors.black,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      final users = FirebaseAuth.instance.currentUser;
                      final usersInfo = Usersinformation(
                        uid: users!.uid,
                        email: users.email!,
                        age: int.parse(controllerAge.text),
                        height: int.parse(controllerHeight.text),
                        weight: int.parse(controllerWeight.text),
                        foods: _selectedFoods.map((food) => food.name).toList(),
                      );

                      await usersInfo.addUserInformationToFirestore();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const HomePage())); // need to change to more info page
                    },
                    child: const Text(
                      'Finish',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> addUserInformationToFirestore() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   final CollectionReference usersInfo =
  //       FirebaseFirestore.instance.collection('UsersInfo');
  //   final Map<String, dynamic> userInfo = {
  //     'uid': user?.uid,
  //     'email': user?.email,
  //     'age': int.parse(controllerAge.text),
  //     'height': int.parse(controllerHeight.text),
  //     'weight': int.parse(controllerWeight.text),
  //     'foods': _selectedFoods.map((food) => food.name).toList(),
  //   };
  //   await usersInfo.doc(user!.uid).set(userInfo);
  // }

  //Mulitple selection Food
  Widget multiSelect() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: kBoxColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: MultiSelectDialogField(
            dialogWidth: 10,
            title: const Text("Allergic food"),
            decoration: BoxDecoration(
              color: kBoxColor,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: kBoxColor,
                width: 2,
              ),
            ),
            selectedColor: kButtonColor,
            selectedItemsTextStyle:
                const TextStyle(color: kDefaultIconLightColor),
            buttonText: const Text(
              "Select your Allergic food",
              style: TextStyle(color: kDefaultIconDarkColor, fontSize: 16),
            ),
            buttonIcon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: kDefaultIconDarkColor,
            ),
            listType: MultiSelectListType.CHIP,
            unselectedColor: kBackgroundColor,
            backgroundColor: kBoxColor,
            items: _foods.map((e) => MultiSelectItem(e, e.name)).toList(),
            onConfirm: (values) {
              _selectedFoods = values;
              print(_selectedFoods.map((food) => food.name).toList());
            },
            chipDisplay: MultiSelectChipDisplay(
              items: _selectedFoods
                  .map((e) => MultiSelectItem(e, e.name))
                  .toList(),
              onTap: (value) {
                setState(() {
                  _selectedFoods.remove(value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
