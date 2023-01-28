import 'dart:convert';

import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/models/customer_profile_info.dart';
import 'package:e_wallet_mobile_app/models/customer_transaction.dart';
import 'package:e_wallet_mobile_app/pages/screens/contacts/screens/contacts_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/home/screens/requests_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/profile/screens/profile_screen.dart';
import 'package:e_wallet_mobile_app/pages/screens/transactions/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

import 'package:e_wallet_mobile_app/models/user_model.dart';
import 'package:e_wallet_mobile_app/pages/screens/home/widgets/build_home_user_item.dart';
import 'package:e_wallet_mobile_app/pages/widgets/user_image.dart';
import 'package:e_wallet_mobile_app/styles/Iconly-Broken_icons.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:e_wallet_mobile_app/styles/size_config.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomerTransaction? customerTransaction;
  int Userid = 0;
  CustomerInfo? customerInfo;

  @override
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
      getcustomeerInfo();
    }
  }

  getcustomeerInfo() async {
    final response = await http.get(Uri.parse(
        "https://mastertab.hekal.info/api/v1/employee/get-employee?id=${Userid}"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      customerInfo = CustomerInfo.fromjson(data);
      print(data);
    }
  }

  getcustomeerTransaction() async {
    final response = await http.get(Uri.parse(
        "https://mastertab.hekal.info/api/v1/employee/transaction-history?id=${Userid}&limit=50&transaction_type=2"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      customerTransaction = CustomerTransaction.fromJson(data);
      setState(() {});
      print(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future:getcustomeerTransaction(),
          builder: (context,snapshot){
            if(customerTransaction == null){
              return Center(
                child: Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            else{
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        color: k_blue,
                        width: SizeConfig.screenWidth,
                        height: 270,
                      ),
                      Container(
                        height: 270,
                        width: SizeConfig.screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${AppLocalization.of(context).translate("master_tap")}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProfileScreen()));
                                    },
                                    child: Container(
                                        height: 80,
                                        child: Lottie.asset(
                                            'assets/images/profile.json')),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0),
                              Text(
                                customerInfo == null
                                    ? ""
                                    : customerInfo!.f_name.toString() +
                                    " " +
                                    customerInfo!.l_name.toString(),
                                style: TextStyle(color: Colors.white54, fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "${AppLocalization.of(context).translate("total_balance")}",
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(height: 0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    customerInfo == null
                                        ? "0"
                                        : "  ${customerInfo!.balance}  ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                      fontSize: 25,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Get.to(() => RequestsScreen()),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Container(
                                          child: Icon(
                                            Iconly_Broken.Notification,
                                            color: Colors.white,
                                            size: 33,
                                          ),
                                        ),
                                        Container(
                                          width: 9,
                                          height: 9,
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppLocalization.of(context).translate("The_last_dealings")}",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TransactionsScreen()));
                            },
                            child: Text(
                              "${AppLocalization.of(context).translate("view_all")} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: getcustomeerTransaction(),
                      builder: (context, snapshot) {
                        if (customerTransaction == null) {
                          return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * 0.2),
                                child: CircularProgressIndicator(),
                              ));
                        }
                        if (customerTransaction!.transactions!.isEmpty) {
                          return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * 0.2),
                                child: Text(
                                  "There is no transactions ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(fontSize: 16),
                                ),
                              ));
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: customerTransaction!.transactions!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return BuildHomeUserItem(
                                    transaction:
                                    customerTransaction!.transactions![index],
                                    offset: customerTransaction!.offset!);
                              });
                        }
                      }
                  )
                ],
              );
            }
          },

        ),
      ),
    );
  }
}
