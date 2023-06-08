import 'package:expenser/app_widgets/app_logo_widget.dart';
import 'package:expenser/app_widgets/bottom_onboard_text_stack.dart';
import 'package:expenser/app_widgets/rounded_btn_widget.dart';
import 'package:expenser/screen/user_onboard/sign_up/sing_up.dart';
import 'package:expenser/helper/ui_helper.dart';
import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var mq;
  var mqHeight;
  var mqWidth;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    mqHeight=mq.size.height;
    mqWidth=mq.size.width;

print(mqHeight);
    return SafeArea(
      child: Scaffold(
        body: mq.orientation == Orientation.portrait
            ? _portraitLay(context)
            : _landscapeLay(context),
      ),
    );
  }
  
  Widget _mainLay(context){
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(mqWidth*0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            heightSpacer(height: mqHeight*0.2),
            AppLogoWidget(
              mq: mq,
            ),
            heightSpacer(height: mqHeight*0.008),
            Text(
              "Hello, again",
              style: mTextStyle(fontSize: mqHeight/18.1, mWeight: FontWeight.bold),
            ),
            heightSpacer(),
            Text(
              'Start managing your expense in one click',
              style: mTextStyle(fontSize: mqHeight/48.8),
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
              title: 'LogIn',
              onPress: () {},
            ),
            heightSpacer(height: mqHeight*0.01),
            BottomOnboardTextStack(onPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>SignUp(),));
            }, text:'Don\'have an Account. ' , clickableText: 'Sign Up')
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


