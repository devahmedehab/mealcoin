import 'package:flutter/material.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class OnBoardingPage1 extends StatefulWidget {
  const OnBoardingPage1({Key? key}) : super(key: key);

  @override
  _OnBoardingPage1State createState() => _OnBoardingPage1State();
}

class _OnBoardingPage1State extends State<OnBoardingPage1> {
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KColor.white,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: KSize.getHeight(context, 60)),
            Hero(
              tag: "splashlogo",
              child: Image.asset(
                'assets/icons/logo.png',
                height: KSize.getHeight(context, 92),
                width: KSize.getWidth(context, 206),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: KSize.getHeight(context, 40)),
            Padding(
              padding: EdgeInsets.only(
                  left: KSize.getWidth(context, 25),
                  right: KSize.getWidth(context, 21)),
              child: Image.asset('assets/images/foodImage1.png',
                  height: KSize.getHeight(context, 142),
                  width: double.infinity,
                  fit: BoxFit.cover),
            ),
            SizedBox(height: KSize.getHeight(context, 27)),
            Padding(
              padding: EdgeInsets.only(
                  left: KSize.getWidth(context, 23),
                  right: KSize.getWidth(context, 24)),
              child: Container(
                height: KSize.getHeight(context, 80),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppCustomColors.primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      'Fresh Meals & Catering',
                      style:
                          KTextStyle.subTitle2.copyWith(fontSize: _height / 42),
                    ),
                    Text(
                      'from Selected Restaurants & Chefs',
                      textAlign: TextAlign.center,
                      style: KTextStyle.overLine.copyWith(
                          fontSize: _height / 72,
                          height: 1.5,
                          color: KColor.white,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(height: KSize.getHeight(context, 27)),
            Padding(
              padding: EdgeInsets.only(
                  left: KSize.getWidth(context, 26),
                  right: KSize.getWidth(context, 20)),
              child: Image.asset(
                'assets/images/foodImage2.png',
                height: KSize.getHeight(context, 142),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
