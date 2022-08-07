import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/common/shimmer_loading.dart';
import 'package:chefsandmeals_customer/src/models/responses/populor_store_response.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/restaurantProfile/controller/all_category_for_restaurant_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/restaurantProfile/view/product_list_page.dart';

class AllCategoryForRestaurantScreen extends StatelessWidget {
  final Random random = new Random();
  final AllCategoryForRestaurantController controller;
  final RefreshController refreshController = RefreshController();
  final StoreResult store;

  AllCategoryForRestaurantScreen({Key? key, required this.store})
      : controller = Get.put(AllCategoryForRestaurantController(store)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height - 60;
    return Material(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: _height / 9, left: 12, right: 12),
                    height: _height,
                    child: Obx(
                      () => !controller.isLoading.value
                          ? SmartRefresher(
                              controller: refreshController,
                              enablePullUp: true,
                              onLoading: () async {
                                controller.skipCount.value += 20;
                                await controller.getCategories();
                                if (controller.categories.isEmpty) {
                                  refreshController.loadNoData();
                                } else {
                                  refreshController.loadComplete();
                                }
                              },
                              child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.8,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 22,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: controller.categories.length,
                                  itemBuilder: (context, index) {
                                    var item = controller.categories[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(MyProductListPage(
                                          store: store,
                                          category: item,
                                        ));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                              width: _width,
                                              height: _height / 4.5,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                child: item.pictureUrl != null
                                                    ? Image.network(
                                                        item.pictureUrl!,
                                                        height: _height / 3.5,
                                                        fit: BoxFit.cover)
                                                    : Image.asset(
                                                        "assets/images/place_holder.png",
                                                        height: _height / 3.5,
                                                        fit: BoxFit.cover),
                                              )),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              item.name!,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                decoration: TextDecoration.none,
                                                fontSize: 18,
                                                color:
                                                    AppCustomColors.blackColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          : ShimmerGridLoading(
                              height: _height,
                              count: 20,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 110,
              color: AppCustomColors.primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
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
                        customTextWidget("All Category List", _width / 20,
                            FontWeight.w400, AppCustomColors.whiteColor),
                      ],
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
