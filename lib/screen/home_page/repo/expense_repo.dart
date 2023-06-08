import 'package:expenser/data_provider/db_helper.dart';
import 'package:expenser/model/cat_model.dart';
import 'package:expenser/model/expense_model.dart';

class ExpenseRepo{

  DbHelper dbHelper;

  ExpenseRepo({required this.dbHelper});

  Future<bool> addExpense(ExpenseModel newExpense) async {
    var check = await dbHelper.addExpense(newExpense);
    return check;
  }

  Future<List<ExpenseModel>> getExpense() async {
    var data = await dbHelper.getExpenses();
    return data;
  }

  Future<List<CatModel>> getCategory() async {
    var data = await dbHelper.getCategories();
    return data;
  }

}