// ignore_for_file: library_private_types_in_public_api, duplicate_ignore, file_names

import 'package:flutter/material.dart';

import '../constant.dart';

class ToggleColorButton extends StatefulWidget {
  final String text;

  const ToggleColorButton({super.key, required this.text});

  @override
  // ignore: library_private_types_in_public_api
  _ToggleColorButtonState createState() => _ToggleColorButtonState();
}

class _ToggleColorButtonState extends State<ToggleColorButton> {
  bool _isPressed = false;

  void _onButtonPress() {
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onButtonPress,
      child: Material(
        elevation: 5, // set the elevation value
        borderRadius: BorderRadius.circular(18),
        color: _isPressed ? kButtonColor : kTagcolor,
        child: Container(
          padding: const EdgeInsets.fromLTRB(23, 5, 23, 5),
          child: Text(
            widget.text,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class MyButtonLayout extends StatefulWidget {
  const MyButtonLayout({super.key});

  @override
  _MyButtonLayoutState createState() => _MyButtonLayoutState();
}

class _MyButtonLayoutState extends State<MyButtonLayout> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 21,
        ),

        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Location',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // SizedBox(height: 15),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  ToggleColorButton(text: 'KFC'),
                  SizedBox(
                    width: 29,
                  ),
                  ToggleColorButton(text: 'Female Dorm'),
                  SizedBox(
                    width: 29,
                  ),
                  ToggleColorButton(text: 'Male Dorm'),
                  SizedBox(
                    width: 29,
                  ),
                ]),
          ),
        ),

        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Food Type',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  ToggleColorButton(text: 'Meat'),
                  SizedBox(
                    width: 20,
                  ),
                  ToggleColorButton(text: 'Noodles'),
                  SizedBox(
                    width: 20,
                  ),
                  ToggleColorButton(text: 'Rice dishes'),
                  SizedBox(
                    width: 20,
                  ),
                  // ToggleColorButton(text: 'Vegetable'),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  ToggleColorButton(text: 'Frying'),
                  SizedBox(
                    width: 20,
                  ),
                  ToggleColorButton(text: 'Stir-Frying'),
                  SizedBox(
                    width: 20,
                  ),
                  ToggleColorButton(text: 'Grilling'),
                  SizedBox(
                    width: 20,
                  ),
                  ToggleColorButton(text: 'Boiling'),
                  SizedBox(
                    width: 20,
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
