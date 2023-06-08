import 'package:expenser/helper/ui_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),

      body: Container(
        child: Text(
          'hello',
          style: mTextStyle(fontSize: 43),
        ),
      ),
    );
  }


}
