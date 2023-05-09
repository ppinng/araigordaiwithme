import 'package:araigordaiwithme/screens/pages/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant.dart';

class FoodDetail extends StatelessWidget {
  const FoodDetail({required this.documentId});

  final String documentId;

  @override
  Widget build(BuildContext context) {
    CollectionReference food = FirebaseFirestore.instance.collection('Food');
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black,
              size: 26,
            ),
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: food.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Image.network(
                    data['image'],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  color: kBackgroundColor,
                  child: Text(
                    "${data['name']}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  color: kBackgroundColor,
                  child: Text("Calories: ${data['calories']}",
                      style: TextStyle(fontSize: 20)),
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
