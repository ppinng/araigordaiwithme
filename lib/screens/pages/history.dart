import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';

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
        title: const Text('History'),
        centerTitle: true,
        backgroundColor: kButtonColor,
      ),
      body: const Center(child: Text('History Page')),
      backgroundColor: kBackgroundColor,
    );
  }
}
