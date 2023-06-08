import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expenser/model/cat_model.dart';
import 'package:meta/meta.dart';

import '../../repo/expense_repo.dart';

part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  ExpenseRepo repo;
  CatBloc({required this.repo}) : super(CatInitialState()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(CatLoadingState());
      var allCat= await repo.getCategory();
      emit(CatLoadedState(listCategory:  allCat));
    });
    on<AddCategoriesEvent>((event, emit) {

    });
  }

}
