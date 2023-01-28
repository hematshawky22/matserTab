import 'dart:convert';

import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/models/my_requests.dart';
import 'package:e_wallet_mobile_app/models/user_model.dart';
import 'package:e_wallet_mobile_app/pages/screens/home/widgets/build_user_request_item.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_button_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:e_wallet_mobile_app/styles/size_config.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  MyRequests? myRequests ;
  int Userid=0;
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
    if (Userid != 0) {
      getcustomrRequests();
    }
  }
  getcustomrRequests() async {
    final ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);
    pr.show();
    final response = await http.get(Uri.parse(
        "https://mastertab.hekal.info/api/v1/employee/get-own-requested-money?id=${Userid}"),);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      myRequests = MyRequests.fromJson(data);
      setState(() {});
      pr.hide();
    } else {
      pr.hide();
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "${AppLocalization.of(context).translate("Requests")}",
            style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 20),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: k_black),
            onPressed: () => Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: SizeConfig.screenWidth,
                  height: 50,
                  decoration: BoxDecoration(
                    color: k_grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: "${AppLocalization.of(context).translate("Total_Amount")}",
                      style: Theme.of(context).textTheme.headline2,
                      children: const <TextSpan>[
                        TextSpan(
                          text: "\$105.5",
                          style: TextStyle(
                            color: k_yellow,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text("October, 2020"),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child:
                  myRequests==null
                      ?  Center()
                      :
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:myRequests!.requestedMoney!.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return BuildUserRequestItem(requestedMoney: myRequests!.requestedMoney![index],offset: myRequests!.offset,);
                    },
                  )

                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomButtonNavigationBar(
          color: k_yellow,
          label: "${AppLocalization.of(context).translate("Send_All_Payment")}",
          imagePath: "assets/images/send_icon.png",
          onPress: () {},
        ),
      ),
    );
  }
}