import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/modules/appIntroduction/onBoardingSliders/view/onBoardingScreen.dart';
import 'package:chefsandmeals_customer/src/modules/appIntroduction/splashScreen/controller/splashScreenController.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/view/firsthubSelectionScreen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/view/landingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigationPage(int rout) {
    Future.delayed(Duration(milliseconds: 1500), () {
      if (rout == 0) {
        Get.off(() => OnBoardingPage());
      } else if (rout == 1) {
        Get.off(() => FirstHubSelection());
      } else if (rout == 2) {
        Get.off(() => LandingScreen());
      }
    });
  }

  final controller = Get.put(SplashController());

  @override
  void initState() {
    getRout();
    super.initState();
  }

  getRout() async {
    var rout = await controller.getRout();
    navigationPage(rout);
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(color: AppCustomColors.whiteColor),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "splashlogo",
                    child: Image.asset(
                      "assets/icons/logo.png",
                      height: _width / 1.6,
                      width: _width / 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
