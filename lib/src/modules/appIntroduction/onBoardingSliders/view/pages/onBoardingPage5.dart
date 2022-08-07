import 'package:flutter/material.dart';

import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class OnBoardingPage5 extends StatelessWidget {
  const OnBoardingPage5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Container(
      color: KColor.white,
      child: Column(
        children: [
          SizedBox(height: _height / 12),
          Image.asset(
            'assets/images/logo2.png',
            // height: KSize.getHeight(context, _width/4),
            width: KSize.getWidth(context, _width / 4),
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          Text(
            'Personalized Meal Plan',
            textAlign: TextAlign.center,
            style: KTextStyle.subTitle3.copyWith(
              fontSize: _width / 21,
              letterSpacing: 1,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: _height / 15),
          Image.asset(
            'assets/images/foodCircle.png',
            height: _height / 2.17,
            width: double.infinity,
            fit: BoxFit.scaleDown,
          )
        ],
      ),
    );
  }
}
