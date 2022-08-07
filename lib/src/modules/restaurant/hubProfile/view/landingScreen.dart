import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/bottomNav/customBottomNavigationBar.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/navDrawer/customNav.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/common/sharedPreference.dart';
import 'package:chefsandmeals_customer/src/common/strings.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/controller/landing_page_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/view/widget/horizontal_cartlist_product_category.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/view/widget/populor_restorent_widgets.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/view/widget/trendingListWidget.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/restaurantProfile/view/allCategoryListScreen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/restaurantProfile/view/allPopularRestaurant.dart';

import 'firsthubSelectionScreen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  double appBarHeight = 130;
  bool isSearchClicked = false;
  bool isNavDrawerClicked = false;
  DateTime? currentBackPressTime;
  Random random = new Random();
  SharedPref pref = SharedPref();
  TextEditingController searchTextController = TextEditingController();
  String hubsName = "Hub's Name";
  @override
  void initState() {
    getHubsName();
    super.initState();
  }

  getHubsName() async {
    final hub = await pref.getUserAppData(SharedPrefStrings.hubName);
    setState(() {
      hubsName = hub!;
    });
  }

  Future<bool> exitApp() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
    } else {
      SystemNavigator.pop();
    }
    return Future.value(false);
  }

  final controller = Get.put(LandingPageController());

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    appBarHeight = !isSearchClicked ? _width / 3.4 : _width / 2.2;
    return Scaffold(
      body: Stack(
        children: [
          BottomNavBarCustom(
            selectedIndex: 1,
            child: Container(
              color: AppCustomColors.containerBgColor,
              child: Stack(
                children: [
                  Column(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        padding: EdgeInsets.only(top: 35, left: 25, right: 25),
                        height: appBarHeight,
                        width: _width,
                        color: AppCustomColors.primaryColor,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/logo3.png",
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        customTextWidget(
                                            ChefsAndMeals.chefsAnd,
                                            _width / 14,
                                            FontWeight.w700,
                                            AppCustomColors.whiteColor),
                                        customTextWidget(
                                            " " + ChefsAndMeals.meals,
                                            _width / 14,
                                            FontWeight.w700,
                                            AppCustomColors.whiteColor),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.off(() => FirstHubSelection());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: _width / 2,
                                              child: customTextWidget(
                                                  "$hubsName",
                                                  _width / 24,
                                                  FontWeight.w400,
                                                  AppCustomColors.whiteColor)),
                                          Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            size: 22,
                                            color: AppCustomColors.whiteColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    // GestureDetector(
                                    //     onTap: () {
                                    //       if (appBarHeight == _width / 3.4) {
                                    //         setState(() {
                                    //           appBarHeight = _width / 2.2;
                                    //         });
                                    //         Future.delayed(
                                    //             const Duration(
                                    //                 milliseconds: 250), () {
                                    //           setState(() {
                                    //             isSearchClicked = true;
                                    //           });
                                    //         });
                                    //       } else {
                                    //         setState(() {
                                    //           isSearchClicked = false;
                                    //         });
                                    //
                                    //         Future.delayed(
                                    //             const Duration(
                                    //                 milliseconds: 250), () {
                                    //           setState(() {
                                    //             appBarHeight = _width / 3.4;
                                    //           });
                                    //         });
                                    //       }
                                    //     },
                                    //     child: Icon(
                                    //       isSearchClicked
                                    //           ? Icons.keyboard_arrow_up_rounded
                                    //           : Icons.search_rounded,
                                    //       size: 32,
                                    //       color: AppCustomColors.whiteColor,
                                    //     )),
                                  ],
                                )
                              ],
                            ),
                            isSearchClicked
                                ? SizedBox(
                                    height: 16,
                                  )
                                : Container(),
                            isSearchClicked
                                ? Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 8),
                                      decoration: new BoxDecoration(
                                          color: AppCustomColors.whiteColor,
                                          borderRadius:
                                              new BorderRadius.circular(16)),
                                      child: TextFormField(
                                        decoration: new InputDecoration(
                                          hintText: "Search by product or shop",
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              if (searchTextController.text !=
                                                  "") {
                                                setState(() {
                                                  searchTextController.text =
                                                      "";
                                                });
                                              }
                                            },
                                            child: Icon(
                                                searchTextController.text == ""
                                                    ? Icons.search_rounded
                                                    : Icons.clear),
                                          ),
                                          fillColor: AppCustomColors.whiteColor,
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                            left: _width / 28,
                                            top: _width / 32,
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,

                                        //onSaved: (value)=>_fName=value,
                                        controller: searchTextController,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  )
                                : Container(),
                            Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              PopulorRestorentWidgets(
                                controller: controller,
                                cartType: "Popular Restaurant",
                                onSeeAllPressed: () {
                                  Get.to(() => AllPopularRestaurantScreen());
                                },
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              HorizontalCategoryCartListWidget(
                                controller: controller,
                                cartType: "What would you like to order?",
                                onSeeAllPressed: () {
                                  Get.to(() => AllCategoryListScreen());
                                },
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              TrendingListWidget(
                                controller: controller,
                                headerText: "Trending Foods",
                              ),
                              // SizedBox(height: 36,),
                              // allRestaurantListWidget(_width, _height, random),
                              SizedBox(
                                height: _height / 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          CustomNav(navContext: context, index: 1),
        ],
      ),
    );
  }
}
