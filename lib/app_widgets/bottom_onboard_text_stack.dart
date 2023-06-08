import 'package:flutter/material.dart';

import '../helper/ui_helper.dart';

class BottomOnboardTextStack extends StatelessWidget {
  VoidCallback onPress;
  String text;
  String clickableText;

  BottomOnboardTextStack({super.key ,
    required this.onPress,
    required this.text,
    required this.clickableText,


  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Text(text,
          style: mTextStyle(fontSize: 12, mColor: Colors.grey)),
      InkWell(
        onTap: onPress,
        child: Text(
          clickableText,
          style: mTextStyle(fontSize: 12, mWeight: FontWeight.bold),
        ),
      ),
    ]);
  }
}
