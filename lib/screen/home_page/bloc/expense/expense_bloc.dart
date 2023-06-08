import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expenser/model/expense_model.dart';
import 'package:meta/meta.dart';

import '../../repo/expense_repo.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseRepo repo;
  ExpenseBloc({required this.repo}) : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      bool check=await repo.addExpense(event.newExpense);

      if(check){
        var allExpenses= await repo.getExpense();
        emit(ExpenseLoadedState(listExpenses: allExpenses));
      }else{
        emit(ExpenseErrorState(errorMsg: 'Enable to add Expense to database'));
      }

    });
    on<GetExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      var allExpenses= await repo.getExpense();
      emit(ExpenseLoadedState(listExpenses: allExpenses));
    });

  }
}
