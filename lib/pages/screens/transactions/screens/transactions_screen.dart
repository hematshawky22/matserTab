import 'dart:convert';

import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/models/customer_profile_info.dart';
import 'package:e_wallet_mobile_app/models/customer_transaction.dart';
import 'package:e_wallet_mobile_app/pages/screens/transactions/widgets/build_transactions_users.dart';
import 'package:flutter/material.dart';

import 'package:e_wallet_mobile_app/models/user_model.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  bool _toggleButton = false;
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
      getcustomeerTransaction(1);
    }
  }

  getcustomeerTransaction(int transactiontype) async {
    final ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);
    pr.show();

    final response = await http.get(Uri.parse(
        "https://mastertab.hekal.info/api/v1/employee/transaction-history?id=${Userid}&limit=50&transaction_type=${transactiontype}"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      customerTransaction = CustomerTransaction.fromJson(data);
      setState(() {});
      print(data);
      pr.hide();
    } else {
      pr.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Text(
                "${AppLocalization.of(context).translate("transactions")}",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 22),
              ),
              centerTitle: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: k_grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                              "${AppLocalization.of(context).translate("Sender")}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          onPressed: () {
                            setState(() {
                              _toggleButton = true;
                              getcustomeerTransaction(2);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: _toggleButton ? k_yellow : k_grey,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                              "${AppLocalization.of(context).translate("incoming")}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          onPressed: () {
                            setState(() {
                              _toggleButton = false;
                              getcustomeerTransaction(1);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: _toggleButton ? k_grey : k_yellow,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
              child: customerTransaction == null
                  ? Center()
                  : FutureBuilder(
                      future: getcustomeerTransaction(1),
                      builder: (context, snapshot) {
                        if (customerTransaction == null) {
                          return Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.2),
                            child: CircularProgressIndicator(),
                          ));
                        }
                        if (customerTransaction!.transactions!.isEmpty) {
                          return Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.2),
                            child: Text(
                              "There is no transactions ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(fontSize: 16),
                            ),
                          ));
                        } else {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                customerTransaction!.transactions!.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(height: 15);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return BuildUserTransaction(
                                transaction:
                                    customerTransaction!.transactions![index],
                                offset: customerTransaction!.offset!,
                              );
                            },
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
