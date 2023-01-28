import 'dart:convert';

import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/models/requests.dart';
import 'package:e_wallet_mobile_app/models/user_model.dart';
import 'package:e_wallet_mobile_app/pages/screens/contacts/screens/search_contacts.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/contact_item.dart';
import 'package:http/http.dart' as http;

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  List<RequestsModel> requests = [];
  int Userid = 0;

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

  Future<List<RequestsModel>> getcustomrRequests(int type) async {
    var data = [];
    final response = await http.get(Uri.parse(
        "https://mastertab.hekal.info/api/v1/customer/get-contacts?type=${type}"));
    print(response.body.toString());
    data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      requests = data.map((e) => RequestsModel.fromJson(e)).toList();
    } else {
      print("error ");
    }
    return requests;
  }

  updateList(String? query) {
    setState(() {
      requests = requests
          .where((element) =>
              element.fName!.toLowerCase().contains(query!.toLowerCase()))
          .toList();
    });
    return requests;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: Text(
                "${AppLocalization.of(context).translate("Contacts")}",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 22),
              ),
              centerTitle: true,
              actions: [
                SizedBox(width: 10),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: k_fontGrey),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      onChanged: (value) {
                        updateList(value);
                      },
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText:
                            "${AppLocalization.of(context).translate("Customer_name")}",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 15),
                        border: InputBorder.none,
                        prefixIcon: InkWell(
                            onTap: () {},
                            child: Image.asset("assets/images/search_icon.png",
                                color: Colors.grey)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: getcustomrRequests(3),
              builder: (context, snapshot) {
                if (requests == null) {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.2),
                    child: CircularProgressIndicator(),
                  ));
                }
                if (requests.isEmpty) {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.2),
                    child: Text(
                      " ",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 16),
                    ),
                  ));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: requests.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 15);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return BuildContactItem(requests: requests[index]);
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
