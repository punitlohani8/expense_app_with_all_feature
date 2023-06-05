import 'package:expenser/ui_helper.dart';
import 'package:flutter/material.dart';

class RoundedBtn extends StatelessWidget {
  double width;
  double height;
  String title;
  Color color;
  VoidCallback onPress;
  IconData? icon;
  double radius;

  RoundedBtn({
    super.key,
    required this.title,
    required this.onPress,
    this.height = 50.0,
    this.width = double.infinity,
    this.color = AppColor.appBlackColor,
    this.icon,
    this.radius=21
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            backgroundColor: color
          ),
          child: icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon),
                    widthSpacer(),
                    Text(title),
                  ],
                )
              : Text(title),
        ));
  }
}
