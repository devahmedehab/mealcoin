import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/controller/landing_page_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/productProfile/view/productProfileScreen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/productProfile/view/widget/product_card.dart';

class TrendingProductListWidget extends StatelessWidget {
  final String? headerText;
  final LandingPageController controller = Get.put(LandingPageController());
  TrendingProductListWidget({
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
              itemCount: controller.trendingProduct.length,
              itemBuilder: (context, index) {
                var item = controller.trendingProduct[index];
                return InkWell(
                    onTap: () {
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
