import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/pages/screens/Onboarding/screens/onboarding_sceen.dart';
import 'package:e_wallet_mobile_app/pages/screens/e-wallet_layout/e-wallet_layout_screen.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:e_wallet_mobile_app/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/screens/home/screens/localization_services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
bool darkMode=false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

    runApp( MyApp());

}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();


  }

  final localizationController =Get.put(LocalizationController());
  int Userid = 0;
  getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      Userid = pref.getInt("id")!;
      print("user_id" + Userid.toString());
    });

  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new ThemeNotifer(),
      child: Consumer<ThemeNotifer>(
        builder: (context,ThemeNotifer notifier,child){
      return  GetBuilder<LocalizationController>(
          init: localizationController,
          builder: (LocalizationController controller) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: notifier.darkTheme?light:dark,
           supportedLocales: AppLocalization.supportedLocales,
              locale: controller.currentLanguage!= ''?Locale(controller.currentLanguage,''):null,
              localizationsDelegates: [
                AppLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate

              ],
              localeResolutionCallback: AppLocalization.localeResolutionCallBack,
              home:Userid==0?OnboardingScreen() :E_WalletLayoutScreen(),
            );}
      );
        }
    )
    );
  }
}
