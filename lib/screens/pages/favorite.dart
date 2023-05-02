import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
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
                //Navigator.of(context).pop();
              },
              icon: const FaIcon(
                FontAwesomeIcons.bars,
                color: Colors.black,
                size: 26,
              )),
        ),
      ),
      body: const Center(child: Text('Favorite Page')),
      backgroundColor: kBackgroundColor,
    );
  }
}
