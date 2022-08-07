import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/modules/appIntroduction/onBoardingSliders/controller/onBoardingPageController.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/view/firsthubSelectionScreen.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

import 'pages/onBoardingPage1.dart';
import 'pages/onBoardingPage2.dart';
import 'pages/onBoardingPage3.dart';
import 'pages/onBoardingPage4.dart';
import 'pages/onBoardingPage5.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _currentPage = 0;

  final List<Widget> list = [
    OnBoardingPage1(),
    OnBoardingPage2(),
    OnBoardingPage3(),
    OnBoardingPage4(),
    OnBoardingPage5()
  ];
  PageController _controller = PageController(
    initialPage: 0,
  );

  onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: KColor.white,
      body: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            // height: MediaQuery.of(context).size.height,
            height: _height / 1.18,
            child: PageView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              physics: BouncingScrollPhysics(),
              onPageChanged: onChanged,
              itemBuilder: (context, int index) {
                return list[index];
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 18, top: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(5, (int index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: KSize.getHeight(
                      context, (index == _currentPage) ? 12 : 10),
                  width: KSize.getWidth(
                      context, (index == _currentPage) ? 12 : 10),
                  margin: EdgeInsets.only(
                      left: KSize.getWidth(context, 5),
                      bottom: KSize.getHeight(context, 0)),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //borderRadius: BorderRadius.circular(20),
                      color: (index == _currentPage)
                          ? KColor.primary
                          : KColor.lightGray),
                );
              }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // context.nextPage(SignInScreen());
                  controller.setRout(1);
                  Utils.navigateToPage(context, FirstHubSelection(), 250, true);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: _width / 12, vertical: _width / 38),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppCustomColors.greyTextColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Text(
                    'Skip',
                    style: KTextStyle.headline8.copyWith(color: KColor.gray),
                  ),
                ),
              ),
              SizedBox(
                width: _width / 10,
              ),
              (_currentPage == (list.length - 1))
                  ? GestureDetector(
                      onTap: () {
                        controller.setRout(1);
                        Utils.navigateToPage(
                            context, FirstHubSelection(), 250, true);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: _width / 12, vertical: _width / 38),
                        decoration: BoxDecoration(
                            color: AppCustomColors.primaryColor,
                            border: Border.all(
                                color: AppCustomColors.primaryColor, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Text(
                          'Next',
                          style: KTextStyle.headline8
                              .copyWith(color: KColor.white),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOutQuint);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: _width / 12, vertical: _width / 38),
                        decoration: BoxDecoration(
                            color: AppCustomColors.primaryColor,
                            border: Border.all(
                                color: AppCustomColors.primaryColor, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Text(
                          'Next',
                          style: KTextStyle.headline8
                              .copyWith(color: KColor.white),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
