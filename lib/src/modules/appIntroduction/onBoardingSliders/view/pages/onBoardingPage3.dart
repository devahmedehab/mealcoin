import 'dart:io';

import 'package:flutter/material.dart';

import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class OnBoardingPage3 extends StatelessWidget {
  final List<String> countryName = [
    'American',
    'Italian',
    'Indian',
    'Chinese',
    'Mexican',
    'Mediterranean',
    'Pakistani',
    'Latin American',
    'Halal',
    'Veggie',
  ];
  final List<String> foodImageList = [
    'assets/images/food1.jpg',
    'assets/images/food2.png',
    'assets/images/food3.png',
    'assets/images/food4.png',
    'assets/images/food5.png',
    'assets/images/food6.png',
    'assets/images/food7.png',
    'assets/images/food8.png',
  ];

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Container(
      color: KColor.white,
      child: Column(
        children: [
          SizedBox(height: _height / 14),
          Image.asset(
            'assets/images/logo2.png',
            // height: KSize.getHeight(context, _width/4),
            width: KSize.getWidth(context, _width / 4),
            fit: BoxFit.contain,
          ),
          SizedBox(height: 12),
          Text(
            'Popular Cuisine and Diet Foods',
            textAlign: TextAlign.center,
            style: KTextStyle.subTitle3.copyWith(
              fontSize: _width / 21,
              letterSpacing: 1,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: Platform.isAndroid ? 50 : _height / 70),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Platform.isAndroid ? _width / 15 : _width / 12),
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  //only(bottom: kBottomNavigationBarHeight),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.09,
                    crossAxisSpacing:
                        Platform.isAndroid ? _width / 14 : _width / 30,
                    mainAxisSpacing: _width / 10,
                  ),
                  itemCount: countryName.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        //context.nextPage(DetailsScreen());
                      },
                      child: Card(
                        elevation: 1,
                        shadowColor: KColor.shade.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: KColor.whiteSmoke,
                            border: Border.all(color: KColor.shade),
                            boxShadow: [
                              BoxShadow(
                                  color: KColor.shade, offset: Offset(0, -1)),
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            countryName[index],
                            style: KTextStyle.overLine.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.5,
                                fontFamily: 'Poppins',
                                color: KColor.primary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
