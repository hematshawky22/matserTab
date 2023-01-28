import 'package:flutter/material.dart';

import 'package:e_wallet_mobile_app/pages/widgets/custom_elevated_button.dart';

class CustomButtonNavigationBar extends StatelessWidget {
  final Color color;
  final String label;
  final String? imagePath;
  final Function()? onPress;
  const CustomButtonNavigationBar({
    Key? key,
    required this.color,
    required this.label,
    this.imagePath,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
        onPressed: onPress,
        elevation: 0.0,
        color: color,
        imageIconPath: imagePath,
        label: label,

    );
  }
}


   // showDialog(
          //   context: context,
          //   builder: (ctx) => CustomAlertSuccessPayment(
          //     message: "The amount has been sent successfully!",
          //   ),
          // );