import 'package:flutter/material.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_button.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/resetPassword/controller/resetPasswordController.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/widget/signIn/signIn_screen.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

import 'verificationScreen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final SentResetPasswordCodeController _resetPasswordController =
      Get.put(SentResetPasswordCodeController());
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
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 36),
              children: [
                SizedBox(height: KSize.getHeight(context, 210)),
                Text(
                  'Forgot Password',
                  textAlign: TextAlign.center,
                  style: KTextStyle.headline3,
                ),
                SizedBox(height: KSize.getHeight(context, 25)),
                Text(
                  'Please enter your registered',
                  textAlign: TextAlign.center,
                  style: KTextStyle.subTitle1.copyWith(color: KColor.gray),
                ),
                Text(
                  'email address or mobile number',
                  textAlign: TextAlign.center,
                  style: KTextStyle.subTitle1
                      .copyWith(color: KColor.gray, height: 1.5),
                ),
                SizedBox(height: KSize.getHeight(context, 32)),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppCustomColors.primaryColor.withOpacity(0.5),
                        width: 3),
                    color: AppCustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (value) {
                      _resetPasswordController.phone.value = value.phoneNumber!;
                    },
                    initialValue: PhoneNumber(dialCode: "+1", isoCode: "US"),
                    onSaved: (value) => _resetPasswordController.phone.value =
                        value.phoneNumber!,
                  ),
                ),
                SizedBox(height: KSize.getHeight(context, 16)),
                Text(
                  'Or',
                  textAlign: TextAlign.center,
                  style: KTextStyle.subTitle1
                      .copyWith(color: KColor.gray, height: 1.5),
                ),
                SizedBox(height: KSize.getHeight(context, 16)),
                Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: AppCustomColors.primaryColor.withOpacity(0.5),width: 3),
                    color: AppCustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(15.0),
                    child: TextFormField(
                      onChanged: (value) {
                        _resetPasswordController.email.value = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter your email address",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: AppCustomColors.primaryColor, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: AppCustomColors.primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: AppCustomColors.primaryColor, width: 2),
                        ),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppCustomColors.greyTextColor,
                            fontFamily: 'Poppins'),
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppCustomColors.greyTextColor,
                        ),
                        //errorText: _validationTextPassword,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                SizedBox(height: KSize.getHeight(context, 59)),
                KButton(
                  buttonText: 'Send Code',
                  borderRadius: 12,
                  onPressed: () async {
                    if (_resetPasswordController.phone.value.isNotEmpty) {
                      try {
                        MyDialog.loadingDialog(context, "Sending OTP");
                        final response =
                            await _resetPasswordController.sendCodeByPhone();
                        print(response.success);
                        MyDialog.closeDialog(context);
                        if (response.result != null) {
                          Utils.showSnackBar(context, "OTP Sent Successful");
                          Utils.navigateToPage(
                              context,
                              VerificationScreen(
                                  type: "phone",
                                  emailOrPhone: response.result!.phone!),
                              250,
                              false);
                        } else {
                          Utils.showSnackBar(context, response.error!.message!);
                        }
                      } catch (e) {
                        Utils.showSnackBar(context, "Can not sent OTP");
                      }
                    } else if (_resetPasswordController
                        .email.value.isNotEmpty) {
                      try {
                        MyDialog.loadingDialog(context, "Sending OTP");
                        final response =
                            await _resetPasswordController.sendCodeByEmail();
                        MyDialog.closeDialog(context);
                        if (response.result != null) {
                          Utils.showSnackBar(context, "OTP Sent Successful");
                          Utils.navigateToPage(
                              context,
                              VerificationScreen(
                                  type: 'email',
                                  emailOrPhone: response.result!.email!),
                              250,
                              true);
                        } else {
                          Utils.showSnackBar(context, response.error!.message!);
                        }
                      } catch (e) {
                        Utils.showSnackBar(context, "Can not sent OTP");
                      }
                    }
                  },
                ),
                SizedBox(height: KSize.getHeight(context, 30)),
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
