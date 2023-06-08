import 'package:expenser/app_widgets/app_logo_widget.dart';
import 'package:expenser/screen/user_onboard/login/login.dart';
import 'package:expenser/helper/ui_helper.dart';
import 'package:flutter/material.dart';

import '../../../app_widgets/bottom_onboard_text_stack.dart';
import '../../../app_widgets/rounded_btn_widget.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var mobController = TextEditingController();
  var mq;
  var mqHeight;
  var mqWidth;


  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    mqHeight= mq.size.height;
    mqWidth= mq.size.width;

    return Scaffold(
      body: mq.orientation == Orientation.portrait
          ? _portraitLay(context)
          : _landscapeLay(context),
    );
  }
  Widget _mainLay(context){
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(mqWidth*0.02),
        child: Column(
          children: [
            heightSpacer(
                height: mqHeight*0.1
            ),
            AppLogoWidget(
              mq: mq,
            ),
            heightSpacer(),
            Text(
              "WelCome...",
              style: mTextStyle(fontSize: mqHeight/18.1, mWeight: FontWeight.bold),
            ),
            heightSpacer(),
            Text(
              'Start managing your expense in one click',
              style: mTextStyle(fontSize: mqHeight/48.8),
            ),
            heightSpacer(),
            TextField(
              controller: nameController,
              decoration: fieldDecoration(
                  hint: 'Enter your Name',
                  label: 'Name',
                  prefixIcon: Icons.email_outlined),
            ),
            heightSpacer(),
            TextField(
              controller: emailController,
              decoration: fieldDecoration(
                  hint: 'Enter your Email',
                  label: 'Email',
                  prefixIcon: Icons.email_outlined),
            ),
            heightSpacer(),
            TextField(
              controller: mobController,
              decoration: fieldDecoration(
                  hint: 'Enter your Mobile Number',
                  label: 'Mobile Number',
                  prefixIcon: Icons.email_outlined),
            ),
            heightSpacer(),
            TextField(
              controller: passController,
              decoration: fieldDecoration(
                hint: 'Enter your PassWord',
                label: 'Password',
                prefixIcon: Icons.password,
                suffixIcon: Icons.visibility,
                isPassword: true,
              ),
            ),
            heightSpacer(),
            RoundedBtn(
              title: 'Sign Up',
              onPress: () {},
            ),
            heightSpacer(height: mqHeight*0.01),
            BottomOnboardTextStack(onPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>LogIn(),));
            }, text:'have an Account. ' , clickableText: 'Log In')
          ],
        ),
      ),
    );
  }


  Widget _portraitLay(context) {
    return LayoutBuilder(
        builder: (_, constraints) => _mainLay(context)
    );
  }

  Widget _landscapeLay(context) {
    return LayoutBuilder(
        builder: (_, constraints) =>Row(
          children: [
            Expanded(child: Container(
              color: AppColor.appBlackColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: AppLogoWidget(mq: mq,bgColor: AppColor.secondaryColor,iconColor: AppColor.appBlackColor),
                  ),
                  heightSpacer(),
                  Text('Expenser',style: mTextStyle(fontSize: mqHeight/18.1,mColor: AppColor.secondaryColor),)
                ],
              ),
            )),
            Expanded(child: _mainLay(context)),
          ], )
    );
  }

}
