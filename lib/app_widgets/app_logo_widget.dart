import 'package:expenser/helper/ui_helper.dart';
import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  var mq;
  Color iconColor;
  Color bgColor;

  AppLogoWidget({super.key,this.mq,this.bgColor = AppColor.appBlackColor,this.iconColor=Colors.white});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: bgColor,
      radius: mq.size.height*0.07,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset('assets/images/logo.png',fit: BoxFit.cover,color: iconColor),
      ),
    );
  }
}
