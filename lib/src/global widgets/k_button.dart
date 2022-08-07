import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class KButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final double? borderRadius;

  const KButton({
    Key? key,
    required this.buttonText,
    this.onPressed,
    this.borderRadius = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: KSize.getHeight(context, 54),
        width: context.screenWidth,
        decoration: BoxDecoration(
          color: KColor.primary,
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: KColor.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          onPressed: onPressed,
          child: Text(buttonText,
              style: KTextStyle.headline7.copyWith(
                  color: KColor.white,
                  //decoration: TextDecoration.underline,
                  decorationColor: KColor.white)),
          //color: Color(0xff00CC96),
        ));
  }
}
