import 'package:expenser/app_widgets/rounded_btn_widget.dart';
import 'package:expenser/helper/ui_helper.dart';
import 'package:expenser/model/expense_model.dart';
import 'package:expenser/screen/home_page/bloc/cat/cat_bloc.dart';
import 'package:expenser/screen/home_page/bloc/expense/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/cat_model.dart';

class AppExpensePage extends StatefulWidget {
  const AppExpensePage({super.key});

  @override
  State<AppExpensePage> createState() => _AppExpensePageState();
}

class _AppExpensePageState extends State<AppExpensePage> {
  var mq;
  var mqHeight;
  var mqWidth;
  var selectedIndex = -1;
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var amtController = TextEditingController();
  late List<CatModel>? catData;

  var listDropItems = ['Debit', 'Credit'];
  late var selectedDropDownValue;

  var isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDropDownValue = listDropItems[0];
    BlocProvider.of<CatBloc>(context).add(GetCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    mqHeight = mq.size.height;
    mqWidth = mq.size.width;

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              //title
              TextField(
                controller: titleController,
                decoration: fieldDecoration(
                    hint: 'Enter Title...', label: 'Title'),
              ),
              heightSpacer(),
              //description
              TextField(
                controller: descController,
                decoration: fieldDecoration(
                    hint: 'Enter Description...', label: 'Description'),
              ),
              heightSpacer(),
              //Amount
              TextField(
                controller: amtController,
                keyboardType: TextInputType.number,
                decoration:
                fieldDecoration(hint: 'Enter Amount...', label: 'Amount'),
              ),
              heightSpacer(),
              // Selecting Category
              BlocBuilder<CatBloc, CatState>(
                builder: (context, state) {
                  if (state is CatLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CatErrorState) {
                    return const Center(
                      child: Text('Can\'t able to load categories!!!'),
                    );
                  }
                  if (state is CatLoadedState) {
                    catData = state.listCategory;
                    return ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.vertical(top: Radius.circular(21))),
                          builder: (context) {
                            return SizedBox(
                              height: mqHeight * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: GridView.builder(
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 2),
                                  itemCount: catData!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          selectedIndex = index;
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: selectedIndex != index
                                            ? Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              '${catData![index].img}',
                                              width: 40,
                                              height: 50,
                                            ),
                                            heightSpacer(height: 2),
                                            Text(
                                              '${catData![index].catTitle}',
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        )
                                            : Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(11),
                                              color: Colors.grey),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                '${catData![index].img}',
                                                width: 40,
                                                height: 50,
                                              ),
                                              heightSpacer(height: 2),
                                              Text(
                                                '${catData![index].catTitle}',
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ));
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: selectedIndex == -1
                          ? Text(
                        'Choose Expense Type',
                        style: mTextStyle(fontSize: 16),
                      )
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            catData![selectedIndex].img!,
                            width: 20,
                            height: 20,
                          ),
                          widthSpacer(),
                          Text(catData![selectedIndex].catTitle!)
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              ),
              //selecting type
              DropdownButton(
                  value: selectedDropDownValue,
                  items: listDropItems
                      .map((expenseType) =>
                      DropdownMenuItem(
                          value: expenseType, child: Text(expenseType)))
                      .toList(),
                  onChanged: (value) {
                    selectedDropDownValue = value!;
                    setState(() {});
                  }),
              //button
              BlocBuilder<ExpenseBloc , ExpenseState>(
                builder: (context, state) {
                  if(state is ExpenseLoadingState){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if(state is ExpenseLoadedState){
                    return RoundedBtn(
                        title: 'AddExpense',
                        onPress: () {
                          if (selectedIndex != -1 && catData != null) {
                            var balance = 0;
                            var amt = int.parse(amtController.text.toString());

                            var newExpense = ExpenseModel(
                                eTitle: titleController.text.toString(),
                                eAmt: amt,
                                eDesc: descController.text.toString(),
                                userId: 0,
                                eBal: selectedDropDownValue == 'debit'
                                    ? balance - amt
                                    : balance + amt,
                                catId: catData![selectedIndex].catId,
                                eDate: DateTime.now().toString(),
                                eType: selectedDropDownValue);
                          }
                        });
                  }else if(state is ExpenseErrorState){
                    return const Center(
                      child: Text('Can\'t able to add expense!!!'),
                    );
                  }
                  else{
                    return Container();
                  }
                },
              )
            ],
          ),
        ));
  }
}
