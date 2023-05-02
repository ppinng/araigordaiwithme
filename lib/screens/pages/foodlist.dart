import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';

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
        title: const Text(
          'Hi, siri',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      body: const Center(child: Text('Food Page')),
      backgroundColor: kBackgroundColor,
    );
  }
}
