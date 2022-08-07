import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_button.dart';
import 'package:chefsandmeals_customer/src/models/requests/index.dart';
import 'package:chefsandmeals_customer/src/models/requests/verify_Email_otp_request.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/resetPassword/controller/reset_password_code_verify_controller.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/widget/signIn/signIn_screen.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

import '../../resetPasswordScreen.dart';

class VerificationScreen extends StatefulWidget {
  final String type;
  final String emailOrPhone;
  const VerificationScreen(
      {Key? key, required this.type, required this.emailOrPhone})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  Timer? _timer;
  int _start = 10;
  bool resendDisable = false;
  void startTimer() {
    setState(() {
      resendDisable = true;
    });
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              timer.cancel();
              setState(() {
                resendDisable = false;
              });
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }
  }

  late StreamController<ErrorAnimationType> errorController;
  final vcFormKey = GlobalKey<FormState>();
  var _vcFPTextController = TextEditingController();
  late String _verificationCode;
  bool isVCValid = false;
  bool hasError = false;
  @override
  void initState() {
    startTimer();
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    _timer?.cancel();
    super.dispose();
  }

  final VerifyResetPassCodeController _verifyResetPassCodeController =
      Get.put(VerifyResetPassCodeController());
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: _width,
        height: _height,
        child: Stack(
          children: [
            Form(
              key: vcFormKey,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 36),
                children: [
                  SizedBox(height: KSize.getHeight(context, 210)),
                  Text(
                    'Verification Code',
                    textAlign: TextAlign.center,
                    style: KTextStyle.headline3,
                  ),
                  SizedBox(height: KSize.getHeight(context, 25)),
                  Text(
                    'Please type the verification code',
                    textAlign: TextAlign.center,
                    style: KTextStyle.subTitle1.copyWith(color: KColor.gray),
                  ),
                  Text(
                    'sent to you email or phone number',
                    textAlign: TextAlign.center,
                    style: KTextStyle.subTitle1
                        .copyWith(color: KColor.gray, height: 1.5),
                  ),
                  SizedBox(height: KSize.getHeight(context, 32)),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: false,
                        obscuringCharacter: '*',
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "Please enter the 6 digit code";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 60,
                          fieldWidth: _width / 8,
                          fieldOuterPadding: EdgeInsets.only(left: 5),
                          activeFillColor: Colors.white,
                          selectedColor: AppCustomColors.primaryColor,
                          selectedFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          inactiveColor: Colors.grey,
                          activeColor: AppCustomColors.primaryColor,
                        ),
                        cursorColor: AppCustomColors.primaryColor,
                        animationDuration: Duration(milliseconds: 300),
                        textStyle: TextStyle(fontSize: 20, height: 1.6),
                        backgroundColor: Colors.white,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: _vcFPTextController,
                        keyboardType: TextInputType.number,
                        boxShadows: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          print(_verificationCode);
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          setState(() {
                            _verificationCode = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      )),
                  SizedBox(height: KSize.getHeight(context, 42)),
                  KButton(
                    buttonText: 'Verify Now',
                    borderRadius: 12,
                    onPressed: () async {
                      if (vcFormKey.currentState!.validate()) {
                        vcFormKey.currentState!.save();
                        if (widget.type == "phone") {
                          try {
                            MyDialog.loadingDialog(context, "Verifying");
                            final response =
                                await _verifyResetPassCodeController
                                    .verifyCodeByMobile(VerifyPhoneOtpRequest(
                                        phone: widget.emailOrPhone,
                                        confirmationCode:
                                            _vcFPTextController.text));
                            MyDialog.closeDialog(context);
                            if (response.result != null) {
                              Utils.showSnackBar(context, "Verify Successful");
                              if (response.result!.canReset!) {
                                Utils.navigateToPage(
                                    context,
                                    ResetPasswordScreen(
                                      email: widget.emailOrPhone,
                                    ),
                                    300,
                                    true);
                              }
                            } else {
                              Utils.showSnackBar(
                                  context, response.error!.message!);
                            }
                          } catch (e) {
                            Utils.showSnackBar(context, "Unable to Verify");
                          }
                        } else {
                          try {
                            MyDialog.loadingDialog(context, "Verifying");
                            final response =
                                await _verifyResetPassCodeController
                                    .verifyCodeByEmail(VerifyEmailOtpRequest(
                                        email: widget.emailOrPhone,
                                        confirmationCode:
                                            _vcFPTextController.text));
                            MyDialog.closeDialog(context);
                            if (response.result != null) {
                              Utils.showSnackBar(context, "Verify Successful");
                            } else {
                              Utils.showSnackBar(
                                  context, response.error!.message!);
                            }
                          } catch (e) {
                            Utils.showSnackBar(context, "Unable to Verify");
                          }
                        }
                      }
                    },
                  ),
                  SizedBox(height: KSize.getHeight(context, 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        resendDisable ? '$_start sec left' : "Resend the code",
                        style: KTextStyle.bodyText2.copyWith(
                          fontSize: 16,
                          color: AppCustomColors.greyTextColor,
                        ),
                      ),
                      InkWell(
                        onTap: resendDisable
                            ? null
                            : () async {
                                MyDialog.loadingDialog(
                                    context, "Sending Code Again");
                                if (widget.emailOrPhone == "phone") {
                                  try {
                                    final response =
                                        await _verifyResetPassCodeController
                                            .reSendCodeByPhone(PhoneRequest(
                                                phone: widget.emailOrPhone));
                                    MyDialog.closeDialog(context);
                                    if (response.result != null) {
                                      setState(() {
                                        _start = 10;
                                        resendDisable = true;
                                        _timer = null;
                                      });
                                      startTimer();
                                      Utils.showSnackBar(
                                          context, "Resent OTP Successful");
                                    } else {
                                      Utils.showSnackBar(
                                          context, response.error!.message!);
                                    }
                                  } catch (e) {
                                    Utils.showSnackBar(
                                        context, "Can not ReSent OTP");
                                  }
                                } else {
                                  final response =
                                      await _verifyResetPassCodeController
                                          .reSendCodeByEmail(EmailRequest(
                                              email: widget.emailOrPhone));
                                  MyDialog.closeDialog(context);
                                  if (response.result != null) {
                                    setState(() {
                                      _start = 10;
                                      resendDisable = true;
                                      _timer = null;
                                    });
                                    startTimer();
                                    Utils.showSnackBar(
                                        context, "Resent OTP Successful");
                                  } else {
                                    Utils.showSnackBar(
                                        context, response.error!.message!);
                                  }
                                }
                              },
                        child: Text(
                          'Resend',
                          style: KTextStyle.bodyText2.copyWith(
                            fontSize: 16,
                            color: resendDisable
                                ? AppCustomColors.greyTextColor
                                : AppCustomColors.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: resendDisable
                                ? AppCustomColors.greyTextColor
                                : AppCustomColors.primaryColor,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: KSize.getHeight(context, 54)),
                  GestureDetector(
                    onTap: () {
                      Utils.navigateToPage(context, SignInScreen(), 250, true);
                    },
                    child: Text(
                      'Back to login',
                      textAlign: TextAlign.center,
                      style: KTextStyle.subTitle1.copyWith(
                          fontSize: 18,
                          color: KColor.gray,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(height: KSize.getHeight(context, 29)),
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                padding: EdgeInsets.only(top: 18),
                width: _width,
                height: KSize.getHeight(context, 200),
                color: KColor.primary,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo3.png',
                  height: KSize.getHeight(context, 127),
                  width: KSize.getWidth(context, 127),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
