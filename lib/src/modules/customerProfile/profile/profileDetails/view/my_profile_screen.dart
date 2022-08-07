import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/common/string64_image_converter.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/profileDetails/controller/my_profile_controller.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/profileDetails/view/updateProfileScreen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/view/landingScreen.dart';

class ProfileDetailsScreen extends StatefulWidget {
  @override
  _ProfileDetailsScreenState createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  final controller = Get.put(MyProfileController());

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppCustomColors.whiteColor,
          child: Stack(
            children: [
              Positioned(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                height: _height / 3,
                color: AppCustomColors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: AppCustomColors.whiteColor,
                              )),
                          customTextWidget("My Profile", _width / 20,
                              FontWeight.w400, AppCustomColors.whiteColor),
                          Spacer(),
                          Obx(() => controller.user.value.firstName != null
                              ? PopupMenuButton<int>(
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: AppCustomColors.whiteColor,
                                  ),
                                  iconSize: _width / 12,
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuItem<int>>[
                                        new PopupMenuItem<int>(
                                            value: 1,
                                            child: new Text('Edit Profile')),
                                        new PopupMenuItem<int>(
                                            value: 2,
                                            child: new Text('Refer and Earn')),
                                      ],
                                  onSelected: (int value) {
                                    switch (value) {
                                      case 1:
                                        Get.to(() => ProfileUpdateScreen(),
                                            arguments: {
                                              "user": controller.user.value
                                            });
                                    }
                                  })
                              : Container())
                        ],
                      ),
                      Spacer(),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Obx(
                            () => Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(60)),
                              child: controller.user.value.pictureBase64 != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: FancyShimmerImage(
                                          imageUrl: ImageConverter
                                              .convertStringToImage(controller
                                                  .user.value.pictureBase64!),
                                          boxFit: BoxFit.cover,
                                          height: 40),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.asset(
                                          "assets/images/place_holder.png",
                                          height: 40,
                                          fit: BoxFit.cover),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _height / 20,
                      ),
                    ],
                  ),
                ),
              )),
              Padding(
                padding: EdgeInsets.only(top: _height / 3.5),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            Card(
                              elevation: 3,
                              child: Container(
                                width: _width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    customTextWidget(
                                        "First Name",
                                        18,
                                        FontWeight.w400,
                                        AppCustomColors.greyTextColor),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Obx(
                                      () => Text(
                                        "${controller.user.value.firstName ?? ''}",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    customTextWidget(
                                        "Last Name",
                                        18,
                                        FontWeight.w400,
                                        AppCustomColors.greyTextColor),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Obx(
                                      () => Text(
                                        "${controller.user.value.lastName ?? ''}",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Obx(
                                      () => controller.user.value.dateOfBirth !=
                                              null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                customTextWidget(
                                                    "Date of Birth",
                                                    18,
                                                    FontWeight.w400,
                                                    AppCustomColors
                                                        .greyTextColor),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Obx(
                                                  () => Text(
                                                    "${controller.user.value.dateOfBirth}",
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    customTextWidget(
                                        "Email",
                                        18,
                                        FontWeight.w400,
                                        AppCustomColors.greyTextColor),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Obx(
                                      () => Text(
                                        "${controller.user.value.email ?? ''}",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Obx(
                                      () => controller.user.value.phone !=
                                                  null &&
                                              controller.user.value.phone!
                                                      .length >
                                                  2
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                customTextWidget(
                                                    "Phone",
                                                    18,
                                                    FontWeight.w400,
                                                    AppCustomColors
                                                        .greyTextColor),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Obx(
                                                  () => Text(
                                                    "${controller.user.value.phone}",
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ),
                                    Obx(
                                      () => controller.user.value.city != null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                customTextWidget(
                                                    "City",
                                                    18,
                                                    FontWeight.w400,
                                                    AppCustomColors
                                                        .greyTextColor),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Obx(
                                                  () => Text(
                                                    "${controller.user.value.city}",
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ),
                                    Obx(
                                      () => controller.user.value.address !=
                                              null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                customTextWidget(
                                                    "Address",
                                                    18,
                                                    FontWeight.w400,
                                                    AppCustomColors
                                                        .greyTextColor),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Obx(
                                                  () => Text(
                                                    "${controller.user.value.address}",
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ),
                                    Obx(
                                      () => controller.user.value.zipCode !=
                                              null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                customTextWidget(
                                                    "Zip Code",
                                                    18,
                                                    FontWeight.w400,
                                                    AppCustomColors
                                                        .greyTextColor),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Obx(
                                                  () => Text(
                                                    "${controller.user.value.zipCode}",
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
