import '../pages/screens/home/screens/localization_services.dart';

enum TKeys{

  The_Best_Way_to_Manage_your_Activities,
  Phone,
  Enter_your_phone,
  Password,
  Enter_your_password
}

extension TkeysExtension on TKeys{
  String get _string => this.toString().split(".")[1];

  String translate(context){
    return LocalizationServices.of(context).translate(_string) ?? '';
  }
}