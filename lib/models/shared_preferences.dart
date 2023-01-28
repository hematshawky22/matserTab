import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
 class SharedPrefernces{
   static int? themeClr;
  static  addThemeColor (myC)async{
     SharedPreferences sp=SharedPreferences.getInstance() as SharedPreferences;
     sp.setInt("themeClr", myC);
   }
   static getThemeColor()async{
     SharedPreferences sp=SharedPreferences.getInstance() as SharedPreferences;
themeClr=sp.getInt("");
   }
 }
