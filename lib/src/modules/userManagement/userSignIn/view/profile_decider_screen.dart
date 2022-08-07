import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/reusableComponents/bottomNav/customBottomNavigationBar.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/navDrawer/customNav.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/profileDetails/view/user_dashbord_screen.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/controller/profile_decider_controller.dart';

import 'widget/signIn/signIn_screen.dart';

class ProfileDeciderScreen extends StatefulWidget {
  @override
  _ProfileDeciderScreenState createState() => _ProfileDeciderScreenState();
}

class _ProfileDeciderScreenState extends State<ProfileDeciderScreen> {
  bool isNavDrawerClicked = false;
  late DateTime currentBackPressTime;
  Random random = new Random();
  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> exitApp() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
    } else {
      SystemNavigator.pop();
    }

    return Future.value(false);
  }

  final controller = Get.put(ProfileDeciderController());

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          BottomNavBarCustom(
            selectedIndex: 4,
            child: Obx(() => controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.token > 0
                    ? UserDashBoardPage()
                    : SignInScreen()),
          ),
          CustomNav(navContext: context, index: 4),
        ],
      ),
    );
  }
}
