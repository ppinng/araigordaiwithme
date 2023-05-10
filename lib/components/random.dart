import 'dart:math';

import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';

class Menu {
  final int id;
  final String name;
  final String image;
  final int calories;
  final double price;
  final String location;

  Menu(
      {required this.id,
      required this.name,
      required this.image,
      required this.calories,
      required this.price,
      required this.location});
}

class RandomButton extends StatelessWidget {
  RandomButton({super.key});
  final menus = <Menu>[
    Menu(
        id: 1,
        name: 'Spicy fried chicken with basil leaves',
        image: 'images/krapao.png',
        calories: 250,
        price: 10.99,
        location: 'New York'),
    Menu(
        id: 2,
        name: 'Spicy Chicken Wings',
        image: 'images/wingsaps.png',
        calories: 350,
        price: 14.99,
        location: 'Los Angeles'),
    Menu(
        id: 3,
        name: 'Grilled Chicken',
        image: 'images/kaiyang.png',
        calories: 450,
        price: 19.99,
        location: 'Chicago'),
    Menu(
        id: 4,
        name: 'Chicken rice ',
        image: 'images/kaowmungai.png',
        calories: 550,
        price: 24.99,
        location: 'Houston'),
    Menu(
        id: 5,
        name: 'Papaya Salad',
        image: 'images/papayasalad.png',
        calories: 650,
        price: 29.99,
        location: 'Miami'),
  ];

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    final int randomIndex = random.nextInt(menus.length);

    return Container(
      height: 65, // Adjust the height as needed
      child: Padding(
        padding: const EdgeInsets.only(left: 25, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Menu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 25), // Adjust the left padding here
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: kButtonColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      maximumSize: const Size(780, 50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'images/mystery-box.png',
                        width: 75,
                        height: 110,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(60),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        width: 200,
                                        height: 100,
                                        child: Image.asset(
                                          menus[randomIndex].image,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          menus[randomIndex].name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${menus[randomIndex].calories} Kcal/ 1 bowl',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
