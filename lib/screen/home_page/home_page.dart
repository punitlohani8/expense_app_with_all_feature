import 'package:expenser/helper/ui_helper.dart';
import 'package:flutter/material.dart';

import '../add_expese/add_expese.dart';

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          CircleAvatar(
            backgroundColor: AppColor.appBlackColor,
            child: Icon(Icons.add,color: Colors.white,),
          )
        ],
      ),

      body: AppExpensePage()
    );
  }


}
