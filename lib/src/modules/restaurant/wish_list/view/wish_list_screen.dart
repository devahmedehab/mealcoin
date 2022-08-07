import 'package:flutter/material.dart';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/bottomNav/customBottomNavigationBar.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_app_bar.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/controller/cartController.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/controller/landing_page_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/recent_view/controller/recent_view_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/wish_list/controller/wish_list_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/wish_list/view/widgets/recent_view_list_card.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/wish_list/view/widgets/recent_visit_restuarant_widgets.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/wish_list/view/widgets/wish_list_card.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/widget/signIn/signIn_screen.dart';

import '../../../../common/reusableComponents/textWidget.dart';

class WishListPage extends StatelessWidget {
  WishListPage({Key? key}) : super(key: key);

  final cartController = Get.put(CartController());
  final recentViewController = Get.put(RecentViewController());
  final controller = Get.put(WishListController());
  final landingController = Get.put(LandingPageController());

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: KAppBar(
        isCustomLeading: true,
        customTitle: Text('Favourite'),
      ),
      body: BottomNavBarCustom(
          selectedIndex: 2,
          child: Obx(() => controller.contactId > 0
              ? Container(
                  child: controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 15),
                          child: SingleChildScrollView(
                            physics: ClampingScrollPhysics(),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    recentViewController
                                                .recentStoreList.length >
                                            0
                                        ? customTextWidget(
                                            "Recent Store View",
                                            _width / 24,
                                            FontWeight.w600,
                                            AppCustomColors.blackColor)
                                        : Container(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    recentViewController
                                                .recentStoreList.length >
                                            0
                                        ? RecentRestuarentWidgets(
                                            controller: recentViewController,
                                            cartType: "Popular Restaurant",
                                            onSeeAllPressed: () {},
                                          )
                                        : Container(),
                                    recentViewController
                                                .recentProductList.length >
                                            0
                                        ? customTextWidget(
                                            "Recent Product View",
                                            _width / 24,
                                            FontWeight.w600,
                                            AppCustomColors.blackColor)
                                        : Container(),
                                    recentViewController
                                                .recentProductList.length >
                                            0
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 0),
                                            child: Container(
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      ClampingScrollPhysics(),
                                                  itemCount: recentViewController
                                                      .recentViewProductResult
                                                      .value
                                                      .result!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var item = recentViewController
                                                        .recentViewProductResult
                                                        .value
                                                        .result![index];
                                                    return RecentViewProductCard(
                                                      product: item,
                                                    );
                                                  }),
                                            ),
                                          )
                                        : Container(),
                                    customTextWidget(
                                        "Favorite List",
                                        _width / 24,
                                        FontWeight.w600,
                                        AppCustomColors.blackColor),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    controller.wishList.value.items!.length > 0
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            itemCount: controller
                                                .wishList.value.items!.length,
                                            itemBuilder: (context, index) {
                                              var item = controller
                                                  .wishList.value.items![index];
                                              return WishListCard(
                                                product: item,
                                              );
                                            })
                                        : Container(
                                            height: 200,
                                            child: Center(
                                              child: Text(
                                                  "Favorite List is Empty"),
                                            )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                  // : Center(
                  //     child: Text('Empty WishList'),
                  //   )
                  )
              : SignInScreen())),
    );
  }
}
