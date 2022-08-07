import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/common/shimmer_loading.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/controller/landing_page_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/restaurantProfile/view/categoryListScreen.dart';

class HorizontalCategoryCartListWidget extends StatelessWidget {
  final String? cartType;
  final VoidCallback? onSeeAllPressed;
  final LandingPageController controller;
  HorizontalCategoryCartListWidget({
    Key? key,
    this.cartType,
    this.onSeeAllPressed,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return Container(
      color: AppCustomColors.whiteColor,
      height: _height / 2.5,
      child: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                customTextWidget(cartType!, _width / 24, FontWeight.w600,
                    AppCustomColors.blackColor),
                GestureDetector(
                  onTap: onSeeAllPressed,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppCustomColors.primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Align(
                        alignment: Alignment.center,
                        child: customTextWidget("View All", _width / 36,
                            FontWeight.w600, AppCustomColors.whiteColor),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
            // height: _height/3,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Obx(
                () => !controller.categoryLoading.value
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: controller.topCategory.length,
                        itemBuilder: (context, index) {
                          var item = controller.topCategory[index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => CategoryScreen(),
                                  arguments: {"cat": item});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                children: [
                                  Container(
                                      height: cartType!.contains("Popular")
                                          ? _height / 7
                                          : _height / 6,
                                      width: cartType!.contains("Popular")
                                          ? _height / 7
                                          : _height / 6,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: item.pictureUrl != null
                                            ? FancyShimmerImage(
                                                imageUrl: item.pictureUrl!,
                                                height: _height / 3.5)
                                            : Image.asset(
                                                "assets/images/place_holder.png",
                                                height: _height / 3.5,
                                                fit: BoxFit.cover),
                                      )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: cartType!.contains("Popular")
                                        ? _height / 7
                                        : _height / 6,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${item.name}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        decoration: TextDecoration.none,
                                        fontSize: 16,
                                        color: AppCustomColors.blackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : ShimmerListLoading(
                        height: _height / 6,
                        count: 6,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
