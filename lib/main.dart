//import 'package:araigordaiwithme/constant.dart';
// import 'package:araigordaiwithme/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:araigordaiwithme/screens/welcome_page/welcome_screen.dart';
import 'firebase_options.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arai Gor Dai',
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: const WelcomeScreen(),
    );
  }
}
