

import 'package:expenser/helper/images_helper.dart';
import 'package:expenser/model/cat_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../model/expense_model.dart';
import '../model/user_model.dart';

class DbHelper{

  //Expense table
  static const String EXPENSETABLENAME='expense';
  static const String EXPENSEID='e_id';
  static const String EXPESETITLE='title';
  static const String EXPENSEDESC='desc';
  static const String EXPENSEAMOUNT='amount';
  static const String EXPENSEBALANCE='balance';
  static const String EXPENSETYPE='type';
  static const String EXPENSEDATE='date';

  //User table
  static const String USERTABLENAME='user';
  static const String USERID='userId';
  static const String USEREMAIL='email';
  static const String USERPASS='password';
  static const String USERMOBILE='mobile';
  static const String USERNAME='name';

  //Category table
  static const String CATEGORYTABLENAME='category';
  static const String CATEGORYID='cat_id';
  static const String CATEGORYTITLE='title';
  static const String CATEGORYIMG='img';


  Future<Database> openDB() async{

    var mDirectory= await getApplicationDocumentsDirectory();
    await mDirectory.create(recursive: true);

    var mPath ='${mDirectory.path}/expense_db.db';

    return await openDatabase(mPath,version: 1,onCreate: (db,version){
      db.execute(
        'create table $EXPENSETABLENAME ($EXPENSEID integer primary key autoincrement,'
            '$EXPESETITLE text,'
            '$EXPENSEDESC text,'
            '$EXPENSEAMOUNT integer,'
            '$EXPENSEBALANCE integer,'
            '$EXPENSETYPE text,'
            '$EXPENSEDATE text,'
            '$USERID integer,'
            '$CATEGORYID integer)'
      );
      db.execute(
          'create table $USERTABLENAME ($USERID integer primary key autoincrement,'
              '$USERNAME text,'
              '$USEREMAIL text,'
              '$USERPASS text,'
              '$USERMOBILE text)'
      );
      db.execute(
          'create table $CATEGORYTABLENAME ($CATEGORYID integer primary key autoincrement,'
              '$CATEGORYTITLE text,'
              '$CATEGORYIMG text)'
      );

      for(int i=0 ; i< img.length; i++ ){
        db.insert(CATEGORYTABLENAME, CatModel(
          catTitle:img.keys.toList()[i],
          img : img.values.toList()[i],
        ).toMap());
      }


    });

  }

  //ADDing Expense
  Future<bool> addExpense(ExpenseModel expense) async {
    var db = await openDB();
    var check = await db.insert(EXPENSETABLENAME, expense.toMap());
    return check > 0;
  }


  // Get Expense
  Future<List<ExpenseModel>> getExpenses() async {
    var db = await openDB();
    var sp = await SharedPreferences.getInstance();
    //var userId = sp.getInt('userId');
    var userId = 0;
    var expensesList = await db
        .query(EXPENSETABLENAME, where: '$USERID = ?', whereArgs: ['$userId']);
    List<ExpenseModel> listExpenseModel = [];
    for (Map<String, dynamic> expenses in expensesList) {
      listExpenseModel.add(ExpenseModel.fromMap(expenses));
    }
    return listExpenseModel;
  }


  // Get Category
  Future<List<CatModel>> getCategories() async{
    var db = await openDB();
    var catData = await db.query(CATEGORYTABLENAME);

    List<CatModel> listCatModel = [];
    for (Map<String, dynamic> cat in catData) {
      listCatModel.add(CatModel.fromMap(cat));
    }
    return listCatModel;
  }

  //Delete Expense
  deleteExpense(String id) async {
    var mDb = await openDB();
    mDb.delete(EXPENSETABLENAME, where: '$EXPENSEID = ?', whereArgs: [id]);
  }

  // //Sign In
  Future<bool> SignIn(String email, String pass) async {
    var db = await openDB();
    List<Map<String, dynamic>> data = await db.query(USERTABLENAME,
        where: '$USEREMAIL = ? and $USERPASS = ?', whereArgs: [email, pass]);
    if (data.isNotEmpty) {
      var sp = await SharedPreferences.getInstance();
      sp.setInt('userId', data[0][USERID]);
    }
    return data.isNotEmpty;

  }

  //Sign Up
  Future<int> SignUp(UserModel user) async{
    var db = await openDB();
    int check;
    if (await checkUser(user.email!)) {
      check = await db.insert(USERTABLENAME, user.toMap());
    } else
      check = -1;
    return check;
  }

  Future<bool> checkUser(String email) async {
    var db = await openDB();
    List<Map<String, dynamic>> data = await db
        .query(USERTABLENAME, where: '$USEREMAIL = ?', whereArgs: [email]);
    return data.isEmpty;
  }

}