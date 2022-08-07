import 'package:flutter/cupertino.dart';

import '../colors.dart';

Widget customTextWidget(String textMessage, double fontSize,
    FontWeight fontWeight, Color fontColor) {
  return Text(
    textMessage,
    style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}
