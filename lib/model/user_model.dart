import '../data_provider/db_helper.dart';


class UserModel {
  String? email;
  String? name;
  String? pass;
  String? mobile;
  int? userId;


  UserModel({this.userId,this.email,this.name,this.pass,this.mobile});

  factory UserModel.fromMap(Map<String,dynamic> map) {
    return UserModel(
        userId: map[DbHelper.USERID],
        mobile: map[DbHelper.USERMOBILE],
        name: map[DbHelper.USERNAME],
        pass: map[DbHelper.USERPASS],
        email: map[DbHelper.USEREMAIL]

    );
  }

  Map<String,dynamic> toMap(){
    return {
      DbHelper.USERID: userId,
      DbHelper.USEREMAIL: email,
      DbHelper.USERPASS : pass,
      DbHelper.USERNAME :name,
      DbHelper.USERMOBILE : mobile
    };
  }

}