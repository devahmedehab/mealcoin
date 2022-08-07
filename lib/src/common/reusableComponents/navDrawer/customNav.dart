import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/NavDrawerController/drawer_controller.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/profileDetails/view/my_profile_screen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/view/landingScreen.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/widget/signIn/signIn_screen.dart';

import '../../colors.dart';
import '../../utils.dart';
import '../textWidget.dart';

class CustomNav extends StatefulWidget {
  final navContext;
  final index;
  CustomNav({Key? key, this.navContext, this.index}) : super(key: key);
  @override
  State createState() => CustomNavState();
}

class CustomNavState extends State<CustomNav> {
  double xOffset = -1200;
  double yOffset = -1500;
  double xOffsetR = -1500;
  double yOffsetR = -1200;
  var navBgColor;
  late bool _isClicked;
  @override
  void initState() {
    super.initState();
    _isClicked = false;
    navBgColor = Color(0xffFFCC5F);
  }

  void offFocusFunction() {
    if (!_isClicked) {
      xOffset = 0;
      yOffset = (MediaQuery.of(context).size.height / 3.7);
      xOffsetR = 0;
      yOffsetR = 0;
      navBgColor = Color(0xfff9cc59);
    } else {
      xOffset = -(MediaQuery.of(context).size.width);
      yOffset = -(MediaQuery.of(context).size.height);
      xOffsetR = -(MediaQuery.of(context).size.width);
      yOffsetR = -(MediaQuery.of(context).size.height);
      navBgColor = Color(0xffFFCC5F);
    }
    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() {
        _isClicked = !_isClicked;
      });
    });
  }

  final CustomDrawerController _drawerController =
      Get.put(CustomDrawerController());

  @override
  Widget build(BuildContext context) {
    context = widget.navContext;
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        children: <Widget>[
          _isClicked
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      offFocusFunction();
                    });
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(color: Colors.black.withOpacity(0.4)),
                  ),
                )
              : Container(),
          //Container(color: Colors.red,width: 50,height: 50,),
          AnimatedContainer(
            transform: Matrix4.translationValues(xOffsetR, yOffsetR, 0),
            width: MediaQuery.of(context).size.width / 1.45,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                color: AppCustomColors.navDraweBgColor,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(40))),
            duration: Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: AppCustomColors.whiteColor,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/icons/profileicon.png'),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            customTextWidget("User Name", _width / 18,
                                FontWeight.w400, AppCustomColors.whiteColor),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: AppCustomColors.whiteColor,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: customTextWidget(
                                      "Deer Park, NY",
                                      _width / 30,
                                      FontWeight.w600,
                                      AppCustomColors.whiteColor),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppCustomColors.whiteColor,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: customTextWidget(
                                      "+1 917 913 4501",
                                      _width / 30,
                                      FontWeight.w600,
                                      AppCustomColors.whiteColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppCustomColors.whiteColor,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      customTextWidget("Become Premium Member", _width / 30,
                          FontWeight.w600, AppCustomColors.whiteColor),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0),
            width: MediaQuery.of(widget.navContext).size.width / 1.4,
            height: (MediaQuery.of(context).size.height / 3.7) * 2.7,
            decoration: BoxDecoration(
                color: AppCustomColors.whiteColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(10),
                )),
            duration: Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Get.off(() => LandingScreen());
                            /*Utils.navigateToPage(
                                context, LandingScreen(), 250, true);*/
                          },
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppCustomColors.containerBgColor),
                                child: Icon(
                                  Icons.home,
                                  color: AppCustomColors.primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              customTextWidget("Home", 18, FontWeight.w600,
                                  AppCustomColors.blackColor)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {},
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
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppCustomColors.primaryColor
                                        .withOpacity(0.12)),
                                child: customTextWidget(
                                    "15",
                                    16,
                                    FontWeight.w600,
                                    AppCustomColors.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {},
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
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppCustomColors.primaryColor
                                        .withOpacity(0.12)),
                                child: customTextWidget(
                                    "25",
                                    16,
                                    FontWeight.w600,
                                    AppCustomColors.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Get.off(() => ProfileDetailsScreen());
                            /*Utils.navigateToPage(
                                context, ProfileDetailsScreen(), 250, true);*/
                          },
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
                              customTextWidget("My Profile", 18,
                                  FontWeight.w600, AppCustomColors.blackColor)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {},
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
                              Spacer(),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppCustomColors.primaryColor
                                          .withOpacity(0.12)),
                                  child: customTextWidget(
                                      "985",
                                      16,
                                      FontWeight.w600,
                                      AppCustomColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {},
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
                              customTextWidget("My Wallet", 18, FontWeight.w600,
                                  AppCustomColors.blackColor)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {},
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
                              customTextWidget("Contacts", 18, FontWeight.w600,
                                  AppCustomColors.blackColor)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {},
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
                              Expanded(
                                child: customTextWidget(
                                    "About ChefsNMeals",
                                    18,
                                    FontWeight.w600,
                                    AppCustomColors.blackColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 3,
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            MyDialog.loadingDialog(context, "Signing Out");
                            await _drawerController.logout().then((value) {
                              MyDialog.closeDialog(context);
                              Utils.navigateToPage(
                                  context, SignInScreen(), 300, true);
                            });
                          },
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
                    ],
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: _width / 2.6,
                  child: Image(
                    image: AssetImage('assets/icons/logo.png'),
                    height: 42,
                    color: AppCustomColors.primaryColor.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ),

          /*Positioned(
              top: 40,
              left: 10,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      offFocusFunction();
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: Center(child: Image.asset("assets/icons/dimage.png",height: 30,width: 30,)),
                  ))),*/
        ],
      ),
    );
  }
}
