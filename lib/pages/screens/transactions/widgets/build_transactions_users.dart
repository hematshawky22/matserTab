



import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/models/customer_transaction.dart';
import 'package:e_wallet_mobile_app/models/user_model.dart';
import 'package:e_wallet_mobile_app/pages/widgets/user_image.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:flutter/material.dart';

class BuildUserTransaction extends StatelessWidget {
  final Transactions transaction;
  final int  offset;
  const BuildUserTransaction({
    Key? key,
    required this.transaction,
    required this.offset
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            UserImage(imagePath: k_imagePath, raduis: 50),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10,
              child: transaction.transactionType != "send_money"
                  ? Image.asset("assets/images/request_icon.png",
                  color: k_blue)
                  : Image.asset("assets/images/send_icon.png",
                  color: k_yellow),
            ),          ],
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
          transaction.transactionType != "send_money"
          ? "${transaction.sender!.name}"
              : "${transaction.receiver!.name}",
                style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${transaction.createdAt}",
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        Text(
          "${transaction.amount} ${AppLocalization.of(context).translate("LE")} ",
          style: Theme.of(context).textTheme.headline2,
        )
      ],
    );
  }
}
