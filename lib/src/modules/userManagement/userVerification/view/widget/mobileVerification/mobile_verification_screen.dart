import 'package:flutter/material.dart';

import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_button.dart';
import 'package:chefsandmeals_customer/src/models/requests/index.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/profileDetails/view/user_dashbord_screen.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userVerification/controller/userVerificationController.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class MobileVerificationScreen extends StatelessWidget {
  final VerificationController _verificationController =
      Get.put(VerificationController());

  MobileVerificationScreen(
      {Key? key, this.phone, this.email, this.password, this.type})
      : super(key: key);

  final String? phone;
  final String? email;
  final String? password;
  final String? type;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 600;
  @override
  Widget build(BuildContext context) {
    CountdownTimerController controller =
        CountdownTimerController(endTime: endTime);
    return Scaffold(
      backgroundColor: KColor.white,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            //SizedBox(height: KSize.getHeight(context, 60)),
            Container(
              height: KSize.getHeight(context, 230),
              color: KColor.primary,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo3.png',
                height: KSize.getHeight(context, 127),
                width: KSize.getWidth(context, 127),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: KSize.getHeight(context, 76)),
            Text(
              'Mobile Verification Code',
              style: KTextStyle.headline5,
            ),
            SizedBox(height: KSize.getHeight(context, 25)),
            Text(
              'Please Type the verification code',
              style: KTextStyle.subTitle1.copyWith(color: KColor.gray),
            ),
            Text(
              'sent to ${phone ?? email}',
              style: KTextStyle.subTitle1
                  .copyWith(color: KColor.gray, height: 1.5),
            ),
            SizedBox(height: KSize.getHeight(context, 74)),

            /// Sms autofill
            Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: KSize.getWidth(context, 23)),
                child: PinFieldAutoFill(
                  decoration: UnderlineDecoration(
                    textStyle: TextStyle(fontSize: 20, color: Colors.black),
                    colorBuilder: FixedColorBuilder(KColor.lightGray),
                  ),
                  codeLength: 6,
                  currentCode: _verificationController.code.value,
                  onCodeSubmitted: (code) {
                    _verificationController.code.value = code;
                  },
                  onCodeChanged: (code) {
                    _verificationController.code.value = code!;
                    if (code.length == 4) {}
                  },
                ),
              );
            }),
            SizedBox(height: KSize.getHeight(context, 57)),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 41)),
              child: KButton(
                buttonText: 'Verify Now',
                onPressed: () async {
                  MyDialog.loadingDialog(context, "Verifying");
                  if (type != null) {
                    if (type == "phone") {
                      final response =
                          await _verificationController.VerifyPhone(phone!);
                      MyDialog.closeDialog(context);
                      if (response) {
                        Get.to(() => UserDashBoardPage());
                      }
                    } else {
                      final response =
                          await _verificationController.VerifyEmail(email!);
                      MyDialog.closeDialog(context);
                      if (response) {
                        Get.to(() => UserDashBoardPage());
                      }
                    }
                  } else {
                    final response =
                        await _verificationController.verifyOtp(phone!);
                    MyDialog.closeDialog(context);
                    if (response.result != null) {
                      if (response.result!.canLogin!) {
                        final signInResponse = await _verificationController
                            .signInWithEmail(LoginRequest(
                                userNameOrEmailAddress: email!,
                                password: password!));
                        if (signInResponse.result!.accessToken != null) {
                          Utils.showSnackBar(
                              context, "Verification Successful");
                          Get.to(() => UserDashBoardPage());
                        }
                      }
                    } else {
                      Utils.showSnackBar(context, "Can not verify OTP!");
                    }
                  }
                },
              ),
            ),
            SizedBox(height: KSize.getHeight(context, 57)),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 41)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CountdownTimer(
                    endTime: endTime,
                    controller: controller,
                    widgetBuilder: (context, CurrentRemainingTime? time) {
                      if (time == null) {
                        return TextButton(
                          onPressed: () async {
                            var response =
                                await _verificationController.resendOtp(phone!);
                            if (response.result != null) {
                              controller.start();
                            } else {
                              Utils.showSnackBar(
                                  context, "Unable to resend OTP");
                            }
                          },
                          child: Text('Resend',
                              style: KTextStyle.subTitle1.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: KColor.primary)),
                        );
                      }
                      return Text(
                          'Resend OTP ${time.min}, ${time.sec} min left');
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: KSize.getHeight(context, 70)),
          ],
        ),
      ),
    );
  }
}
