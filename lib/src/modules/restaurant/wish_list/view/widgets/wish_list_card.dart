import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_wishlist_item_response.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/view/cartScreen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/controller/landing_page_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/wish_list/controller/wish_list_controller.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/profile_decider_screen.dart';

class WishListCard extends StatelessWidget {
  final WishListItem product;
  WishListCard({Key? key, required this.product}) : super(key: key);
  final landingPageController = Get.put(LandingPageController());
  final wishListPageController = Get.put(WishListController());

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async {
        MyDialog.loadingDialog(context, "Deleting Item");
        final result = await wishListPageController
            .deleteWishListItem(product.wishList!.id!);
        MyDialog.closeDialog(context);
        if (result) {
          Utils.showSnackBar(context, "Item Deleted");
        } else {
          Utils.showSnackBar(context, "Could not Delete item");
        }
      },
      confirmDismiss: (direction) {
        return Get.defaultDialog(
          title: "DELETE ITEM",
          content: Text("Do you want to delete this item?"),
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
      child: Container(
        padding: EdgeInsets.only(bottom: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
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
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(product.picture!),
                                ),
                                borderRadius: BorderRadius.circular(12)),
                          )
                        : Container(
                            height: _height / 4,
                            width: _width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child:
                                Image.asset("assets/images/place_holder.png"),
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
                                  fontSize: 18,
                                  color: AppCustomColors.whiteColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                      Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                final restaurantId = await landingPageController
                                    .getRestaurantId();
                                if (restaurantId == product.wishList!.storeId ||
                                    restaurantId != 0) {
                                  if (landingPageController.contactId.value ==
                                      0) {
                                    Utils.showSnackBar(context,
                                        "Login required for adding product to cart");
                                    Get.to(() => ProfileDeciderScreen());
                                  } else {
                                    final result = await landingPageController
                                        .addProductToCart(
                                            product.wishList!.productId!,
                                            product.wishList!.storeId!);
                                    if (result) {
                                      await landingPageController
                                          .setRestaurantId(
                                              product.wishList!.storeId!);
                                      Get.snackbar(
                                        "Cart",
                                        "Add to Cart successful",
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor:
                                            AppCustomColors.primaryColor,
                                      );
                                    } else {
                                      Get.snackbar(
                                        "Cart",
                                        "Unable adding product to cart",
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor:
                                            AppCustomColors.primaryColor,
                                      );
                                    }
                                  }
                                } else {
                                  Get.defaultDialog(
                                    title: "Alert!",
                                    content: Text(
                                        "Do you want to Delete Existing cart item?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text("NO")),
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.to(() => AddToCartScreen());
                                          },
                                          child: Text("YES")),
                                    ],
                                  );
                                }
                              },
                              icon: Icon(Icons.shopping_cart)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
