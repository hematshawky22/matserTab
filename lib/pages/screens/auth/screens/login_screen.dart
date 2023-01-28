import 'dart:convert';

import 'package:e_wallet_mobile_app/pages/screens/auth/screens/forget_password_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/auth/screens/register_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/e-wallet_layout/e-wallet_layout_screen.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_elevated_button.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_textField.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:e_wallet_mobile_app/styles/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void login(String? phone,String? password)async{
    try{
     http.Response response = await http.post(Uri.parse("https://mastertab.hekal.info/api/v1/customer/auth/login?phone=01101013288&password=1111"),
     body: {
       "phone":phone,
       "password":password

     });
     if(response.statusCode==200){
       var data = jsonDecode(response.body.toString());
       print(data);
       print("login successfully");
     }
     else {
       print(response.body);
     }
    }catch(error){
      print(error.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                  "Login and start transfering",
                  style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 32),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        label: "Google",
                        color: k_grey,
                        elevation: 0.0,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: CustomElevatedButton(
                        label: "Facebook",
                        color: k_grey,
                        elevation: 0.0,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 70),
                CustomTextField(
                  onsave: (){},
                  validate: (){},
                  title: "Email",
                  hint: "Enter your email",
                  textEditingController: _emailController,
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomTextField(
                      onsave: (){},
                      validate: (){},
                      title: "Password",
                      hint: "Enter your password",
                      textEditingController: _passwordController,
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => Get.to(() => ForgetPasswordScreen()),
                      child: Text(
                        "Forget password?",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  width: SizeConfig.screenWidth * 0.75,
                  child: CustomElevatedButton(
                    label: "Login",
                    color: k_blue,
                    onPressed: () {
                      login(_emailController.text.toString(),_passwordController.text.toString());
                      Get.off(() => E_WalletLayoutScreen());

                    }
                  ),
                ),
                SizedBox(height: 7),
                TextButton(
                  onPressed: () => Get.off(() => RegisterScreen()),
                  child: Text(
                    "Create a new account",
                    style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
