import 'package:araigordaiwithme/screens/Home_page/home_page.dart';
import 'package:araigordaiwithme/screens/pages/foodlist.dart';
import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset("images/user.jpg"),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: kButtonColor,
                      ),
                      child: IconButton(
                        iconSize: 20,
                        onPressed: () {},
                        icon: const Icon(Icons.edit_outlined),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: kUserPageFieldColor,
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: kBoxColor),
                        suffixIcon: const Icon(Icons.edit),
                        suffixIconColor: kBoxColor,
                      ),
                      style: const TextStyle(color: kBoxColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: kUserPageFieldColor,
                        hintText: 'Age',
                        hintStyle: const TextStyle(color: kBoxColor),
                        suffixIcon: const Icon(Icons.edit),
                        suffixIconColor: kBoxColor,
                      ),
                      style: const TextStyle(color: kBoxColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: kUserPageFieldColor,
                        hintText: 'Height',
                        hintStyle: const TextStyle(color: kBoxColor),
                        suffixIcon: const Icon(Icons.edit),
                        suffixIconColor: kBoxColor,
                      ),
                      style: const TextStyle(color: kBoxColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        filled: true,
                        fillColor: kUserPageFieldColor,
                        hintText: 'Weight',
                        hintStyle: const TextStyle(color: kBoxColor),
                        suffixIcon: const Icon(Icons.edit),
                        suffixIconColor: kBoxColor,
                      ),
                      style: const TextStyle(color: kBoxColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: kUserPageFieldColor,
                        hintText: 'Weight',
                        hintStyle: const TextStyle(color: kBoxColor),
                        suffixIcon: const Icon(Icons.edit),
                        suffixIconColor: kBoxColor,
                      ),
                      style: const TextStyle(color: kBoxColor),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
