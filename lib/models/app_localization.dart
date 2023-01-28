import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalization {
  final Locale locale;
  static   Locale ?currentLocale;
  AppLocalization(this.locale){
    currentLocale=locale;
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }
  static  LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationDelegate();

  Map<String, String>? _localizationString;

  Future<bool> load() async {
    print(locale.languageCode);

    final jsonString =
        await rootBundle.loadString('languages/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizationString =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));

    return true;
  }
  String? translate(String key){
    return _localizationString?[key];
  }
  static const supportedLocales=[
    Locale('en','US'),
    Locale('ar','AR'),
  ];
  static Locale? localeResolutionCallBack(Locale? locale ,Iterable<Locale>?supportedLocales){
    if(supportedLocales != null && locale != null ){
      return supportedLocales.firstWhere((element) => element.languageCode==locale.languageCode,
          orElse: ()=>supportedLocales.first);
    }
    return null;
  }
  static  LocalizationsDelegate<AppLocalization> _delegate= _AppLocalizationDelegate();
  static dynamic localizationDeligate =[
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
   GlobalCupertinoLocalizations.delegate,
   _delegate
 ];
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization>{
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
  return ["en","ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async{
   AppLocalization localization =new AppLocalization(locale);
   await localization.load();
   return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
   return false;
  }
  
}
class LocalizationController extends GetxController{
  String currentLanguage =''.obs.toString();

  void toggleLanguage(){
    currentLanguage=AppLocalization.currentLocale!.languageCode == 'ar' ? 'en' : 'ar';
    update();
  }
}
