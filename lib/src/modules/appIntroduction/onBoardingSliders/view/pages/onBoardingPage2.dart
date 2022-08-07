import 'package:flutter/material.dart';

import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class OnBoardingPage2 extends StatelessWidget {
  const OnBoardingPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KColor.white,
      // extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 11)),
        child: Column(
          children: [
            SizedBox(height: _height / 14),
            Image.asset(
              'assets/images/logo2.png',
              // height: KSize.getHeight(context, _width/4),
              width: KSize.getWidth(context, _width / 4),
              fit: BoxFit.contain,
            ),
            SizedBox(height: 12),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 0)),
              child: Text(
                'Discover Top Chefs and Restaurants by City',
                textAlign: TextAlign.center,
                style: KTextStyle.subTitle3.copyWith(
                  fontSize: _width / 22,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: _height / 24),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 0)),
              child: Image.asset('assets/images/countryImage.png',
                  height: _height / 2.1,
                  width: double.infinity,
                  fit: BoxFit.fill),
            )
          ],
        ),
      ),
    );
  }
}
