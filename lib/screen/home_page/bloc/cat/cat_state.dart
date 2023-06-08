part of 'cat_bloc.dart';

@immutable
abstract class CatState {}

class CatInitialState extends CatState {}

class CatLoadingState extends CatState {}

class CatLoadedState extends CatState {
  List<CatModel> listCategory;
  CatLoadedState({required this.listCategory});
}

class CatErrorState extends CatState {
  String errorMsg;
  CatErrorState({required this.errorMsg});
}

