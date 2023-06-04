import 'package:flutter/material.dart';

class AppColor {
/// Light color
  //static const Color primaryColor = Color(0xffdbd9dd);
  static const Color secondaryColor =  Color(0xffdbd9dd);
  static const Color appBlackColor =  Color(0xff14101c);
  static const Color textColor = Color(0xff14101c);

  /// dark theme colors
  //static const Color primaryDarkColor = Color(0xffdbd9dd);
  static const Color secondaryDarkColor =  Color(0xffdbd9dd);
  static const Color appBlackDarkColor =  Color(0xff14101c);
  static const Color textDarkColor = Color(0xffe8e8e8);

}

TextStyle mTextStyle({
  required double fontSize,
  Color mColor = AppColor.textColor,
  FontWeight mWeight= FontWeight.normal,
}) {
  return TextStyle(
      fontSize: fontSize,
      color: mColor,
      fontFamily: 'Poppins,',
      fontWeight: mWeight);
}

InputDecoration fieldDecoration({
 required String hint,
 required String label,
  Color filledColor =AppColor.secondaryColor,
  IconData? prefixIcon,
  IconData? suffixIcon,
  bool isPassword= false,
}){
  return InputDecoration(
    suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
    fillColor: filledColor,
    hintText: hint,
    label: Text(label),
    border: outlineBorder(borderColor: Colors.white,borderWidth: 2)
  );
}

OutlineInputBorder outlineBorder({
  double radius=21,
  Color borderColor =AppColor.appBlackColor,
  double borderWidth=1
}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(
      color: borderColor,
      width: borderWidth,
    )
  );
}