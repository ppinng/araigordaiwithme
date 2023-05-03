import 'package:araigordaiwithme/screens/welcome_page/welcome_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import '../pages/favorite.dart';
import '../pages/history.dart';
import '../pages/foodList.dart';
import '../pages/userpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  final pages = [ FoodList(),   History(),   Favorite()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTab],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentTab,
        onTap: (i) => setState(() => currentTab = i),
        backgroundColor: kButtonColor,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.food_bank_outlined),
            title: const Text("Home"),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.history),
            title: const Text("History"),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite_border_outlined),
            title: const Text("Favorite"),
            selectedColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
