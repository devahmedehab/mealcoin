import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MyDialog {
  static void loadingDialog(BuildContext context, String message) {
    Get.defaultDialog(
      title: "",
      content: Container(
        height: 230.0,
        width: 230.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Image.asset(
                  'assets/icons/chefs_heart_white_background.gif',
                  height: 60,
                  width: 60,
                )),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                '$message'.toUpperCase(),
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void closeDialog(BuildContext context) {
    if (Get.isDialogOpen!) {
      Navigator.pop(context);
    }
  }
}
