import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: const [
          Text(
            'Welcome to Arai Gor Dai',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Color(0xFF7D7549)),
          ),
        ],
      ),
    );
  }
}
