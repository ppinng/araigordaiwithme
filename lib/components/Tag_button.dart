import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../constant.dart';

class ToggleColorButton extends HookWidget {
  final String text;
  final bool isPressed;
  final void Function() onPressed;
  final double fontSize;

  const ToggleColorButton({
    Key? key,
    required this.text,
    required this.isPressed,
    required this.onPressed,
    this.fontSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColor = isPressed ? kButtonColor : kTagcolor;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}

class MyButtonLayout extends HookWidget {
  const MyButtonLayout({
    Key? key,
    required this.onFilteredChange,
    required this.filteredLocation,
    required this.filteredCuisine,
  }) : super(key: key);
  final void Function(String location, String cuisine) onFilteredChange;
  final String filteredLocation;
  final String filteredCuisine;
  @override
  Widget build(BuildContext context) {
    final selectedLocation = useState<String>(filteredLocation);
    final selectedCuisine = useState<String>(filteredCuisine);

    void onLocationPressed(String location) {
      selectedLocation.value =
          location == selectedLocation.value ? '' : location;
      onFilteredChange(selectedLocation.value, selectedCuisine.value);
    }

    void onFoodTypePressed(String cuisine) {
      selectedCuisine.value = cuisine == selectedCuisine.value ? '' : cuisine;
      onFilteredChange(selectedLocation.value, selectedCuisine.value);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToggleColorButton(
                  text: 'KFC',
                  isPressed: selectedLocation.value == 'KFC',
                  onPressed: () {
                    onLocationPressed('KFC');
                  },
                  fontSize: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                ToggleColorButton(
                  text: 'Female Dorm',
                  isPressed: selectedLocation.value == 'Female Dorm',
                  onPressed: () {
                    onLocationPressed('Female Dorm');
                  },
                  fontSize: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                ToggleColorButton(
                  text: 'Male Dorm',
                  isPressed: selectedLocation.value == 'Male Dorm',
                  onPressed: () {
                    onLocationPressed('Male Dorm');
                  },
                  fontSize: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Cuisine',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ClipRect(
          clipper: HorizontalClipper(22),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ToggleColorButton(
                        text: 'Fry',
                        isPressed: selectedCuisine.value == 'fry',
                        onPressed: () {
                          onFoodTypePressed('fry');
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    ToggleColorButton(
                        text: 'Curry',
                        isPressed: selectedCuisine.value == 'curry',
                        onPressed: () {
                          onFoodTypePressed('curry');
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    ToggleColorButton(
                        text: 'Boil',
                        isPressed: selectedCuisine.value == 'boil',
                        onPressed: () {
                          onFoodTypePressed('boil');
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    ToggleColorButton(
                        text: 'Stir',
                        isPressed: selectedCuisine.value == 'stir',
                        onPressed: () {
                          onFoodTypePressed('stir');
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    ToggleColorButton(
                        text: 'Bake',
                        isPressed: selectedCuisine.value == 'bake',
                        onPressed: () {
                          onFoodTypePressed('bake');
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    ToggleColorButton(
                        text: 'Grill ',
                        isPressed: selectedCuisine.value == 'grill',
                        onPressed: () {
                          onFoodTypePressed('grill');
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}

class HorizontalClipper extends CustomClipper<Rect> {
  final double leftMargin;

  HorizontalClipper(this.leftMargin);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(leftMargin, 0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
