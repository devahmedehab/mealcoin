import 'package:flutter/material.dart';

import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class OnBoardingPage4 extends StatelessWidget {
  final List<String> percentText = [
    '10% ~ 20%',
    '5% ~ 10%',
    'Reward Points for',
    'Reward Points for',
    'Reward Points for',
  ];
  final List<String> subTitle = [
    'Extra Discounts',
    'Extra Cash Back for Gift Cards',
    'All Meals & Catering Purchases',
    'Customer Referrals',
    'Social Share'
  ];
  final List<String> cardImageList = [
    'assets/images/CARD1 1.png',
    'assets/images/CARD2 1.png',
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
            'SnackPass Discount',
            textAlign: TextAlign.center,
            style: KTextStyle.subTitle3.copyWith(
              fontSize: _width / 21,
              letterSpacing: 1,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: _height / 60),
          Expanded(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: cardImageList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(bottom: _height / 55),
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: _width / 18),
                          child: Image.asset(
                            cardImageList[index],
                            fit: BoxFit.scaleDown,
                          ))
                      /*Container(
                      height: KSize.getHeight(context, 100),
                      margin: EdgeInsets.symmetric(horizontal: _width / 18),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: KColor.redShade,
                            width: 8,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: _width / 32),
                          Container(
                            height: KSize.getHeight(context, 60),
                            width: KSize.getWidth(context, 60),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: KColor.primary, width: 3)),
                            child: Text(
                              '${index + 1}',
                              style: KTextStyle.headline7,
                            ),
                          ),
                          //Spacer(),
                          SizedBox(width: _width / 32),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(percentText[index],
                                    style: KTextStyle.button
                                        .copyWith(fontSize: _width / 26)),
                                Text(
                                  subTitle[index],
                                  style: KTextStyle.button.copyWith(
                                      height: 1,
                                      fontSize: _width / 26,
                                      fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),*/
                      );
                }),
          )
        ],
      ),
    );
  }
}
