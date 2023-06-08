import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier{

  //true for Dark Mode
   bool _isDarkMode = false;

   bool getThemeMode(){
     return _isDarkMode;
   }

   void changeTheme(bool darkMode){
     _isDarkMode=darkMode;
     notifyListeners();
   }

}