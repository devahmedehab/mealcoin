import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/bottomNav/customBottomNavigationBar.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/common/shimmer_loading.dart';
import 'package:chefsandmeals_customer/src/models/requests/subscribe_email_and_phone.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/myOrders/view/myOrdersScreen.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/myaddress/view/my_address_profile.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/profileDetails/controller/user_dashboard_controller.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/profileDetails/view/my_profile_screen.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/qrCard/view/qr_card_page.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/referral/view/contact_list_page.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/wish_list/view/wish_list_screen.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/widget/signIn/signIn_screen.dart';

import '../../../../restaurant/restaurantProfile/view/categoryListScreen.dart';
import '../../../../webview/web_view_screen.dart';

class UserDashBoardPage extends StatefulWidget {
  const UserDashBoardPage({Key? key}) : super(key: key);

  @override
  _UserDashBoardPageState createState() => _UserDashBoardPageState();
}

class _UserDashBoardPageState extends State<UserDashBoardPage> {
  final controller = Get.put(UserDashBoardController());
  bool expand = false;
  int? tapped;

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: AppCustomColors.primaryColor,
        title:
            Obx(() => Text('Hi ${controller.user.value.firstName ?? "User"}')),
      ),
      body: BottomNavBarCustom(
        selectedIndex: 0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: ListView(children: [
            Obx(() => controller.user.value.firstName != null
                ? Container(
                    color: AppCustomColors.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(60)),
                                child: controller.user.value.profilePicture !=
                                        null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: FancyShimmerImage(
                                          imageUrl: controller
                                              .user.value.profilePicture!,
                                          boxFit: BoxFit.cover,
                                          height: 40,
                                          errorWidget: Image.asset(
                                              "assets/images/place_holder.png",
                                              height: 40,
                                              fit: BoxFit.cover),
                                        ),
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
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.person_pin_rounded,
                                      color: AppCustomColors.whiteColor,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: _width * 0.5,
                                      height: 25,
                                      child: Obx(
                                        () => Text(
                                          "${controller.user.value.fullName}",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  AppCustomColors.whiteColor),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(() => controller.user.value.phone != null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.phone_android_outlined,
                                            color: AppCustomColors.whiteColor,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            width: _width * 0.5,
                                            height: 25,
                                            child: Obx(
                                              () => Text(
                                                "${controller.user.value.phone}",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppCustomColors
                                                        .whiteColor),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container()),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: AppCustomColors.whiteColor,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: _width * 0.5,
                                      height: 25,
                                      child: Obx(
                                        () => Text(
                                          "${controller.user.value.emailAddress}",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  AppCustomColors.whiteColor),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.snackPass.value != null) {
                              Get.to(() => CategoryScreen(), arguments: {
                                "cat": controller.snackPass.value,
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "No SnackPass currently available! Please check back later."),
                              ));
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppCustomColors.whiteColor,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              customTextWidget(
                                  "Buy Snack Pass Card",
                                  _width / 30,
                                  FontWeight.w600,
                                  AppCustomColors.whiteColor),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : ProfileLoading()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  controller.emailAndPhoneStatus.value.phoneNumber != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color:
                                              AppCustomColors.containerBgColor),
                                      child: Icon(
                                        Icons.message,
                                        color: AppCustomColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    customTextWidget(
                                        "Subscribe To SMS",
                                        18,
                                        FontWeight.w600,
                                        AppCustomColors.blackColor)
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            Obx(() {
                              return FlutterSwitch(
                                width: 45.0,
                                height: 25.0,
                                toggleSize: 15.0,
                                value: controller.phoneVerified.value,
                                borderRadius: 30.0,
                                padding: 8.0,
                                onToggle: (val) {
                                  controller.phoneVerified.value = val;
                                  SubscribeEmailAndPhone subscribe =
                                      SubscribeEmailAndPhone(
                                    contactId: controller.contactId.value,
                                    phoneNumber: controller
                                        .emailAndPhoneStatus.value.phoneNumber
                                        .toString(),
                                    isPhoneNumberSubscribed:
                                        controller.phoneVerified.value,
                                    email: controller
                                        .emailAndPhoneStatus.value.email,
                                    isEmailSubscribed: controller
                                        .emailAndPhoneStatus
                                        .value
                                        .isEmailConfirmed,
                                  );
                                  controller.subscribe(subscribe);
                                },
                              );
                            }),
                          ],
                        )
                      : Container(),
                  controller.emailAndPhoneStatus.value.email != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color:
                                              AppCustomColors.containerBgColor),
                                      child: Icon(
                                        Icons.email,
                                        color: AppCustomColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    customTextWidget(
                                        "Subscribe To Email",
                                        18,
                                        FontWeight.w600,
                                        AppCustomColors.blackColor)
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            Obx(() {
                              return FlutterSwitch(
                                width: 45.0,
                                height: 25.0,
                                toggleSize: 15.0,
                                value: controller.emailVerified.value,
                                borderRadius: 30.0,
                                padding: 8.0,
                                onToggle: (val) {
                                  controller.emailVerified.value = val;
                                  SubscribeEmailAndPhone subscribe =
                                      SubscribeEmailAndPhone(
                                    contactId: controller.contactId.value,
                                    phoneNumber: controller
                                        .emailAndPhoneStatus.value.phoneNumber
                                        .toString(),
                                    isPhoneNumberSubscribed: controller
                                        .emailAndPhoneStatus
                                        .value
                                        .isPhoneNumberConfirmed,
                                    email: controller
                                        .emailAndPhoneStatus.value.email,
                                    isEmailSubscribed:
                                        controller.emailVerified.value,
                                  );
                                  controller.subscribe(subscribe);
                                },
                              );
                            }),
                          ],
                        )
                      : Container(),
                  InkWell(
                    onTap: () {
                      Get.to(() => MyOrderScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppCustomColors.containerBgColor),
                              child: Icon(
                                Icons.restaurant_menu_rounded,
                                color: AppCustomColors.primaryColor,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          customTextWidget("My Orders", 18, FontWeight.w600,
                              AppCustomColors.blackColor),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppCustomColors.primaryColor
                                    .withOpacity(0.12)),
                            child: Obx(() {
                              return customTextWidget(
                                  controller.user.value.numberOfOrders == null
                                      ? "0"
                                      : controller.user.value.numberOfOrders
                                          .toString(),
                                  16,
                                  FontWeight.w600,
                                  AppCustomColors.primaryColor);
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => WishListPage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppCustomColors.containerBgColor),
                              child: Icon(
                                Icons.favorite_rounded,
                                color: AppCustomColors.primaryColor,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          customTextWidget("Favorites", 18, FontWeight.w600,
                              AppCustomColors.blackColor),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppCustomColors.primaryColor
                                    .withOpacity(0.12)),
                            child: customTextWidget("0", 16, FontWeight.w600,
                                AppCustomColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ProfileDetailsScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppCustomColors.containerBgColor),
                            child: Icon(
                              Icons.perm_contact_calendar_rounded,
                              color: AppCustomColors.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          customTextWidget("My Profile", 18, FontWeight.w600,
                              AppCustomColors.blackColor)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => QRCardPage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppCustomColors.containerBgColor),
                            child: Icon(
                              Icons.qr_code_scanner,
                              color: AppCustomColors.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          customTextWidget("QR Card", 18, FontWeight.w600,
                              AppCustomColors.blackColor)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ProDetailsScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppCustomColors.containerBgColor),
                            child: Icon(
                              Icons.edit_location,
                              color: AppCustomColors.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          customTextWidget("My Address", 18, FontWeight.w600,
                              AppCustomColors.blackColor)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppCustomColors.containerBgColor),
                              child: Icon(
                                Icons.star_rounded,
                                color: AppCustomColors.primaryColor,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          customTextWidget("Rewards Points", 18,
                              FontWeight.w600, AppCustomColors.blackColor),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppCustomColors.primaryColor
                                    .withOpacity(0.12)),
                            child: Obx(
                              () => Text(
                                "${controller.user.value.rewardPoints == null ? 0 : controller.user.value.rewardPoints}",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppCustomColors.primaryColor),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppCustomColors.containerBgColor),
                            child: Icon(
                              Icons.wallet_giftcard_rounded,
                              color: AppCustomColors.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          customTextWidget("Snackpass Balance", 18,
                              FontWeight.w600, AppCustomColors.blackColor)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ContactListPage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppCustomColors.containerBgColor),
                            child: Icon(
                              Icons.contacts,
                              color: AppCustomColors.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          customTextWidget("Refer & Earn", 18, FontWeight.w600,
                              AppCustomColors.blackColor)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        expand =
                            ((tapped == null) || !expand) ? !expand : expand;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppCustomColors.containerBgColor),
                            child: Icon(
                              Icons.info,
                              color: AppCustomColors.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          customTextWidget("About Chefs & Meals", 18,
                              FontWeight.w600, AppCustomColors.blackColor)
                        ],
                      ),
                    ),
                  ),
                  expand == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 50),
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => WebViewContainer(
                                        "https://www.chefsnmeals.com/privacy-policy"));
                                  },
                                  child: Text(
                                    "Privacy Policy",
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => WebViewContainer(
                                        "https://www.chefsnmeals.com/termsOfUse"));
                                  },
                                  child: Text(
                                    "Terms Of Use",
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => WebViewContainer(
                                        "https://www.chefsnmeals.com/termsOfUse"));
                                  },
                                  child: Text(
                                    "Return Policy",
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => WebViewContainer(
                                        "https://www.chefsnmeals.com/termsOfUse"));
                                  },
                                  child: Text(
                                    "Reward Point Policy",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () async {
                      MyDialog.loadingDialog(context, 'Logging Out');
                      controller.logOut();
                      Future.delayed(Duration(seconds: 2), () {
                        MyDialog.closeDialog(context);
                        Get.off(() => SignInScreen());
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppCustomColors.containerBgColor),
                            child: Icon(
                              Icons.exit_to_app_rounded,
                              color: AppCustomColors.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          customTextWidget("Logout", 18, FontWeight.w600,
                              AppCustomColors.blackColor)
                        ],
                      ),
                    ),
                  ),
                  /*InkWell(
                        onTap: () async {
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppCustomColors.containerBgColor),
                                child: Icon(
                                  Icons.exit_to_app_rounded,
                                  color: AppCustomColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )*/
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
