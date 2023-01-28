import 'dart:convert';
import 'dart:ui';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LocalizationServices{
  late final Locale locale;
 static   Locale ?currentLocale;
  LocalizationServices(this.locale){
    currentLocale=locale;
  }

  static LocalizationServices of(BuildContext context){
    return Localizations.of(context ,  LocalizationServices);

  }
   Map<String ,String>? _localizationString;
  Future<void> load()async{
    print(locale.languageCode);
    try{
      final jsonString =await rootBundle.loadString('languages/${locale.languageCode}.json');
      Map<String ,dynamic>jsonMap=json.decode(jsonString);

      _localizationString= jsonMap.map((key, value) => MapEntry(key, value.toString()));
    }catch(error){
      print("error in localization in ${error.toString()}");
    }

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

 static const LocalizationsDelegate<LocalizationServices> _delegate=_localizationServicesDelegate();
  static const localizationsDelegate =[
GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    _delegate
  ];
}

class _localizationServicesDelegate extends LocalizationsDelegate<LocalizationServices>{
  const _localizationServicesDelegate();

  @override
  bool isSupported(Locale locale) {
   return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<LocalizationServices> load(Locale locale) async{
    LocalizationServices services =LocalizationServices(locale);
    await services.load();
    return services;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LocalizationServices> old) {
  return false;
  }
}

// class LocalizationController extends GetxController{
//   String currentLanguage =''.obs.toString();
//
//   void toggleLanguage(){
// currentLanguage=LocalizationServices.currentLocale!.languageCode == 'ar' ? 'en' : 'ar';
// update();
//   }
// }