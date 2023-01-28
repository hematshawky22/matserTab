import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light =ThemeData(
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'arabic',
  primaryColor: k_blue,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
        color: Colors.black
    ),
    elevation: 0.0,
    color: Colors.transparent,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: k_black,
    unselectedItemColor: k_fontGrey,
    type: BottomNavigationBarType.fixed,
    elevation: 0.0,
    backgroundColor: Colors.transparent,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    headline2: TextStyle(
      color: k_black,
      fontSize: 15,
    ),
    headline3: TextStyle(
      color: k_fontGrey,
      fontSize: 12,
    ),
    headline4: TextStyle(
      color: k_blue,
      fontSize: 12,
    ),
    headline5: TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontSize: 16,
    ),
    headline6: TextStyle(
      color: k_yellow,
      fontSize: 16,
    ),

  ),
);

ThemeData dark = ThemeData(

  scaffoldBackgroundColor:HexColor('333739'),
  backgroundColor:HexColor('333739'),
  fontFamily: 'arabic',
  primaryColor: k_blue,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light
    ),
    iconTheme: IconThemeData(
        color: Colors.white
    ),
    elevation: 0.0,
    color:HexColor('333739'),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(

    selectedItemColor: k_blue,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    elevation: 0.0,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.grey,
        fontSize: 18
    ),

    headline1: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    headline2: TextStyle(
      color: Colors.white,
      fontSize: 15,
    ),
    headline3: TextStyle(
      color:Colors.grey,
      fontSize: 12,
    ),
    headline4: TextStyle(
      color: k_blue,
      fontSize: 12,
    ),
    headline5: TextStyle(
      color: Colors.black26,
      fontSize: 16,
    ),
    headline6: TextStyle(
      color: k_yellow,
      fontSize: 16,
    ),
  ),
);

class ThemeNotifer extends ChangeNotifier {
  final String key ="theme";
  SharedPreferences? sharedPreferences;
  bool _darkTheme = false;
  ThemeNotifer(){
    _darkTheme=true;
    _loadFromPref();
  }
  bool get darkTheme=>_darkTheme;

  toggleTheme(){
    _darkTheme=!_darkTheme;
    _savePref();
    notifyListeners();
  }

  _initPrefs()async{
    if(sharedPreferences==null){
      sharedPreferences=await SharedPreferences.getInstance();
    }
  }

_loadFromPref()async{
    await _initPrefs();
    _darkTheme =sharedPreferences!.getBool(key)??true;
    notifyListeners();

}
_savePref()async{
    await _initPrefs();
    sharedPreferences!.setBool(key, _darkTheme);

}
}