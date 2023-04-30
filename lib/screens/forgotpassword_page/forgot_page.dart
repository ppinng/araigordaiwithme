import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:araigordaiwithme/constant.dart';

class forgotMain extends StatelessWidget {
  const forgotMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Image.asset('images/AppLogo.png'),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Jum Mai Dai.'),
            )
          ],
        ),
      ),
    );
  }
}
