import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/restaurantProfile/controller/restaurant_profile_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/restaurantProfile/view/all_category_for_restaurant_screen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/restaurantProfile/view/widget/horizontal_product_category_list_widget.dart';

import 'widget/top_products_for_restaurant_widget.dart';

class RestaurantProfileScreen extends StatelessWidget {
  final controller = Get.put(RestaurantProfileController());

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Material(
      child: Container(
        width: _width,
        height: _height,
        color: AppCustomColors.containerBgColor,
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: _height / 6.5, left: 12, right: 12),
                  width: _width,
                  alignment: Alignment.center,
                  child: Obx(() {
                    return Text(
                      controller.restaurant.value?.name ?? "",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        decoration: TextDecoration.none,
                        fontSize: 24,
                        color: AppCustomColors.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  }),
                ),
                SizedBox(
                  height: 24,
                ),
                HorizontalProductCategoryListWidget(
                  cartType: "What would you like to order?",
                  onSeeAllPressed: () {
                    Get.to(
                        () => AllCategoryForRestaurantScreen(
                              store: controller.restaurant.value!,
                            ),
                        arguments: {
                          "restaurant": controller.restaurant.value!
                        });
                  },
                ),
                SizedBox(
                  height: 18,
                ),
                TopProductsForRestaurantWidget(
                  headerText: "Special Foods",
                ),
                SizedBox(
                  height: 60,
                )
              ],
            ),
            Positioned(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: _height / 7.5,
              color: AppCustomColors.primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                //Utils.navigateToPage(context, LandingScreen(), 250, true);
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: AppCustomColors.whiteColor,
                              )),
                          customTextWidget("Restaurant", _width / 20,
                              FontWeight.w400, AppCustomColors.whiteColor),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
