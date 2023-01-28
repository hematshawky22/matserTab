import 'dart:convert';

import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/models/customer_profile_info.dart';
import 'package:flutter/material.dart';

import 'package:e_wallet_mobile_app/models/user_model.dart';
import 'package:e_wallet_mobile_app/pages/widgets/user_image.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/customer_transaction.dart';

class BuildHomeUserItem extends StatefulWidget {
  final Transactions transaction;
  final int offset;

   BuildHomeUserItem(
      {Key? key, required this.transaction, required this.offset})
      : super(key: key);

  @override
  State<BuildHomeUserItem> createState() => _BuildHomeUserItemState();
}


class _BuildHomeUserItemState extends State<BuildHomeUserItem> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              UserImage(imagePath: k_imagePath, raduis: 50),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 10,
                child: widget.offset == 1
                    ? Image.asset("assets/images/request_icon.png",
                        color: k_blue)
                    : Image.asset("assets/images/send_icon.png",
                        color: k_yellow),
              ),
            ],
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.offset == 1
                      ? "${widget.transaction.sender!.name}"
                      : "${widget.transaction.receiver!.name}",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${widget.transaction.createdAt.toString()}",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
          ),
          Text(
            "${widget.transaction.amount} ${AppLocalization.of(context).translate("LE")} ",
            style: Theme.of(context).textTheme.headline2,
          )
        ],
      ),
    );
  }
}
