import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_button_navigation_bar.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_textField.dart';
import 'package:e_wallet_mobile_app/pages/widgets/user_image.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../models/customer_profile_info.dart';

class EditProfileScreen extends StatefulWidget {
  CustomerInfo? info;
  int? id;

  EditProfileScreen({Key? key, this.info, this.id}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  var selectedGender;

  TextEditingController _fnameTextEditingController = TextEditingController();

  TextEditingController _occupationTextEditingController =
      TextEditingController();

  TextEditingController _lnameTextEditingController = TextEditingController();
  TextEditingController _genderTextEditingController = TextEditingController();
  bool showSpinner = false;
  final picker = ImagePicker();

  void updateUser() async {
    var response = await http.put(
        Uri.parse(
            "https://mastertab.hekal.info/api/v1/customer/update-profile?id=${widget.id}&f_name=${widget.info!.f_name}&l_name=${widget.info!.l_name}&gender=${widget.info!.gender}&occupation=${widget.info!.occupation}"),
        body: {
          "id": widget.id.toString(),
          "f_name": _fnameTextEditingController.text.toString(),
          "l_name": _lnameTextEditingController.text.toString(),
          "gender": _genderTextEditingController.text.toString(),
          "occupation": _occupationTextEditingController.text.toString()
        });
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Updated Successfully !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      print(response);
      print(widget.id);
    } else {
      Fluttertoast.showToast(
          msg: "Not Updated !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
// toast here
    }
  }

  @override
  void initState() {
    _occupationTextEditingController.text = widget.info!.occupation.toString();
    _genderTextEditingController.text = widget.info!.gender.toString();
    _fnameTextEditingController.text = widget.info!.f_name.toString();
    _lnameTextEditingController.text = widget.info!.l_name.toString();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20),

          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "${AppLocalization.of(context).translate("My_Info")}",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      UserImage(imagePath: k_imagePath, raduis: 100),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "${AppLocalization.of(context).translate("Upload_Image")}",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  onsave: () {},
                  validate: () {},
                  title: "${AppLocalization.of(context).translate("fname")}",
                  hint:
                      "${AppLocalization.of(context).translate("Enter_your_name")}",
                  textEditingController: _fnameTextEditingController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  onsave: () {},
                  validate: () {},
                  title: "${AppLocalization.of(context).translate("lname")}",
                  hint:
                      "${AppLocalization.of(context).translate("Enter_your_name")}",
                  textEditingController: _lnameTextEditingController,
                ),
                SizedBox(height: 20),
                Text(
                  "${AppLocalization.of(context).translate("choose_gender")}",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 14),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.2)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButton(
                      dropdownColor: Colors.grey.shade300,
                      isExpanded: true,
                      hint: Text(
                          "${AppLocalization.of(context).translate("gender")}"),
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 17),
                      items: ["${AppLocalization.of(context).translate("Male")}", "${AppLocalization.of(context).translate("Female")}"]
                          .map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _genderTextEditingController.text = value.toString();
                        });
                      },
                      value: _genderTextEditingController.text,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  onsave: () {},
                  validate: () {},
                  title:
                      "${AppLocalization.of(context).translate("Occupation_")}",
                  hint:
                      "${AppLocalization.of(context).translate("Enter_your_Occupation")}",
                  textEditingController: _occupationTextEditingController,
                ),
              ],
            ),
          ),
        )),
        bottomNavigationBar: CustomButtonNavigationBar(
          color: k_blue,
          label: "${AppLocalization.of(context).translate("Save_Changes")}",
          onPress: () {
            updateUser();
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.close, color: Colors.black),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      ),
    );
  }
}
