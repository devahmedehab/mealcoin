import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/sharedPreference.dart';
import 'package:chefsandmeals_customer/src/common/strings.dart';
import 'package:chefsandmeals_customer/src/modules/appIntroduction/onBoardingSliders/controller/onBoardingPageController.dart';

import 'landingScreen.dart';
import 'widget/hubSelectionModal.dart';

class FirstHubSelection extends GetView {
  final controller = Get.put(OnBoardingController());

  final SharedPref sharedPref = SharedPref();

  final Random random = Random();
  final List<DropdownMenuItem> items = [];

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: AppCustomColors.whiteColor,
        padding: EdgeInsets.symmetric(horizontal: _width / 18),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: _height / 12,
            ),
            Image.asset(
              'assets/images/logo3.png',
              height: _height / 8,
              width: _height / 8,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: _height / 55,
            ),
            Obx(() => controller.nearestHubs.length == 0
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        //margin: EdgeInsets.only(bottom: _height/54),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(color: AppCustomColors.greyTextColor.withOpacity(0.5),width: 1.5),
                              color: AppCustomColors.containerBgColor
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: _width / 52, vertical: _width / 85),
                            margin: EdgeInsets.only(bottom: _height / 54),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    height: _width / 8,
                                    width: _width / 8,
                                    color: AppCustomColors.containerBgColor
                                        .withOpacity(0.4),
                                  ),
                                ),
                                SizedBox(
                                  width: _width / 24,
                                ),
                                Container(
                                  height: _height / 42,
                                  width: _width / ((1.55 + random.nextInt(2))),
                                  color: AppCustomColors.containerBgColor
                                      .withOpacity(0.4),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await sharedPref.setUserAppData(
                              SharedPrefStrings.hubName,
                              controller.nearestHubs[index].name!);

                          await sharedPref.setUserAppData(
                              SharedPrefStrings.hubId,
                              controller.nearestHubs[index].id.toString());
                          controller.setRout(2);

                          await controller.updateHubRecommendationScore(
                              controller.nearestHubs[index].id!);
                          Get.to(() => LandingScreen());
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: _height / 54),
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _width / 52,
                                  vertical: _width / 85),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      controller.nearestHubs[index].picture!,
                                      height: _width / 8,
                                      width: _width / 8,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: _width / 24,
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.nearestHubs[index].name!,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        decoration: TextDecoration.none,
                                        fontSize: _width / 22,
                                        color: AppCustomColors.blackColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            SizedBox(
              height: _height / 55,
            ),
            Text(
              "Please select your Location",
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7)),
            ),
            SizedBox(
              height: _height / 55,
            ),
            GestureDetector(
              onTap: () async {
                await hubSelectionModalWidget(context, "H");
              },
              child: Container(
                width: _width,
                height: _height / 16,
                decoration: BoxDecoration(
                  // border: Border.all(color: AppCustomColors.primaryColor.withOpacity(0.5),width: 3),
                  color: AppCustomColors.whiteColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(15.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: _width / 55),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "By Locality or Hub",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.none,
                              fontSize: _width / 26,
                              color: AppCustomColors.greyTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppCustomColors.greyTextColor,
                          )
                        ],
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Divider(
                  color: AppCustomColors.greyTextColor,
                  thickness: 1,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Or",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.none,
                      fontSize: 14,
                      color: AppCustomColors.greyTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () async {
                await hubSelectionModalWidget(context, "C");
              },
              child: Container(
                width: _width,
                height: _height / 16,
                decoration: BoxDecoration(
                  // border: Border.all(color: AppCustomColors.primaryColor.withOpacity(0.5),width: 3),
                  color: AppCustomColors.whiteColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(15.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: _width / 55),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "By City",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.none,
                              fontSize: _width / 26,
                              color: AppCustomColors.greyTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppCustomColors.greyTextColor,
                          )
                        ],
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Divider(
                  color: AppCustomColors.greyTextColor,
                  thickness: 1,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Or",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.none,
                      fontSize: 14,
                      color: AppCustomColors.greyTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () async {
                await hubSelectionModalWidget(context, "Z");
              },
              child: Container(
                width: _width,
                height: _height / 16,
                decoration: BoxDecoration(
                  // border: Border.all(color: AppCustomColors.primaryColor.withOpacity(0.5),width: 3),
                  color: AppCustomColors.whiteColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(15.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: _width / 55),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "By Zip Code",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.none,
                              fontSize: _width / 26,
                              color: AppCustomColors.greyTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppCustomColors.greyTextColor,
                          )
                        ],
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
