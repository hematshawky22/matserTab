import 'dart:convert';
import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/models/customer_profile_info.dart';
import 'package:e_wallet_mobile_app/models/user_model.dart';
import 'package:e_wallet_mobile_app/pages/screens/profile/screens/edit_profile_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/profile/screens/my_cards_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/profile/screens/profile_info.dart';
import 'package:e_wallet_mobile_app/pages/screens/profile/screens/settings_screen.dart';
import 'package:e_wallet_mobile_app/pages/widgets/user_image.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:e_wallet_mobile_app/styles/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/build_profile_item.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CustomerInfo? customerInfo;
  int? Userid;

  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }
  getcustomeerInfo() async {
    final response = await http.get(Uri.parse(
        "https://mastertab.hekal.info/api/v1/employee/get-employee?id=${Userid}"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      customerInfo = CustomerInfo.fromjson(data);
      setState(() {});
      print(data);
    } else {}
  }

  getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      Userid = pref.getInt("id");
      print("user_id" + Userid.toString());
    });
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Support Center'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'To contact with support center please call this number :  '),
                Text(
                  '01093957856',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: SingleChildScrollView(

              child:  FutureBuilder(
      future: getcustomeerInfo(),
      builder: (BuildContext context, snapshot) {
          if (customerInfo == null) {
            return Center(child: Padding(
              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.4),
              child: CircularProgressIndicator(),
            ));
          } else {
            return Column(
                children: [
                  AppBar(
                    backgroundColor: k_grey,
                    title: Text(
                      "${AppLocalization.of(context).translate("MY_Profile")}",
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        onPressed: () => Get.to(() => EditProfileScreen(
                          id: Userid,
                          info: customerInfo,


                            )),
                        icon: Image.asset(
                          "assets/images/edit_icon.png",
                          color: k_blue,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    color: k_grey,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        UserImage(imagePath: k_imagePath, raduis: 130),
                        SizedBox(height: 15),
                        Text(
                          "${customerInfo!.f_name.toString()}",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        BuildProfileItem(
                          context: context,
                          iconPath: "assets/images/profile_icon.png",
                          title:
                              "${AppLocalization.of(context).translate("MY_Profile")}",
                          onTap: () {
                            Get.to(() => ProfileInfo());
                          },
                        ),
                        SizedBox(height: 20),
                        BuildProfileItem(
                          context: context,
                          iconPath: "assets/images/settings_icon.png",
                          title:
                              "${AppLocalization.of(context).translate("Setting")}",
                          onTap: () => Get.to(() => SettingScreen()),
                        ),
                        SizedBox(height: 20),
                        BuildProfileItem(
                          context: context,
                          iconPath: "assets/images/help_icon.png",
                          title:
                              "${AppLocalization.of(context).translate("Support_Center")}",
                          onTap: () {
                            _showMyDialog();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
            );
          }
      },
    ),
              ),
        ),
        );
  }
}
