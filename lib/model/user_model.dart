import '../helper/db_helper.dart';

class UserModel {
  String? email;
  String? img;
  String? pass;
  String? mobile;
  int? userId;


  UserModel({this.userId,this.email,this.img,this.pass,this.mobile});

  factory UserModel.fromMap(Map<String,dynamic> map) {
    return UserModel(
        userId: map[DbHelper.USERID],
        mobile: map[DbHelper.USERMOBILE],
        img: map[DbHelper.USERIMAGE],
        pass: map[DbHelper.USERPASS],
        email: map[DbHelper.USEREMAIL]

    );
  }

  Map<String,dynamic> toMap(){
    return {
      DbHelper.USERID: userId,
      DbHelper.USEREMAIL: email,
      DbHelper.USERPASS : pass,
      DbHelper.USERIMAGE :img,
      DbHelper.USERMOBILE : mobile
    };
  }

}