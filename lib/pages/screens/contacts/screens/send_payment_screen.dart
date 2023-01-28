import 'dart:convert';

import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/models/customer_info.dart';
import 'package:e_wallet_mobile_app/models/requests.dart';
import 'package:e_wallet_mobile_app/pages/screens/contacts/screens/contacts_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/contacts/widgets/custom_alert_sucess_payment.dart';
import 'package:e_wallet_mobile_app/pages/screens/contacts/widgets/payment_amount_textField.dart';
import 'package:e_wallet_mobile_app/pages/screens/contacts/widgets/payment_note_textField.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_button_navigation_bar.dart';
import 'package:e_wallet_mobile_app/pages/widgets/user_image.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:flutter/material.dart';

import 'package:e_wallet_mobile_app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SendPaymentScreen extends StatefulWidget {
  RequestsModel requests;

  SendPaymentScreen({
    Key? key,
    required this.requests,
  }) : super(key: key);

  @override
  State<SendPaymentScreen> createState() => _SendPaymentScreenState();
}

class _SendPaymentScreenState extends State<SendPaymentScreen> {
  final TextEditingController _amountTextEditingController = TextEditingController();

  final TextEditingController _noteTextEditingController = TextEditingController();
  int Userid=0;
  CustomerInfo? customerInfo;
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
      customerInfo = CustomerInfo.fromJson(data);
      print(data);
    }
  }
  int pin=1111;
  sendMoney() async {
    final response = await http.post(Uri.parse(
      "https://mastertab.hekal.info/api/v1/employee/send-money?pin=1111&from_phone=${customerInfo!.phone}&amount=${_amountTextEditingController}&id=${Userid}&to_phone=${widget.requests.phone}"
      ),body: {
      "amount":_amountTextEditingController.text.toString(),
      "id":Userid.toString(),
      "to_phone":widget.requests.phone.toString(),
      "pin":pin.toString()
    });
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
       widget.requests= RequestsModel.fromJson(data);
      setState(() {});
      print(data);
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (ctx) =>
          CustomAlertSuccessPayment(message: "The amount has been sent successfully!"));
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: k_black),
              onPressed: () => Get.back(),
            ),
            title: Text(
              "${AppLocalization.of(context).translate("Send_Money")}",
              style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: FutureBuilder(
            future: getcustomeerInfo(),
            builder: (context ,snapshot){
              if (customerInfo==null) {
                return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.2),
                      child: CircularProgressIndicator(),
                    ));
              }
              else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                      child: Row(
                        children: [
                          UserImage(imagePath: k_imagePath, raduis: 50),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.requests.fName}",
                                  style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${widget.requests.email}",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: PaymentAmountTextField(
                        color: k_yellow,
                        textEditingController: _amountTextEditingController,
                        title: "${AppLocalization.of(context).translate("Payment_Amount")}",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: PaymentNoteTextField(
                        textEditingController: _noteTextEditingController,
                      ),
                    ),
                  ],
                ),
              );}
            },

          ),
          bottomNavigationBar: CustomButtonNavigationBar(
            color: k_yellow,
            label: "${AppLocalization.of(context).translate("Send_Payment")}",
            imagePath: "assets/images/send_icon.png",
            onPress: () {
              sendMoney();
            },
          )),
    );
  }
}
