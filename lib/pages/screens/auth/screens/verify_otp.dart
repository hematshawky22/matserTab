
import 'dart:convert';

import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/pages/screens/auth/screens/reset_password.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_button_navigation_bar.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_textField.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
class OtpVerfy extends StatefulWidget {
  String Phone;

   OtpVerfy({Key? key,required this.Phone}) : super(key: key);



  @override
  State<OtpVerfy> createState() => _OtpVerfyState();
}

class _OtpVerfyState extends State<OtpVerfy> {
  TextEditingController otpController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  Future<void> VerifyCode(var phone, var otp) async {
    if (otpController.text.isNotEmpty) {
      final ProgressDialog pr = ProgressDialog(context,
          type: ProgressDialogType.normal,
          isDismissible: false,
          showLogs: true);
      pr.show();
      String url =
          "https://mastertab.hekal.info/api/v1/employee/auth/verify-token?phone=${phoneController}&otp=${otpController}";

      http.Response response = await http.post(Uri.parse(url), body: {
        'phone': phoneController.text.toString(),
        "otp":otpController.text.toString()
      });
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data.toString());
        pr.hide();
        Get.off(() => ResetPassword(phone: phoneController.text,otp: otpController.text,));
      } else {
        pr.hide();
      }
    } else {
      Fluttertoast.showToast(
          msg: "Code is Empty !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneController.text =widget.Phone.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          "${AppLocalization.of(context).translate("verify_code")}",
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "${AppLocalization.of(context).translate("To_reset_your_password")}",
              style:
              Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16),
            ),
            SizedBox(height: 40),
            CustomTextField(
              onsave: () {},
              validate: () {},
              title: "${AppLocalization.of(context).translate("Phone")}",
              textEditingController: phoneController,
            ), SizedBox(height: 40),
            CustomTextField(
              onsave: () {},
              validate: () {},
              title: "${AppLocalization.of(context).translate("verified_code")}",
              hint:
              "${AppLocalization.of(context).translate("Enter_your_code")}",
              textEditingController: otpController,
            ),

          ],
        ),
      ),
      bottomNavigationBar: CustomButtonNavigationBar(
        color: k_blue,
        label: "${AppLocalization.of(context).translate("Check_the_code")}",
        onPress: () async {
          VerifyCode(phoneController.text,otpController.text);
        },
      ),
    );
  }
}
