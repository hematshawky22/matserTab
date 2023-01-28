import 'dart:convert';

import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/pages/screens/Onboarding/screens/onboarding_sceen.dart';
import 'package:e_wallet_mobile_app/pages/screens/auth/screens/main_auth_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/profile/widgets/build_setting_item.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:e_wallet_mobile_app/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SettingScreen extends StatefulWidget {
   SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final localicationController =Get.find<LocalizationController>();
  int Userid=0;

   Widget _getFirstPage() {
     return OnboardingScreen();
   }
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      Userid = pref.getInt("id")!;
      print("user_id" + Userid.toString());
    });
  }
  Future<void> logout(var id) async {

      final ProgressDialog pr = ProgressDialog(
          context, type: ProgressDialogType.normal,
          isDismissible: false,
          showLogs: true);
      pr.show();

      String url = "https://mastertab.hekal.info/api/v1/employee/logout?user_id=${Userid}";
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

      http.Response response = await http.post(Uri.parse(url), body: {
"user_id":Userid.toString()
      });
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Logout successfully");
        sharedPreferences.setString("login", data["content"]);
        sharedPreferences.setInt("id", data["id"]);
        pr.hide();
        Get.off(() => OnboardingScreen());
      } else {
        pr.hide();

      }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: k_black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "${AppLocalization.of(context).translate("Setting")}",
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 20),
              BuildSettingItem(
                title:  "${AppLocalization.of(context).translate("Language")}",
                subTitle: "${AppLocalization.of(context).translate("Change_Language")}",
                imagePath: "assets/images/language_icon.png",
                onTap: () {
                  try{
                    localicationController.toggleLanguage();
                  }catch(error){
                    print(error);
                  }
                },
              ),
              SizedBox(height: 25),
              Consumer<ThemeNotifer>(
                builder: (context, notifier, child) => BuildSettingItem(
                  title: "${AppLocalization.of(context).translate("Mode")}",
                  subTitle: "${AppLocalization.of(context).translate("Change_the_mode")}",
                  imagePath: "assets/images/sun.png",
                  onTap: () async {
                   notifier.toggleTheme();
                  },
                ),
              ),
              SizedBox(height: 25),
              BuildSettingItem(
                title: "${AppLocalization.of(context).translate("logout")}",
                subTitle: "${AppLocalization.of(context).translate("Sign_out_of_your_existing_account")}",
                imagePath: "assets/images/logout_icon.png",
                onTap: () async {
                  SharedPreferences pref =await SharedPreferences.getInstance();
                  await pref.clear();
                  Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context)=>_getFirstPage()),);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
