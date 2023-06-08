import '../data_provider/db_helper.dart';

class CatModel {
  String? catTitle;
  String? img;
  int? catId;


  CatModel({this.catId,this.catTitle,this.img});

  factory CatModel.fromMap(Map<String,dynamic> map) {
    return CatModel(
      catId: map[DbHelper.CATEGORYID],
      catTitle: map[DbHelper.CATEGORYTITLE],
      img: map[DbHelper.CATEGORYIMG]
    );
  }

  Map<String,dynamic> toMap(){
    return {
      DbHelper.CATEGORYID: catId,
      DbHelper.CATEGORYTITLE: catTitle,
      DbHelper.CATEGORYIMG : img
    };
  }

}