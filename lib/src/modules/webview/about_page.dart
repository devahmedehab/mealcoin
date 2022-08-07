import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/modules/webview/web_view_screen.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("About Policy"),
          backgroundColor: AppCustomColors.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => WebViewContainer(
                        "https://www.chefsnmeals.com/privacy-policy"));
                  },
                  child: Container(
                    width: size.width * 0.4,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                      ),
                      border: Border.all(
                        width: 3,
                        color: AppCustomColors.primaryColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => WebViewContainer(
                          "https://www.chefsnmeals.com/termsOfUse"));
                    },
                    child: Container(
                      width: size.width * 0.4,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                        ),
                        border: Border.all(
                          width: 3,
                          color: AppCustomColors.primaryColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Terms Of Use",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => WebViewContainer(
                          "https://www.chefsnmeals.com/termsOfUse"));
                    },
                    child: Container(
                      width: size.width * 0.4,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                        ),
                        border: Border.all(
                          width: 3,
                          color: AppCustomColors.primaryColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Return Policy",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => WebViewContainer(
                          "https://www.chefsnmeals.com/termsOfUse"));
                    },
                    child: Container(
                      width: size.width * 0.4,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                        ),
                        border: Border.all(
                          width: 3,
                          color: AppCustomColors.primaryColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Reward Point Policy",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
