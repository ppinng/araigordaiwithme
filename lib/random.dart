import 'package:flutter/material.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class randomButton extends StatelessWidget {
  const randomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: kButtonColor,
            shadowColor: Colors.black,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const FaIcon(
          FontAwesomeIcons.shuffle,
          color: Colors.white,
          size: 26,
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  height: 100,
                  child: Image.asset('images/kaowmungai.png'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Khaowmungai',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  '360 Kcal/ 1 bowl',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
              ],
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(''),
                ),
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.xmark,
                    color: Colors.grey,
                    size: 26,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
