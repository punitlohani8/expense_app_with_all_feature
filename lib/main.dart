import 'package:expenser/constants.dart';
import 'package:expenser/data_provider/db_helper.dart';
import 'package:expenser/provider/app_provider.dart';
import 'package:expenser/screen/home_page/bloc/cat/cat_bloc.dart';
import 'package:expenser/screen/home_page/bloc/expense/expense_bloc.dart';
import 'package:expenser/screen/home_page/home_page.dart';
import 'package:expenser/screen/home_page/repo/expense_repo.dart';
import 'package:expenser/screen/user_onboard/login/login.dart';
import 'package:expenser/screen/user_onboard/sign_up/sing_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  var expenseRepo =ExpenseRepo(dbHelper: DbHelper());
  
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_)=>AppProvider()),
      ],
      child:MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ExpenseBloc(repo: expenseRepo)),
          BlocProvider(create: (_) => CatBloc(repo: expenseRepo))
        ],
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, value, child) {
      return MaterialApp(
        title: Constants.appName,
        debugShowCheckedModeBanner: false,
        // darkTheme: ThemeData(
        //   scaffoldBackgroundColor: Colors.black,
        //   // appBarTheme: ,
        //   // textTheme: ,
        // ),
        // theme: ThemeData(
        //   scaffoldBackgroundColor: Colors.white,
        //   // appBarTheme: ,
        //   // textTheme: ,
        // ),
        // themeMode: ThemeData.light(),
        home: SignUp(),
      );
    },);
  }
}

