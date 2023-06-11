import 'package:expenser/screen/home_page/bloc/expense/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../helper/ui_helper.dart';
import '../../../model/expense_model.dart';
import '../../add_expese/add_expese.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  var dummyData = Constants.arrTransaction;
    List<Map<String,dynamic>> arrDateWiseData =[];
  late List<ExpenseModel> arrExpense=[];

  @override
  void initState() {
    super.initState();
    // get All Transaction
    BlocProvider.of<ExpenseBloc>(context).add(GetExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          //add Expense btn
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddExpensePage(),
                      ));
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundColor: AppColor.appBlackColor,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )),

          BlocBuilder<ExpenseBloc, ExpenseState>(
            builder: (context, state) {
              if (state is ExpenseLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ExpenseErrorState) {
                return const Center(
                  child: Text('Can\'t able to load categories!!!'),
                );
              }
              if (state is ExpenseLoadedState){
                arrExpense=state.listExpenses;
                filterExpenseDateWise();
                if(arrExpense.isNotEmpty){
                  return Expanded(
                      flex: 15,
                      child: Column(
                        children: [
                          //Total Balance
                          Expanded(
                            flex: 6,
                            child: Center(
                              child: totalBalanceUI(),
                            ),
                          ),
                          //List of Transaction
                          Expanded(
                            flex: 9,
                            child: ListView.builder(
                              itemCount: arrDateWiseData.length,
                              itemBuilder: (context, index) {
                                return getAllTransactionDateWise(arrDateWiseData[index]);
                              },
                            ),
                          ),
                        ],
                      ));
                }
                return const Center(child: Text('No Data Inserted Yet!!'));
              }
            return Container();
          },)
        ],
      )),
    );
  }

  Widget getAllTransactionDateWise(Map<String, dynamic> dayWise) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dayWise['day'],
                    style: mTextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      '\$${dayWise['amt']}',
                      style: mTextStyle(
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(child: Container()),
            const Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          itemCount: (dayWise['transactions'] as List).length,
          itemBuilder: (context, index) {
            return getListOfTransactionAccToDate(
                (dayWise['transactions'][index]as ExpenseModel));
          },
        )
      ],
    );
  }

  Widget getListOfTransactionAccToDate(
      ExpenseModel dayWiseTransaction) {
    return ListTile(
      title: Text(
        dayWiseTransaction.eTitle.toString(),
        style: mTextStyle(fontSize: 16, mWeight: FontWeight.bold),
      ),
      subtitle: Text(
        dayWiseTransaction.eDesc.toString(),
        style: mTextStyle(fontSize: 12),
      ),
      leading: Image.asset(
        'assets/images/expense_type/coffee.png',
        width: 30,
        height: 30,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$ ${dayWiseTransaction.eAmt}',
            style: mTextStyle(fontSize: 16, mWeight: FontWeight.bold),
          ),
          Text(
            '\$ ${dayWiseTransaction.eBal}',
            style: mTextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget totalBalanceUI() {
    //calculateTotalSpent();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Spent Till now',
            style: mTextStyle(fontSize: 12, mColor: AppColor.appBlackColor)),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: '\$ ',
              style: mTextStyle(
                  fontSize: 25,
                  mColor: AppColor.appBlackColor,
                  mWeight: FontWeight.bold)),
          TextSpan(
              text: //'${totalSpent!=0.0 ? totalSpent.toString().split('.')[0] : '000'}',
                  '466',
              style: mTextStyle(
                  fontSize: 43,
                  mWeight: FontWeight.bold,
                  mColor: AppColor.appBlackColor)),
          TextSpan(
              text: //'.${totalSpent!=0.0 ? totalSpent.toString().split('.')[1] : '00'}',
                  '.00',
              style: mTextStyle(
                  fontSize: 25,
                  mWeight: FontWeight.bold,
                  mColor: AppColor.appBlackColor))
        ]))
      ],
    );
  }

  void filterExpenseDateWise() {
    var uniqueDates=[];

    for(ExpenseModel model in arrExpense){
      var eachDateFormat= DateTime.parse(model.eDate!);
      var eachDate = '${eachDateFormat.year}-${eachDateFormat.month.toString().length==1 ? '0${eachDateFormat.month}': eachDateFormat.month}-${eachDateFormat.day.toString().length==1 ? '0${eachDateFormat.day}': eachDateFormat.day}';

      if(!uniqueDates.contains(eachDate)) {
        uniqueDates.add(eachDate);
      }
    }


    for(String eachDate in uniqueDates){
      arrDateWiseData.clear();
      List<ExpenseModel> eachDateTransaction= arrExpense.where((element) => element.eDate!.contains(eachDate)).toList();

      Map<String,dynamic> eachDateMap={};
      eachDateMap['day']=eachDate;
      eachDateMap['amt']='500';
      eachDateMap['transactions']=eachDateTransaction;

      arrDateWiseData.add(eachDateMap);
    }
  }
}
