import 'package:araigordaiwithme/screens/Home_page/home_page.dart';
import 'package:araigordaiwithme/screens/pages/foodlist.dart';
import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

//Confirm to Edit Image
class EditConfirmationDialog extends StatefulWidget {
  final String fieldName;
  final String initialValue;
  final void Function(String newValue) onConfirm;

  const EditConfirmationDialog({
    Key? key,
    required this.fieldName,
    required this.initialValue,
    required this.onConfirm,
  }) : super(key: key);

  @override
  _EditConfirmationDialogState createState() => _EditConfirmationDialogState();
}

class _EditConfirmationDialogState extends State<EditConfirmationDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit ${widget.fieldName}"),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: "Enter new ${widget.fieldName.toLowerCase()}",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onConfirm(_controller.text);
            Navigator.of(context).pop();
          },
          child: const Text("Confirm"),
        ),
      ],
    );
  }
}

//Confirm to Edit User Information
void _submitForm() {}

//page section
class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
}

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  //user information, provided from firebase
  String _image = "images/user.jpg";
  String _email = "hiwkao01@gmail.com";
  String _age = "20";
  String _height = "170";
  String _weight = "70";

  //allergic food, provided from firebase
  static final List<Animal> _animals = [
    Animal(id: 1, name: "Egg"),
    Animal(id: 2, name: "Fish"),
    Animal(id: 3, name: "Pork"),
    Animal(id: 4, name: "Beef"),
    Animal(id: 5, name: "Shrimp"),
    Animal(id: 6, name: "Crab"),
    Animal(id: 7, name: "Squid"),
    Animal(id: 8, name: "Nuts"),
    Animal(id: 9, name: "Wheat"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  List<Animal> _selectedAnimals = [];

  @override
  void initState() {
    _selectedAnimals = _animals;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
            size: 26,
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            imageProfile(), //Widget
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                "BMR: 1296 Kcal",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: kUserPageFieldColor,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Email",
                        hintText: _email,
                        hintStyle:
                            const TextStyle(color: kBoxColor, fontSize: 20),
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
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Age",
                        hintText: _age, //insert this value from firebase
                        hintStyle:
                            const TextStyle(color: kBoxColor, fontSize: 20),
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
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Height",
                        hintText: _height, //insert this value from firebase
                        hintStyle:
                            const TextStyle(color: kBoxColor, fontSize: 20),
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
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Weight",
                        hintText: _weight, //insert this value from firebase
                        hintStyle:
                            const TextStyle(color: kBoxColor, fontSize: 20),
                        suffixIcon: const Icon(Icons.edit),
                        suffixIconColor: kBoxColor,
                      ),
                      style: const TextStyle(color: kBoxColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: multiSelect(), //Widget
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  //Confirm button
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kButtonColor),
                    ),
                    onPressed: () {
                      _submitForm();
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Profile Widget
  Widget imageProfile() {
    return Center(
      child: Stack(
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
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => EditConfirmationDialog(
                    fieldName: "Image",
                    initialValue: _image,
                    onConfirm: (value) {
                      setState(() {
                        _image = value;
                      });
                    },
                  ),
                );
              },
              child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kButtonColor,
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  size: 23,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//Multiple Selection: Allergic Food
  Widget multiSelect() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: kUserPageFieldColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: MultiSelectDialogField(
            dialogWidth: 10,
            title: const Text("Allergic food"),
            decoration: BoxDecoration(
              color: kUserPageFieldColor,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: kUserPageFieldColor,
                width: 2,
              ),
            ),
            selectedColor: kButtonColor,
            selectedItemsTextStyle:
                const TextStyle(color: kDefaultIconLightColor),
            buttonText: const Text(
              "Select your Allergic food",
              style: TextStyle(color: kBoxColor, fontSize: 20),
            ),
            buttonIcon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: kBoxColor,
            ),
            listType: MultiSelectListType.CHIP,
            unselectedColor: kBackgroundColor,
            backgroundColor: kUserPageFieldColor,
            items: _animals.map((e) => MultiSelectItem(e, e.name)).toList(),
            onConfirm: (values) {
              _selectedAnimals = values;
              print(_selectedAnimals.map((animal) => animal.name).toList());
            },
            chipDisplay: MultiSelectChipDisplay(
              items: _selectedAnimals
                  .map((e) => MultiSelectItem(e, e.name))
                  .toList(),
              onTap: (value) {
                setState(() {
                  _selectedAnimals.remove(value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
