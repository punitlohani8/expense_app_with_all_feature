

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

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
  static const String USERID='user_id';
  static const String USEREMAIL='email';
  static const String USERPASS='password';
  static const String USERMOBILE='mobile';
  static const String USERIMAGE='img';

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
        'create table $EXPENSETABLENAME ($EXPENSEID integer autoincrement,'
            '$EXPESETITLE text,'
            '$EXPENSEDESC text,'
            '$EXPENSEAMOUNT text,'
            '$EXPENSEBALANCE text,'
            '$EXPENSETYPE text,'
            '$EXPENSEDATE date,'
            '$USERID integer'
            '$CATEGORYID integer,)'
      );
      db.execute(
          'create table $USERTABLENAME ($USERID integer autoincrement,'
              '$USEREMAIL text,'
              '$USERPASS text,'
              '$USERMOBILE text,'
              '$USERIMAGE blob,)'
      );
      db.execute(
          'create table $CATEGORYTABLENAME ($CATEGORYID integer autoincrement,'
              '$CATEGORYTITLE text,'
              '$CATEGORYIMG blob)'
      );
    });

  }


  Future<bool> SignIn(String email, String pass) async {
    var myDb =await openDB();

    List<Map<String, dynamic>> data = await myDb.query(USERTABLENAME,
        where: "$USEREMAIL=? and $USERPASS = ?", whereArgs: [email, pass]);

    if(data.isNotEmpty){
      var sp = await SharedPreferences.getInstance();
      sp.setInt("id",data[0][USERID]);
    }
    return data.isNotEmpty;

  }

  Future<bool> SignUp(UserModel user) async{

    var myDb =await openDB();
    int check;

    if(!await checkIfEmailAlreadyExists(user.email)) {
      check = await myDb.insert(USERTABLENAME, user.toMap());
      return check != 0;
    }
    return false;
  }

  checkIfEmailAlreadyExists(String? email) async {
    var myDb = await openDB();

    List<Map<String, dynamic>> data =
        await myDb.query(USERTABLENAME, where: "$USEREMAIL=?", whereArgs: [email!]);

    return data.isNotEmpty;
  }

}