import 'package:flutter/material.dart';

import '../constant.dart';

class ToggleColorButton extends StatefulWidget {
  final String text;

  ToggleColorButton({required this.text});

  @override
  _ToggleColorButtonState createState() => _ToggleColorButtonState();
}

class _ToggleColorButtonState extends State<ToggleColorButton> {
  bool _isPressed = false;
  Color _defaultColor = kTagcolor;
  Color _pressedColor = kButtonColor;

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
        color: _isPressed ? _pressedColor : _defaultColor,
        child: Container(
          padding: const EdgeInsets.fromLTRB(23,5,23,5),
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
  @override
  _MyButtonLayoutState createState() => _MyButtonLayoutState();
}

class _MyButtonLayoutState extends State<MyButtonLayout> {
  List<bool> _buttonStates = List.generate(7, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        SizedBox(height: 21,),

        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: const Align(
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
            padding: const EdgeInsets.fromLTRB(25,10,20,10),

            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(child: ToggleColorButton(text: 'KFC')),
                  const SizedBox(
                    width: 29,
                  ),
                  Container(child: ToggleColorButton(text: 'Female Dorm')),
                  const SizedBox(
                    width: 29,
                  ),
                  Container(child: ToggleColorButton(text: 'Male Dorm')),
                  const SizedBox(
                    width: 29,
                  ),
                ]),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Flavour',
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
            padding: const EdgeInsets.fromLTRB(25,10,20,10),

            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(child: ToggleColorButton(text: 'Spicy')),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(child: ToggleColorButton(text: 'Sweet')),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(child: ToggleColorButton(text: 'Sour')),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(child: ToggleColorButton(text: 'Salty')),
                  const SizedBox(
                    width: 20,
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
