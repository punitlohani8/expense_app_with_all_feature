import 'package:expenser/helper/ui_helper.dart';
import 'package:flutter/material.dart';

import '../add_expese/add_expese.dart';
import 'frag_pages/stats_graph.dart';
import 'frag_pages/transaction_page.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  var arrFrags = [
    TransactionPage(),
    StatsGraph()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   actions: [
      //     InkWell(
      //       onTap: (){
      //         Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExpensePage(),));
      //       },
      //       child:const  Padding(
      //         padding: EdgeInsets.only(right: 8.0),
      //         child: CircleAvatar(
      //           backgroundColor: AppColor.appBlackColor,
      //           child: Icon(Icons.add,color: Colors.white,),
      //         ),
      //       ),
      //     )
      //   ],
      // ),

      body:arrFrags[selectedIndex],
      bottomNavigationBar: getBottomNavigation(),
    );
  }

  Widget getBottomNavigation(){
    return BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        selectedIconTheme: const IconThemeData(
            size: 25
        ),
        unselectedIconTheme: const IconThemeData(
          size: 19,
        ),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.inbox_outlined,
              ),
              label: 'Transactions',
              activeIcon: Icon(
                Icons.inbox_rounded,

              ),
              tooltip: 'Transaction'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_outlined,
              ),
              label: 'Graph',
              activeIcon: Icon(
                Icons.account_balance,
              ),
              tooltip: 'Stats')
    ]);
  }
}
