import 'dart:convert';

import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/pages/screens/auth/screens/reset_password.dart';
import 'package:e_wallet_mobile_app/pages/screens/auth/screens/verify_otp.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_button_navigation_bar.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_textField.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _phoneController = TextEditingController();

  Future<void> resetPassword(var phone) async {
    if (_phoneController.text.isNotEmpty) {
      final ProgressDialog pr = ProgressDialog(context,
          type: ProgressDialogType.normal,
          isDismissible: false,
          showLogs: true);
      pr.show();
      String url =
          "https://mastertab.hekal.info/api/v1/employee/auth/forgot-password?phone=${_phoneController}";

      http.Response response = await http.post(Uri.parse(url), body: {
        'phone': _phoneController.text,
      });
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data.toString());
        pr.hide();
        Get.off(() => OtpVerfy(Phone: _phoneController.text,));
      } else {
        pr.hide();
        Fluttertoast.showToast(
            msg: "Phone is inCorrect !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Phone is Empty !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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
          "${AppLocalization.of(context).translate("Reset_Password")}",
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "${AppLocalization.of(context).translate("Enter_your_email_to_send_instruction_to_reset_your_password")}",
              style:
                  Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16),
            ),
            SizedBox(height: 40),
            CustomTextField(
              onsave: () {},
              validate: () {},
              title: "${AppLocalization.of(context).translate("Phone")}",
              hint:
                  "${AppLocalization.of(context).translate("Enter_your_phone")}",
              textEditingController: _phoneController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomButtonNavigationBar(
        color: k_blue,
        label: "${AppLocalization.of(context).translate("Send_verified_code")}",
        onPress: () async {
          resetPassword(_phoneController.toString());
        },
      ),
    );
  }
}
