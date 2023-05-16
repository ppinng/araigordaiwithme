import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  late int calories;
  String canteen = '';
  bool favorite = false;
  String foodid = '';
  String foodtype = '';
  String image = '';
  String name = '';
  String store = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      // Create a new document in Firestore and use its ID as the foodid
      final newDocRef = _firestore.collection('Food').doc();
      foodid = newDocRef.id;

      newDocRef.set({
        'calories': calories,
        'canteen': canteen,
        'favorite': favorite,
        'foodid': foodid,
        'foodtype': foodtype,
        'image': image,
        'name': name,
        'store': store,
      }).then((_) {
        // Document successfully added to Firestore
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data saved successfully')),
        );
        // Clear the form fields
        _formKey.currentState?.reset();
      }).catchError((error) {
        // Error occurred while adding document to Firestore
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save data: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Calories (int)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => calories = int.parse(value!),
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Canteen (String)'),
                onSaved: (value) => canteen = value!,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Food Type (String)'),
                onSaved: (value) => foodtype = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image (Link)'),
                onSaved: (value) => image = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name (String)'),
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Store (String)'),
                onSaved: (value) => store = value!,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(),
  //       body: Center(
  //         child: Form(
  //           key: _formKey,
  //           child: Column(
  //             children: [
  //               TextFormField(
  //                 decoration:
  //                     const InputDecoration(labelText: 'Calories (int)'),
  //                 keyboardType: TextInputType.number,
  //                 onSaved: (value) => calories = int.parse(value!),
  //               ),
  //               TextFormField(
  //                 decoration:
  //                     const InputDecoration(labelText: 'Canteen (String)'),
  //                 onSaved: (value) => canteen = value!,
  //               ),
  //               TextFormField(
  //                 decoration:
  //                     const InputDecoration(labelText: 'Food Type (String)'),
  //                 onSaved: (value) => foodtype = value!,
  //               ),
  //               TextFormField(
  //                 decoration: const InputDecoration(labelText: 'Image (Link)'),
  //                 onSaved: (value) => image = value!,
  //               ),
  //               TextFormField(
  //                 decoration: const InputDecoration(labelText: 'Name (String)'),
  //                 onSaved: (value) => name = value!,
  //               ),
  //               TextFormField(
  //                 decoration:
  //                     const InputDecoration(labelText: 'Store (String)'),
  //                 onSaved: (value) => store = value!,
  //               ),
  //               ElevatedButton(
  //                 onPressed: _submitForm,
  //                 child: const Text('Submit'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ));
  // }
}
