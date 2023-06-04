

import '../helper/db_helper.dart';

class ExpenseModel {
  String? eTitle;
  String? eDesc;
  String? eAmt;
  String? eBal;
  String? eType;
  String? eDate;
  int? expenseId;
  int? userId;
  int? catId;


  ExpenseModel({this.catId,this.userId,this.eAmt,this.eBal,this.eTitle,this.eDate,this.eDesc,this.eType,this.expenseId});

  factory ExpenseModel.fromMap(Map<String,dynamic> map) {
    return ExpenseModel(
      catId: map[DbHelper.CATEGORYID],
      eTitle: map[DbHelper.EXPESETITLE],
      expenseId: map[DbHelper.EXPENSEID],
      userId: map[DbHelper.USERID],
      eAmt: map[DbHelper.EXPENSEAMOUNT],
      eBal: map[DbHelper.EXPENSEBALANCE],
      eDate: map[DbHelper.EXPENSEDATE],
      eDesc: map[DbHelper.EXPENSEDESC],
      eType: map[DbHelper.EXPENSETYPE]

    );
  }

  Map<String,dynamic> toMap(){
    return {
      DbHelper.EXPENSEID : expenseId,
      DbHelper.EXPESETITLE: eTitle,
      DbHelper.EXPENSEDESC : eDesc,
      DbHelper.EXPENSEDATE : eDate,
      DbHelper.EXPENSETYPE : eType,
      DbHelper.CATEGORYID: catId,
      DbHelper.USERID : userId,
      DbHelper.EXPENSEAMOUNT :eAmt,
      DbHelper.EXPENSEBALANCE : eBal

    };
  }

}