import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/bottomNav/customBottomNavigationBar.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_response.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/controller/cartController.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/view/cartScreen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/controller/landing_page_controller.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/profile_decider_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductResult product;

  ProductCard({Key? key, required this.product}) : super(key: key);

  final landingPageController = Get.put(LandingPageController());

  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Container(
      key: _key,
      padding: EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
        child: Material(
          elevation: 2,
          child: Column(
            children: [
              Stack(
                children: [
                  product.picture != null
                      ? Container(
                          height: _height / 4,
                          width: _width,
                          child: FancyShimmerImage(
                            imageUrl: product.picture!,
                            height: _height / 4,
                            //width: _width,
                            boxFit: BoxFit.fitWidth,
                          ),
                        )
                      : Container(
                          height: _height / 4,
                          width: _width,
                          child: Image.asset("assets/images/place_holder.png"),
                        ),
                  SizedBox(
                    height: 8,
                  ),
                  Positioned(
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                      child: Container(
                        width: _width - 48,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        color: AppCustomColors.blackColor.withOpacity(0.4),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productName!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                decoration: TextDecoration.none,
                                fontSize: 16,
                                color: AppCustomColors.whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.storefront,
                                  size: 15,
                                  color: AppCustomColors.primaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  product.storeName!,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
                                    color: AppCustomColors.whiteColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 5,
                      child: IconButton(
                          onPressed: () async {
                            final result = await landingPageController
                                .addProductToWishList(product.productId!);
                            if (result) {
                              if (landingPageController.contactId.value == 0) {
                                Utils.showSnackBar(context,
                                    "Login required for adding product to WishList");
                                Get.to(() => ProfileDeciderScreen());
                              } else {
                                Get.snackbar(
                                  "WishList",
                                  "Add to WishList successful",
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppCustomColors.primaryColor,
                                );
                              }
                            }
                          },
                          icon: Icon(
                            Icons.favorite_border,
                            color: AppCustomColors.primaryColor,
                          )))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.none,
                            fontSize: 16,
                            color: AppCustomColors.greyTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        product.salesPrice != null
                            ? Row(
                                children: [
                                  Text(
                                    "\$ ${product.salesPrice}",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      decoration: TextDecoration.none,
                                      fontSize: 18,
                                      color: AppCustomColors.blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "\$ ${product.regularPrice}",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.red,
                                      decorationThickness: 3,
                                      fontSize: 18,
                                      color: AppCustomColors.blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            : Text(
                                "\$ ${product.regularPrice}",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  decoration: TextDecoration.none,
                                  fontSize: 18,
                                  color: AppCustomColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                      ],
                    ),
                    product.membershipTypeName != null
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/chefs_heart_white_background.gif",
                                    height: 20,
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${product.membershipTypeName}",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      color: AppCustomColors.greyTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "\$ ${product.membershipPrice}",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  decoration: TextDecoration.none,
                                  fontSize: 18,
                                  color: AppCustomColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              final cartController = Get.put(CartController());
                              cartController.getAllDeliveryType(
                                  storeId: product.storeId);
                              if (cartController.deliveryTypeList.length > 0) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                        title: Text("Service Type"),
                                        content: Container(
                                          height: 100,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: cartController
                                                .deliveryTypeList.length,
                                            itemBuilder: (context, index) {
                                              var item = cartController
                                                  .deliveryTypeList[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    Text("${item.displayName}"),
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
                                                MyDialog.loadingDialog(context,
                                                    "Adding Product To Cart");
                                                if (landingPageController
                                                        .contactId.value ==
                                                    0) {
                                                  Get.back();
                                                  Utils.showSnackBar(
                                                      _key.currentContext!,
                                                      "Login required for adding product to cart");
                                                  Get.to(() =>
                                                      ProfileDeciderScreen());
                                                } else {
                                                  await cartController
                                                      .getAllCart();
                                                  if (cartController
                                                          .cartList.length >
                                                      0) {
                                                    if (product.storeId ==
                                                        cartController.cartList
                                                            .first.storeId) {
                                                      final result =
                                                          await landingPageController
                                                              .addProductToCart(
                                                                  product
                                                                      .productId!,
                                                                  product
                                                                      .storeId!);
                                                      if (result) {
                                                        Get.back();
                                                        Utils.showSnackBar(
                                                            _key.currentContext!,
                                                            "Add to Cart successful");
                                                      } else {
                                                        Get.back();
                                                        Utils.showSnackBar(
                                                            _key.currentContext!,
                                                            "Unable adding product to cart");
                                                      }
                                                    } else {
                                                      Get.back();
                                                      Get.defaultDialog(
                                                        title:
                                                            "Delete Cart Item",
                                                        content: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "You have cart item from different store\nDo you want to Delete Existing cart item?"),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              child:
                                                                  Text("NO")),
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                Get.back();
                                                                await cartController
                                                                    .clearCart();
                                                                final result = await landingPageController
                                                                    .addProductToCart(
                                                                        product
                                                                            .productId!,
                                                                        product
                                                                            .storeId!);
                                                                await cartController
                                                                    .getAllCart();
                                                                if (result) {
                                                                  Utils.showSnackBar(
                                                                      _key.currentContext!,
                                                                      "Add to Cart successful");
                                                                } else {
                                                                  Utils.showSnackBar(
                                                                      _key.currentContext!,
                                                                      "Unable adding product to cart");
                                                                }
                                                              },
                                                              child:
                                                                  Text("YES")),
                                                        ],
                                                      );
                                                    }
                                                  } else {
                                                    final result =
                                                        await landingPageController
                                                            .addProductToCart(
                                                                product
                                                                    .productId!,
                                                                product
                                                                    .storeId!);
                                                    if (result) {
                                                      Get.back();
                                                      Utils.showSnackBar(
                                                          _key.currentContext!,
                                                          "Add to Cart successful");
                                                    } else {
                                                      Get.back();
                                                      Utils.showSnackBar(
                                                          _key.currentContext!,
                                                          "Unable adding product to cart");
                                                    }
                                                  }
                                                }
                                              },
                                              child: Text("Add To Cat")),
                                        ]);
                                  },
                                );
                              } else {
                                MyDialog.closeDialog(context);
                                Utils.showSnackBar(
                                    context, "No Service type found");
                              }
                            },
                            icon: Icon(Icons.shopping_cart_outlined,color: AppCustomColors.primaryColor,)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
