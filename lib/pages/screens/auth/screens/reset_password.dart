import 'dart:convert';

import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/pages/screens/auth/screens/main_auth_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/e-wallet_layout/e-wallet_layout_screen.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_button_navigation_bar.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_textField.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart'as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class ResetPassword extends StatefulWidget {
  String phone;
  String otp;
   ResetPassword({Key? key ,required this.phone,required this.otp}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController phoneController =TextEditingController();
  TextEditingController otpController=TextEditingController();
  TextEditingController newPassword=TextEditingController();
  TextEditingController ConfirmPassword=TextEditingController();

  Future<void> cahangePassword(var phone, var otp,var newpassword,var confirmPassword) async {
    if (otpController.text.isNotEmpty) {
      final ProgressDialog pr = ProgressDialog(context,
          type: ProgressDialogType.normal,
          isDismissible: false,
          showLogs: true);
      pr.show();
      String url =
          "https://mastertab.hekal.info/api/v1/employee/auth/reset-password?phone=${phoneController}&otp=${otpController}&password=${newPassword}&confirm_password=${confirmPassword}";

      http.Response response = await http.put(Uri.parse(url), body: {
        'phone': phoneController.text.toString(),
        "otp":otpController.text.toString(),
        "password":newPassword.text.toString(),
        "confirm_password":ConfirmPassword.text.toString()
      });
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data.toString());
        Fluttertoast.showToast(
            msg: "password Changed Successfully !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        pr.hide();
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainAuthScreen()))   ;   } else {
        pr.hide();
      }
    } else {
      Fluttertoast.showToast(
          msg: "Password is Empty !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneController.text =widget.phone.toString();
    otpController.text =widget.otp.toString();
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
          "${AppLocalization.of(context).translate("change_password")}",
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 100,),
            CustomTextField(
              onsave: () {},
              validate: () {},
              title: "${AppLocalization.of(context).translate("Enter_new_password")}",
              hint:
              "${AppLocalization.of(context).translate("Enter_new_password")}",

              textEditingController: newPassword,
            ),
            SizedBox(height: 100,),
            CustomTextField(
              onsave: () {},
              validate: () {},
              title: "${AppLocalization.of(context).translate("confirm_new_password")}",
              hint:
              "${AppLocalization.of(context).translate("confirm_new_password")}",
              textEditingController:  ConfirmPassword         ),
          ],
        ),
      ),
      bottomNavigationBar: CustomButtonNavigationBar(
        color: k_blue,
        label: "${AppLocalization.of(context).translate("change_password")}",
        onPress: () async {
          cahangePassword(phoneController.text,otpController.text,newPassword.text,ConfirmPassword.text);
        },
      ),
    );
  }
}
