import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/modules/restaurant/cart/controller/cartController.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/view/cartScreen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/controller/landing_page_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/view/landingScreen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/wish_list/view/wish_list_screen.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/profile_decider_screen.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/widget/signIn/signIn_screen.dart';

import '../../colors.dart';
import '../../utils.dart';
import 'customPainter.dart';

class BottomNavBarCustom extends StatefulWidget {
  final Widget child;
  final int selectedIndex;
  BottomNavBarCustom(
      {Key? key, required this.child, required this.selectedIndex})
      : super(key: key);
  @override
  _BottomNavBarCustomState createState() => _BottomNavBarCustomState();
}

class _BottomNavBarCustomState extends State<BottomNavBarCustom> {
  late int currentIndex;
  bool tap = false;

  @override
  void initState() {
    setState(() {
      currentIndex = widget.selectedIndex;
    });
    super.initState();
  }

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        widget.child,
        Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 30,
              color: Colors.white,
            )),
        Positioned(
          bottom: 10,
          left: 0,
          child: Container(
            color: AppCustomColors.whiteColor,
            width: size.width,
            height: 50,
            child: Stack(

            //  overflow: Overflow.visible,
              children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: BottomNavigationBarCustomPainter(),
                ),
                Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.home,
                            size: 26,
                            color: currentIndex == 1
                                ? Color(0xffff1616)
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(1);
                            Get.off(() => LandingScreen());
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.favorite_rounded,
                            size: 26,
                            color: currentIndex == 2
                                ? Color(0xffff1616)
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(2);
                            Get.off(() => WishListPage());
                          }),
                      IconButton(
                          onPressed: () async {
                            final controller = Get.put(LandingPageController());
                            await controller.getContactId();
                            if (controller.contactId.value == 0) {
                              setBottomBarIndex(3);
                              Utils.showSnackBar(context,
                                  "Please login for your cart details");
                              Get.off(() => SignInScreen());
                            } else {
                              setBottomBarIndex(3);
                              Get.to(() => AddToCartScreen());
                            }
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            size: 26,
                            color: currentIndex == 3
                                ? Color(0xffff1616)
                                : Colors.grey.shade400,
                          )),
                      IconButton(
                        icon: Icon(
                          Icons.person_pin,
                          size: 26,
                          color: currentIndex == 4
                              ? Color(0xffff1616)
                              : Colors.grey.shade400,
                        ),
                        onPressed: () {
                          setBottomBarIndex(4);
                          Get.off(() => ProfileDeciderScreen());
                        },
                        splashColor: Colors.white,
                      ),
                      /*IconButton(
                          icon: Icon(
                            Icons.menu_rounded,
                            size: currentIndex == 4 ? 38 : 26,
                            color: currentIndex == 4
                                ? Color(0xffff1616)
                                : Colors.grey.shade400,
                          ),
                          onPressed: tap? () {
                            setBottomBarIndex(4);
                          }:null),*/
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
