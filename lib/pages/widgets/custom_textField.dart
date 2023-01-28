import 'package:flutter/material.dart';

import 'package:e_wallet_mobile_app/styles/constant.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String? hint;
  final Function ?validate;
  final Function? onsave;
  final TextEditingController ?textEditingController;
  String? initialValue;
   CustomTextField({
    Key? key,
     this.onsave,
     required this.title,
     this.hint,
     this.validate,
     this.textEditingController,
    this.initialValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
borderRadius: BorderRadius.circular(10)
          ),
          child: TextFormField(

            initialValue: initialValue,

            style: Theme.of(context).textTheme.headline2,
            controller: textEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 14),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: k_greyBorder,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: k_greyBorder,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
