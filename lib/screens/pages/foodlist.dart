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
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: IconButton(
              onPressed: () {
                // Navigator.of(context).pop(); //Change to pop hamburger
              },
              icon: const FaIcon(
                FontAwesomeIcons.bars,
                color: Colors.black,
                size: 26,
              )),
        ),
      ),
      body: Center(child: Text('Food Page')),
      backgroundColor: kBackgroundColor,
    );
  }
}
