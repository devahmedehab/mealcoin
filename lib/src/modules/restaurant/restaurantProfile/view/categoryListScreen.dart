import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/common/shimmer_loading.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_response.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/controller/cartController.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/view/cartScreen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/controller/landing_page_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/controller/product_by_category_and_hub_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/productProfile/view/productProfileScreen.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/profile_decider_screen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  final controller = Get.put(ProductByCategoryAndHub());
  RefreshController refreshController = RefreshController();
  final landingPageController = Get.put(LandingPageController());
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ProductResult product;
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Material(
      key: _key,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                // physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                // padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: _height / 6.5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${controller.category.value.name}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        decoration: TextDecoration.none,
                        fontSize: 24,
                        color: AppCustomColors.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: SmartRefresher(
                        controller: refreshController,
                        enablePullUp: true,
                        onLoading: () async {
                          controller.skip.value += 20;
                          final result =
                              await controller.getAllProductByCatAndHub();
                          if (result != null) {
                            refreshController.loadComplete();
                          } else {
                            refreshController.loadFailed();
                          }
                        },
                        child: Obx(
                          () => !controller.isLoading.value
                              ? controller.productList.length > 0
                                  ? GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                      ),
                                      shrinkWrap: true,
                                      itemCount: controller.productList.length,
                                      itemBuilder: (context, index) {
                                        var item =
                                            controller.productList[index];
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
                                          child: Stack(
                                            children: [
                                              Container(
                                                  //width: _width,
                                                  height: _height / 4.5,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    child: item.picture != null
                                                        ? Image.network(
                                                            item.picture!,
                                                            height:
                                                                _height / 3.5,
                                                            fit: BoxFit.cover)
                                                        : Image.asset(
                                                            "assets/images/place_holder.png",
                                                            height:
                                                                _height / 3.5,
                                                            fit: BoxFit.cover),
                                                  )),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  12),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  12)),
                                                  child: Container(
                                                    width: _width / 2.18,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                            vertical: 8),
                                                    color: AppCustomColors
                                                        .blackColor
                                                        .withOpacity(0.6),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${item.productName}',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 18,
                                                            color:
                                                                AppCustomColors
                                                                    .whiteColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        /* Text(
                                                  'Item Description',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    decoration: TextDecoration.none,
                                                    fontSize: 16,
                                                    color: AppCustomColors.whiteColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),*/
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  right: _width / 42,
                                                  top: _width / 42,
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        width: _width / 10,
                                                        height: _width / 10,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppCustomColors
                                                                    .whiteColor
                                                                    .withOpacity(
                                                                        0.7),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                      ),
                                                      Center(
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                            Icons
                                                                .favorite_border,
                                                            size: _width / 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Positioned(
                                                  right: _width / 42,
                                                  top: _width / 7,
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        width: _width / 10,
                                                        height: _width / 10,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppCustomColors
                                                                    .whiteColor
                                                                    .withOpacity(
                                                                        0.7),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                      ),
                                                      Center(
                                                        child: IconButton(
                                                            onPressed:
                                                                () async {
                                                              final cartController =
                                                                  Get.put(
                                                                      CartController());
                                                              cartController
                                                                  .getAllDeliveryType(
                                                                      storeId: item
                                                                          .storeId);
                                                              if (cartController
                                                                      .deliveryTypeList
                                                                      .length >
                                                                  0) {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return CupertinoAlertDialog(
                                                                        title: Text(
                                                                            "Service Type"),
                                                                        content:
                                                                            Container(
                                                                          height:
                                                                              100,
                                                                          child:
                                                                              ListView.builder(
                                                                            shrinkWrap:
                                                                                true,
                                                                            itemCount:
                                                                                cartController.deliveryTypeList.length,
                                                                            itemBuilder:
                                                                                (context, index) {
                                                                              var item = cartController.deliveryTypeList[index];
                                                                              return Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text("${item.displayName}"),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text("Cancel")),
                                                                          TextButton(
                                                                              onPressed: () async {
                                                                                Navigator.pop(context);
                                                                                MyDialog.loadingDialog(context, "Adding Product To Cart");
                                                                                if (landingPageController.contactId.value == 0) {
                                                                                  Get.back();
                                                                                  Utils.showSnackBar(_key.currentContext!, "Login required for adding product to cart");
                                                                                  Get.to(() => ProfileDeciderScreen());
                                                                                } else {
                                                                                  await cartController.getAllCart();
                                                                                  if (cartController.cartList.length > 0) {
                                                                                    if (item.storeId == cartController.cartList.first.storeId) {
                                                                                      final result = await landingPageController.addProductToCart(item.productId!, item.storeId!);
                                                                                      if (result) {
                                                                                        Get.back();
                                                                                        Utils.showSnackBar(_key.currentContext!, "Add to Cart successful");
                                                                                      } else {
                                                                                        Get.back();
                                                                                        Utils.showSnackBar(_key.currentContext!, "Unable adding product to cart");
                                                                                      }
                                                                                    } else {
                                                                                      Get.back();
                                                                                      Get.defaultDialog(
                                                                                        title: "Delete Cart Item",
                                                                                        content: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Text("You have cart item from different store\nDo you want to Delete Existing cart item?"),
                                                                                        ),
                                                                                        actions: [
                                                                                          TextButton(
                                                                                              onPressed: () {
                                                                                                Get.back();
                                                                                              },
                                                                                              child: Text("NO")),
                                                                                          TextButton(
                                                                                              onPressed: () async {
                                                                                                Get.back();
                                                                                                await cartController.clearCart();
                                                                                                final result = await landingPageController.addProductToCart(item.productId!, item.storeId!);
                                                                                                await cartController.getAllCart();
                                                                                                if (result) {
                                                                                                  Utils.showSnackBar(_key.currentContext!, "Add to Cart successful");
                                                                                                } else {
                                                                                                  Utils.showSnackBar(_key.currentContext!, "Unable adding product to cart");
                                                                                                }
                                                                                              },
                                                                                              child: Text("YES")),
                                                                                        ],
                                                                                      );
                                                                                    }
                                                                                  } else {
                                                                                    final result = await landingPageController.addProductToCart(item.productId!, item.storeId!);
                                                                                    if (result) {
                                                                                      Get.back();
                                                                                      Utils.showSnackBar(_key.currentContext!, "Add to Cart successful");
                                                                                    } else {
                                                                                      Get.back();
                                                                                      Utils.showSnackBar(_key.currentContext!, "Unable adding product to cart");
                                                                                    }
                                                                                  }
                                                                                }
                                                                              },
                                                                              child: Text("Add To Cat")),
                                                                        ]);
                                                                  },
                                                                );
                                                              } else {
                                                                MyDialog
                                                                    .closeDialog(
                                                                        context);
                                                                Utils.showSnackBar(
                                                                    context,
                                                                    "No Service type found");
                                                              }
                                                            },
                                                            icon: Icon(Icons
                                                                .shopping_cart)),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        );
                                      })
                                  : Center(
                                      child: Text(
                                        'No product found!',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          decoration: TextDecoration.none,
                                          fontSize: 16,
                                          color: AppCustomColors.blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                              : ShimmerGridLoading(height: _height, count: 20),
                        ),
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
                        customTextWidget("Category Items", _width / 20,
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
