import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/productProfile/view/productProfileScreen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/productProfile/view/widget/product_card.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/restaurantProfile/controller/restaurant_profile_controller.dart';

class TopProductsForRestaurantWidget extends StatelessWidget {
  final String? headerText;
  final RestaurantProfileController controller =
      Get.put(RestaurantProfileController());

  TopProductsForRestaurantWidget({
    Key? key,
    this.headerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return ListView(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: customTextWidget(headerText!, _width / 24, FontWeight.w600,
              AppCustomColors.blackColor),
        ),
        SizedBox(
          height: 18,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          //color: AppCustomColors.whiteColor,
          //height: _height,
          child: Obx(() => ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.topProducts.length,
              itemBuilder: (context, index) {
                var item = controller.topProducts[index];
                return InkWell(
                    onTap: () async {
                      await controller
                          .updateProductRecommendationScore(item.productId!);
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
        ),
      ],
    );
  }
}
