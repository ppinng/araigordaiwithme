import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../constant.dart';

class ToggleColorButton extends HookWidget {
  final String text;
  final bool isPressed;
  final void Function() onPressed;

  const ToggleColorButton({
    Key? key,
    required this.text,
    required this.isPressed,
    required this.onPressed,
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
          style: const TextStyle(fontSize: 18),
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
    required this.filteredFoodType,
  }) : super(key: key);
  final void Function(String location, String foodType) onFilteredChange;
  final String filteredLocation;
  final String filteredFoodType;
  @override
  Widget build(BuildContext context) {
    final selectedLocation = useState<String>(filteredLocation);
    final selectedFoodType = useState<String>(filteredFoodType);

    void onLocationPressed(String location) {
      selectedLocation.value =
          location == selectedLocation.value ? '' : location;
      onFilteredChange(selectedLocation.value, selectedFoodType.value);
    }

    void onFoodTypePressed(String foodType) {
      selectedFoodType.value =
          foodType == selectedFoodType.value ? '' : foodType;
      onFilteredChange(selectedLocation.value, selectedFoodType.value);
    }

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
                children: [
                  ToggleColorButton(
                    text: 'KFC',
                    isPressed: selectedLocation.value == 'KFC',
                    onPressed: () {
                      onLocationPressed('KFC');
                    },
                  ),
                  const SizedBox(
                    width: 29,
                  ),
                  ToggleColorButton(
                      text: 'Female Dorm',
                      isPressed: selectedLocation.value == 'Female Dorm',
                      onPressed: () {
                        onLocationPressed('Female Dorm');
                      }),
                  const SizedBox(
                    width: 29,
                  ),
                  ToggleColorButton(
                      text: 'Male Dorm',
                      isPressed: selectedLocation.value == 'Male Dorm',
                      onPressed: () {
                        onLocationPressed('Male Dorm');
                      }),
                  const SizedBox(
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
                children: [
                  ToggleColorButton(
                      text: 'Chicken',
                      isPressed: selectedFoodType.value == 'chicken',
                      onPressed: () {
                        onFoodTypePressed('chicken');
                      }),
                  const SizedBox(
                    width: 20,
                  ),
                  ToggleColorButton(
                      text: 'Fish',
                      isPressed: selectedFoodType.value == 'fish',
                      onPressed: () {
                        onFoodTypePressed('fish');
                      }),
                  const SizedBox(
                    width: 20,
                  ),
                  ToggleColorButton(
                      text: 'Meat',
                      isPressed: selectedFoodType.value == 'meat',
                      onPressed: () {
                        onFoodTypePressed('meat');
                      }),
                  const SizedBox(
                    width: 20,
                  ),
                  ToggleColorButton(
                      text: 'Pork',
                      isPressed: selectedFoodType.value == 'pork',
                      onPressed: () {
                        onFoodTypePressed('pork');
                      }),
                  const SizedBox(
                    width: 20,
                  ),
                  ToggleColorButton(
                      text: 'Shrimp',
                      isPressed: selectedFoodType.value == 'shrimp',
                      onPressed: () {
                        onFoodTypePressed('shrimp');
                      }),
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
