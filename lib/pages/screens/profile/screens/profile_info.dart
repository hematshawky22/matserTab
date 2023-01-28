import 'package:e_wallet_mobile_app/models/customer_profile_info.dart';
import 'package:e_wallet_mobile_app/pages/screens/Onboarding/screens/onboarding_sceen.dart';
import 'package:e_wallet_mobile_app/pages/screens/auth/screens/main_auth_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/profile/screens/edit_profile_screen.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_elevated_button.dart';
import 'package:e_wallet_mobile_app/pages/widgets/user_image.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:e_wallet_mobile_app/styles/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../models/app_localization.dart';

class ProfileInfo extends StatefulWidget {
  ProfileInfo({Key? key}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  CustomerInfo? customerInfo;

  int Userid = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getcustomeerInfo(),
            builder: (context, snapshot) {
              if (customerInfo == null) {
                return Center(child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.5),
                  child: CircularProgressIndicator(),
                ));
              } else {
                return Column(
                  children: [
                    AppBar(
                      leading: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,

                        ),
                      ),
                      backgroundColor: k_grey,
                      title: Text(
                        "${AppLocalization.of(context).translate("Profile_Info")}",
                        style: TextStyle(color: Colors.black, fontSize: 22),
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
                            "${customerInfo!.f_name} ",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: k_grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "${AppLocalization.of(context).translate("name")} ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        "${customerInfo!.f_name} ${customerInfo!.l_name}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: k_grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "${AppLocalization.of(context).translate("Phone")}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        "${customerInfo!.phone}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: k_grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "${AppLocalization.of(context).translate("Occupation")}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        "${customerInfo!.occupation}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: k_grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "${AppLocalization.of(context).translate("Gender")}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        "${customerInfo!.gender}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.75,
                            child: CustomElevatedButton(
                                label:
                                "${AppLocalization.of(context).translate("logout")}",
                                color: k_blue,
                                onPressed: () async {
                                  SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                                  await pref.clear();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              _getFirstPage()),
                                          (route) => false);
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }
}
