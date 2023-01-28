import 'package:e_wallet_mobile_app/models/app_localization.dart';
import 'package:e_wallet_mobile_app/models/my_requests.dart';
import 'package:e_wallet_mobile_app/pages/widgets/custom_elevated_button.dart';
import 'package:e_wallet_mobile_app/pages/widgets/user_image.dart';
import 'package:e_wallet_mobile_app/styles/constant.dart';
import 'package:flutter/material.dart';

import 'package:e_wallet_mobile_app/models/user_model.dart';

class BuildUserRequestItem extends StatelessWidget {
  final RequestedMoney? requestedMoney;
  final int ? offset;
  const BuildUserRequestItem({
    Key? key,
    this.requestedMoney,
    this.offset
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            UserImage(imagePath: k_imagePath, raduis: 50),
          ],
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${requestedMoney!.sender!.name}",
                style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${requestedMoney!.amount}",
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        Container(
          width: 90,
          height: 40,
          child: CustomElevatedButton(
            color: k_yellow,
            imageIconPath: "assets/images/send_icon.png",
            label: "${AppLocalization.of(context).translate("Send")}",
            elevation: 0.0,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
