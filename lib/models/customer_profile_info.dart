import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class CustomerInfo {
  String ?f_name;
  String ? l_name;
  String ? phone;
  int ? type;
  String ? gender;
  String ? qr_code;
  int ? balance;
  String  ? unique_id;
  String? occupation;
  String ?fcm_token;
  int ?is_kyc_verified;

  CustomerInfo({this.f_name, this.l_name, this.phone, this.type, this.gender,
      this.qr_code, this.balance, this.fcm_token, this.is_kyc_verified,
      this.occupation, this.unique_id});

  factory CustomerInfo.fromjson(Map<String, dynamic> json){
    return CustomerInfo(
        f_name: json["f_name"],
        l_name: json["l_name"],
        phone: json["phone"],
        type: json["type"],
        gender: json["gender"],
        qr_code: json["qr_code"],
        balance:json["balance"],
        fcm_token:json["fcm_token"],
        is_kyc_verified:json["is_kyc_verified"],
        occupation:json["occupation"],
        unique_id:json["unique_id"]);
  }

}