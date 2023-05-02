import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: IconButton(
              onPressed: () {
                //Navigator.of(context).pop();
              },
              icon: const FaIcon(
                FontAwesomeIcons.bars,
                color: Colors.black,
                size: 26,
              )),
        ),
      ),
      body: const Center(child: Text('History Page')),
      backgroundColor: kBackgroundColor,
    );
  }
}
