import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/common/shimmer_loading.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/models/responses/populor_store_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_category_response.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/productProfile/view/productProfileScreen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/productProfile/view/widget/product_card.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/restaurantProfile/controller/product_list_controller.dart';

class MyProductListPage extends StatelessWidget {
  MyProductListPage({Key? key, required this.store, required this.category})
      : controller =
            Get.put(ProductListController(store: store, category: category)),
        super(key: key);

  final StoreResult store;
  final ProductCategoryResult category;

  final ProductListController controller;

  final RefreshController refreshController = RefreshController();

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
                                await controller.getCategoryProducts();
                                if (controller.productList.isEmpty) {
                                  refreshController.loadNoData();
                                } else {
                                  refreshController.loadComplete();
                                }
                              },
                              child: Obx(() => ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: controller.productList.length,
                                  itemBuilder: (context, index) {
                                    var item = controller.productList[index];
                                    return InkWell(
                                        onTap: () async {
                                          await controller
                                              .updateProductRecommendationScore(
                                                  item.productId!);
                                          Utils.navigateToPage(
                                              context,
                                              ProductProfileScreen(
                                                product: item,
                                              ),
                                              200,
                                              false);
                                        },
                                        child: ProductCard(
                                          product: item,
                                        ));
                                  })),
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
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: AppCustomColors.whiteColor,
                            )),
                        customTextWidget("${category.name}", _width / 20,
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
