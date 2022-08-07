import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';

class QRCardPage extends StatelessWidget {
  const QRCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Card"),
        backgroundColor: AppCustomColors.primaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Scan this to explore your QR card",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            QrImage(
              data: 'This is a simple QR code',
              version: QrVersions.auto,
              size: 250,
              gapless: false,
            ),
            Text(
              "This feature is coming soon!",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
