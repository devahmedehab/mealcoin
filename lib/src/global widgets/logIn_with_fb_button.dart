import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';

class LogInWithFbButton extends StatelessWidget {
  final String buttonText;
  final String image;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final Color? iconColor;
  final double? borderRadius;
  final Color? backgroundColor;

  const LogInWithFbButton({
    Key? key,
    required this.buttonText,
    this.onPressed,
    required this.image,
    this.textStyle,
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: KSize.getHeight(context, 54),
        width: context.screenWidth,
        decoration: BoxDecoration(
            color: backgroundColor ?? (Colors.blue.shade900),
            borderRadius: BorderRadius.circular(borderRadius ?? 12.0)),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          onPressed: onPressed,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Transform.translate(
                offset: Offset(-22, 0),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: KSize.getWidth(context, 6),
                    top: KSize.getHeight(context, 6),
                    bottom: KSize.getHeight(context, 6),
                  ),
                  child: Image.asset(
                    image,
                    height: height,
                    width: width,
                    fit: BoxFit.contain,
                    color: iconColor ?? null,
                  ),
                ),
              ),
              //Spacer(),
              Transform.translate(
                  offset: Offset(-15, 0),
                  child: Text(buttonText, style: textStyle
                      //SignInScreen != null?KTextStyle.bodyText:KTextStyle.overLine
                      )),
              //Spacer()
            ],
          ),
          //color: Color(0xff00CC96),
        ));
  }
}
