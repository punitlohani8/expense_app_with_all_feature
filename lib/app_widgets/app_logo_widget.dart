import 'package:expenser/ui_helper.dart';
import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  var mq;
  AppLogoWidget({super.key,this.mq});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColor.appBlackColor,
      radius: mq.size.height*0.07,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset('assets/images/logo.png',fit: BoxFit.cover,color: Colors.white),
      ),
    );
  }
}
