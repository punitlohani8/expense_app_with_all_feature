import 'package:expenser/ui_helper.dart';
import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mq= MediaQuery.of(context);
    return Scaffold(
      body: mq.orientation==Orientation.portrait? _portraitLay() :_landscapeLay(),
    );
  }
  Widget _portraitLay(){
    return LayoutBuilder(builder: (_, constraints) =>
      constraints.maxWidth> 300 ? Column(
        children: [
          Text("Hello, again", style: mTextStyle(fontSize: 43,mWeight: FontWeight.bold),),
          Text('Start managing your expense in one click',style: mTextStyle(fontSize: 16),),
          TextField(
            controller: emailController,
            decoration: fieldDecoration(hint: 'Enter your Email', label: 'Email',
              prefixIcon: Icons.email_outlined
            ),
          ),
          TextField(
            controller: passController,
            decoration: fieldDecoration(hint: 'Enter your PassWord',
              label: 'Password',
              prefixIcon: Icons.password,
              suffixIcon: Icons.visibility,
              isPassword: true,

            ),
          ),
        ],
      ): Column(),);
  }

  Widget _landscapeLay(){
    return LayoutBuilder(builder: (_, constraints) =>
    constraints.maxWidth> 300 ? Column(
      children: [
        Text("")
      ],
    ): Column(),);
  }
}
