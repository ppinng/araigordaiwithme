import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';

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
        title: const Text('Favorite'),
        centerTitle: true,
        backgroundColor: kButtonColor,
      ),
      body: const Center(child: Text('Favorite Page')),
      backgroundColor: kBackgroundColor,
    );
  }
}
