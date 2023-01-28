import 'dart:async';
import 'dart:convert';
import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/pages/screens/auth/screens/login_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/auth/screens/register_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/auth/widgets/curve_painter.dart';
import 'package:e_wallet_mobile_app/pages/screens/home/screens/localization_services.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_elevated_button.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:e_wallet_mobile_app/styles/size_config.dart';
import 'package:e_wallet_mobile_app/styles/t_keys.dart';
import 'package:e_wallet_mobile_app/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_wallet_mobile_app/pages/screens/auth/screens/forget_password_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/e-wallet_layout/e-wallet_layout_screen.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_textField.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainAuthScreen extends StatefulWidget {
  @override
  State<MainAuthScreen> createState() => _MainAuthScreenState();
}

class _MainAuthScreenState extends State<MainAuthScreen> {
  TextEditingController _phoneController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? phone;
  String? password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


    @override
    Future<void> login(var phone, var password) async {
      if (_phoneController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        final ProgressDialog pr = ProgressDialog(
            context, type: ProgressDialogType.normal,
            isDismissible: false,
            showLogs: true);
        pr.show();

        String url = "https://mastertab.hekal.info/api/v1/employee/auth/login?phone=${_phoneController}&password=${_passwordController}";
        SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

        http.Response response = await http.post(Uri.parse(url), body: {
          'phone': _phoneController.text,
          'password': _passwordController.text
        });
        print(response.body);
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body.toString());
          print("login successfully");
          sharedPreferences.setString("login", data["content"]);
          sharedPreferences.setInt("id", data["id"]);
          pr.hide();
          Get.off(() => E_WalletLayoutScreen());
        } else {
          pr.hide();
          Fluttertoast.showToast(
              msg: "User Or Password Error !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          print("you are not allowed");
        }
      } else {
        Fluttertoast.showToast(
            msg: "User Or Password is Empty !",
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
    // TODO: implement build
      SizeConfig.init(context);
      return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.95,
                  child: Stack(
                    children: [
                      Container(
                        width: SizeConfig.screenWidth,
                        height: double.infinity - 50,
                        child: CustomPaint(
                          foregroundPainter: CurvePainter(
                            rightHeight: 0.68,
                            leftHeight: 0.7,
                            color: Theme
                                .of(context)
                                .backgroundColor,
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        height: double.infinity - 50,
                        child: CustomPaint(
                          foregroundPainter: CurvePainter(
                            rightHeight: 0.68,
                            leftHeight: 0.7,
                            color: k_blue,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/Icon.png"),
                            SizedBox(height: 10),
                            Text(
                              "${AppLocalization.of(context).translate("master_tap")}",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 30),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "${AppLocalization.of(context).translate(
                                  "best")}",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 14),
                            ),
                            SizedBox(height: 50),
                            Container(
                                child: Opacity(
                                  opacity: 1,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                        )),
                                    color: Theme
                                        .of(context)
                                        .backgroundColor,
                                    elevation: 10,
                                    margin: EdgeInsets.all(20),
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            "${AppLocalization.of(context)
                                                .translate("Phone")}",
                                            style:
                                            Theme
                                                .of(context)
                                                .textTheme
                                                .headline2,
                                          ),
                                          SizedBox(height: 10),
                                          TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "${AppLocalization.of(
                                                    context).translate(
                                                    "phone_mustnot_be_empty")}";
                                              }
                                            },
                                            onSaved: (value) {
                                              password = value;
                                            },
                                            style:
                                            Theme
                                                .of(context)
                                                .textTheme
                                                .headline2,
                                            controller: _phoneController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText:
                                              "${AppLocalization.of(context)
                                                  .translate(
                                                  "Enter_your_phone")}",
                                              hintStyle: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline3!
                                                  .copyWith(fontSize: 14),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                                borderSide: BorderSide(
                                                  color: k_greyBorder,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                                borderSide: BorderSide(
                                                  color: k_greyBorder,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${AppLocalization.of(
                                                        context).translate(
                                                        "Password")}",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .headline2,
                                                  ),
                                                  SizedBox(height: 10),
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "${AppLocalization
                                                            .of(context)
                                                            .translate(
                                                            "password_empty")}";
                                                      }
                                                    },
                                                    onSaved: (value) {
                                                      password = value;
                                                    },
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .headline2,
                                                    controller: _passwordController,
                                                    keyboardType: TextInputType
                                                        .text,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                      "${AppLocalization.of(
                                                          context).translate(
                                                          "Enter_your_password")}",
                                                      hintStyle: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .headline3!
                                                          .copyWith(
                                                          fontSize: 14),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                        borderSide: BorderSide(
                                                          color: k_greyBorder,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                        borderSide: BorderSide(
                                                          color: k_greyBorder,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              GestureDetector(
                                                onTap: () =>
                                                    Get.to(
                                                            () =>
                                                            ForgetPasswordScreen()),
                                                child: Text(
                                                  "${AppLocalization.of(context)
                                                      .translate(
                                                      "Forget_password")}",
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline4,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 30),
                                          Container(
                                            width: SizeConfig.screenWidth *
                                                0.75,
                                            child: CustomElevatedButton(
                                                label:
                                                "${AppLocalization.of(context)
                                                    .translate("login")}",
                                                color: k_blue,
                                                onPressed: () async {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    formKey.currentState!
                                                        .save();
                                                    login(
                                                        _phoneController.text
                                                            .toString(),
                                                        _passwordController.text
                                                            .toString());
                                                  }
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  }
}