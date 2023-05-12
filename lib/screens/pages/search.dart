// ignore_for_file: prefer_const_constructors

import 'package:araigordaiwithme/screens/pages/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constant.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
            size: 26,
          ),
        ),
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kButtonColor),
            ),
            prefixIconColor: kButtonColor,
            prefixIcon: Icon(Icons.search),
            hintText: 'Search...',
          ),
          onChanged: (val) {
            setState(
              () {
                name = val;
              },
            );
          },
          cursorColor: kDefaultIconDarkColor,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Food').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: kBackgroundColor,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (!snapshot.hasData) {
            return Text('No data available');
          } else {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            final filteredDocuments = documents
                .where((doc) => doc['name']
                    .toString()
                    .toLowerCase()
                    .contains(name.toLowerCase()))
                .toList();
            return Container(
              color: kBackgroundColor,
              child: ListView.builder(
                itemCount: filteredDocuments.length,
                itemBuilder: (context, index) {
                  var data =
                      filteredDocuments[index].data() as Map<String, dynamic>;
                  return ListTile(
                    tileColor: kBackgroundColor,
                    title: Text(
                      data['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Calories: ${data['calories']}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: kDefaultIconLightColor,
                      backgroundImage: NetworkImage(data['image']),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FoodDetail(
                          documentId: filteredDocuments[index].id,
                        ),
                      ));
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
