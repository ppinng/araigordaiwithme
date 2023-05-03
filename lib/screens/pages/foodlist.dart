import 'package:araigordaiwithme/constant.dart';
import 'package:flutter/material.dart';

class Menu {
  final String name;
  final String image;
  final int calories;
  final double price;
  final String location;

  Menu({required this.name, required this.image, required this.calories, required this.price, required this.location});
}


class FoodList extends StatelessWidget {
  final List<Menu> menus = [
    Menu(name: 'Menu 1', image: 'images/krapao.png', calories: 250, price: 10.99, location: 'New York'),
    Menu(name: 'Menu 2', image: 'images/krapao.png', calories: 350, price: 14.99, location: 'Los Angeles'),
    Menu(name: 'Menu 3', image: 'images/krapao.png', calories: 450, price: 19.99, location: 'Chicago'),
    Menu(name: 'Menu 4', image: 'images/krapao.png', calories: 550, price: 24.99, location: 'Houston'),
    Menu(name: 'Menu 5', image: 'images/krapao.png', calories: 650, price: 29.99, location: 'Miami'),
  ];

  FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: ListView.builder(
        itemCount: menus.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      menus[index].image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(menus[index].name, style: TextStyle(fontSize: 30, color: Colors.black,  )),
                        Text('Calories: ${menus[index].calories}'),
                        // Text('Price: \฿${menus[index].price.toStringAsFixed(2)}'),
                        // Text('Location: ${menus[index].location}'),
                      ],
                    ),
                  ],
                ),
              ),
              // const Divider(
              //   color: Colors.green,
              //   height: 5,
              // ),
            ],
          );
        },
      ),
    );
  }
}
