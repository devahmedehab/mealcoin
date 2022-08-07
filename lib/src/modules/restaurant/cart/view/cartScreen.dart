import 'package:flutter/material.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/bottomNav/customBottomNavigationBar.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/navDrawer/customNav.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_app_bar.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/controller/cartController.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/payment/view/widget/delivery_or_pickup_screen.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class AddToCartScreen extends StatelessWidget {
  final controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: KAppBar(
        isCustomLeading: true,
        customTitle: Text('Cart'),
      ),
      body: Stack(
        children: [
          BottomNavBarCustom(
            selectedIndex: 3,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                /// Order List
                Container(
                  height: size.height * 0.64,
                  child: Obx(() => controller.cart.value.cartItems == null
                      ? Image.asset(
                          'assets/icons/chefs_heart_white_background.gif',
                        )
                      : controller.cart.value.cartItems!.length > 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.cartList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = controller.cartList[index];
                                return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    MyDialog.loadingDialog(
                                        context, "Deleting Item");
                                    controller.deleteItem(item.id!);
                                    MyDialog.closeDialog(context);
                                  },
                                  confirmDismiss: (direction) {
                                    return Get.defaultDialog(
                                      title: "DELETE ITEM",
                                      content: Text(
                                          "Do you want to delete this item?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back(result: false);
                                            },
                                            child: Text("Cancel")),
                                        TextButton(
                                            onPressed: () {
                                              Get.back(result: true);
                                            },
                                            child: Text("Delete")),
                                      ],
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Card(
                                      elevation: 5,
                                      margin: EdgeInsets.only(bottom: 11),
                                      child: Column(
                                        children: [
                                          Container(
                                            height:
                                                KSize.getHeight(context, 105),
                                            color: KColor.white,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: KSize.getWidth(
                                                      context, 11),
                                                  vertical: KSize.getHeight(
                                                      context, 19)),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    child: item.productPicture !=
                                                            null
                                                        ? FancyShimmerImage(
                                                            imageUrl: item
                                                                .productPicture!,
                                                            height: 66,
                                                            width: 66,
                                                          )
                                                        : Image.asset(
                                                            "assets/images/place_holder.png",
                                                            height: 66,
                                                            width: 66,
                                                            fit:
                                                                BoxFit.contain),
                                                  ),
                                                  SizedBox(
                                                      width: KSize.getWidth(
                                                          context, 9.1)),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: size.width - 116,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  size.width *
                                                                      0.5,
                                                              child: Text(
                                                                '${item.productName}',
                                                                style: KTextStyle
                                                                    .subTitle1
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18,
                                                                        color: KColor
                                                                            .black,
                                                                        height:
                                                                            1),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            Text(
                                                              '\$ ${item.unitPrice}',
                                                              style: KTextStyle
                                                                  .subTitle3
                                                                  .copyWith(
                                                                      color: KColor
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              KSize.getHeight(
                                                                  context, 13)),
                                                      Container(
                                                        width: size.width - 116,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              height: KSize
                                                                  .getHeight(
                                                                      context,
                                                                      26),
                                                              width:
                                                                  size.width *
                                                                      0.4,
                                                              decoration: BoxDecoration(
                                                                  color: KColor
                                                                      .whiteSmoke,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      controller.decrementCartItem(
                                                                          item,
                                                                          index);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height: KSize.getHeight(
                                                                          context,
                                                                          24),
                                                                      width: KSize.getWidth(
                                                                          context,
                                                                          24),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape.circle,
                                                                          color: KColor.primary,
                                                                          border: Border.all(
                                                                            color:
                                                                                KColor.white,
                                                                          )),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: KColor
                                                                            .white,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${item.quantity}',
                                                                    style: KTextStyle
                                                                        .subTitle1
                                                                        .copyWith(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                KColor.black),
                                                                  ),
                                                                  Container(
                                                                    height: KSize
                                                                        .getHeight(
                                                                            context,
                                                                            24),
                                                                    width: KSize
                                                                        .getWidth(
                                                                            context,
                                                                            24),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: KColor
                                                                            .primary),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        controller.incrementCartItem(
                                                                            item,
                                                                            index);
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: KColor
                                                                            .white,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'X  \$ ${item.unitPrice!}',
                                                                    style: KTextStyle
                                                                        .subTitle3
                                                                        .copyWith(
                                                                            color:
                                                                                KColor.black,
                                                                            fontWeight: FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Text(
                                                              '=  \$ ${item.quantity! * item.unitPrice!}',
                                                              style: KTextStyle
                                                                  .subTitle3
                                                                  .copyWith(
                                                                      color: KColor
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Container(
                                              width: size.width,
                                              height: 25,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      controller
                                                          .updateCartItem(item);
                                                    },
                                                    child: Container(
                                                      width: size.width * 0.5,
                                                      decoration: BoxDecoration(
                                                          color: AppCustomColors
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      child: Center(
                                                        child: Text(
                                                          "UPDATE",
                                                          style: KTextStyle
                                                              .subTitle3
                                                              .copyWith(
                                                                  color: KColor
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    '\$ ${item.unitTotalAmount}',
                                                    style: KTextStyle.subTitle3
                                                        .copyWith(
                                                            color: KColor.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text("Cart is Empty!"),
                            )),
                ),

                ///
                Container(
                  //height: KSize.getHeight(context, 200),
                  color: KColor.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: KSize.getWidth(context, 11),
                        vertical: KSize.getHeight(context, 20)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sub Total',
                                  style: KTextStyle.headline8
                                      .copyWith(color: KColor.gray),
                                ),
                                Text(
                                  '(Without tax & delivery charge)',
                                  style: TextStyle(
                                      color: KColor.gray, fontSize: 14),
                                ),
                              ],
                            ),
                            Obx(() {
                              return Text(
                                '\$ ${controller.cart.value.subTotal ?? 0.0}',
                                style: KTextStyle.headline8
                                    .copyWith(color: KColor.gray),
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: KSize.getHeight(context, 14)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: InkWell(
                    onTap: () async {
                      if (controller.cartList.length > 0) {
                        controller.getAllDeliveryType(
                            storeId: controller.cartList.first.storeId);
                        Get.to(() => DeliveryOrPickupScreen());
                      } else {
                        Utils.showSnackBar(
                            context, "Cart is empty please Add item");
                      }
                    },
                    child: Container(
                      height: KSize.getHeight(context, 55),
                      color: KColor.primary,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: KSize.getWidth(context, 22)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.shopping_cart,
                                      size: 25,
                                      color: AppCustomColors.whiteColor,
                                    ),
                                  ),
                                  Positioned(
                                    top: 7,
                                    left: 30,
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(7.5),
                                      ),
                                      child: Obx(() {
                                        return Center(
                                          child: Text(
                                            "${controller.cartLength.value}",
                                            style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold,
                                                color: AppCustomColors
                                                    .primaryColor),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Checkout now',
                              style: KTextStyle.headline8.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: KColor.white),
                            ),
                            Spacer(),
                            Obx(() {
                              return Text(
                                'Pay \$ ${controller.cart.value.total ?? 0.0}',
                                style: KTextStyle.headline8.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: KColor.white),
                              );
                            }),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: KColor.white,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomNav(navContext: context, index: 3),
        ],
      ),
    );
  }
}
