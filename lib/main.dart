//import 'package:araigordaiwithme/constant.dart';
import 'package:araigordaiwithme/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:araigordaiwithme/screens/welcome_page/welcome_screen.dart';

void main(){
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const WelcomeScreen(),
    );
  }
}


