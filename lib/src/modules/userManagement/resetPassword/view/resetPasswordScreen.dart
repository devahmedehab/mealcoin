import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/common/validators/form_validator.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_button.dart';
import 'package:chefsandmeals_customer/src/models/requests/index.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/view/landingScreen.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/resetPassword/controller/reset_password_controller.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  final ResetPasswordController _resetPasswordController =
      Get.put(ResetPasswordController());
  final _formKey = GlobalKey<FormState>();

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
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 36),
                children: [
                  SizedBox(height: KSize.getHeight(context, 210)),
                  Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: KTextStyle.headline3,
                  ),
                  SizedBox(height: KSize.getHeight(context, 25)),
                  Text(
                    'Please enter New Password',
                    textAlign: TextAlign.center,
                    style: KTextStyle.subTitle1.copyWith(color: KColor.gray),
                  ),
                  Text(
                    'to reset your password',
                    textAlign: TextAlign.center,
                    style: KTextStyle.subTitle1
                        .copyWith(color: KColor.gray, height: 1.5),
                  ),
                  SizedBox(height: KSize.getHeight(context, 32)),
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: AppCustomColors.primaryColor.withOpacity(0.5),width: 3),
                      color: AppCustomColors.whiteColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Material(
                      elevation: 1,
                      borderRadius: BorderRadius.circular(15.0),
                      child: Obx(() {
                        return TextFormField(
                          validator: FormValidator.notEmptyValidator,
                          obscureText:
                              _resetPasswordController.isPasswordVisible.value,
                          onSaved: (value) {
                            _resetPasswordController.password.value = value!;
                          },
                          decoration: InputDecoration(
                            labelText: "Enter new password",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: AppCustomColors.primaryColor,
                                  width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: AppCustomColors.primaryColor,
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: AppCustomColors.primaryColor,
                                  width: 2),
                            ),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppCustomColors.greyTextColor,
                                fontFamily: 'Poppins'),
                            prefixIcon: IconButton(
                              onPressed: () {
                                _resetPasswordController.isPasswordVisible
                                    .toggle();
                              },
                              icon: Icon(
                                _resetPasswordController.isPasswordVisible.value
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                color: AppCustomColors.greyTextColor,
                              ),
                            ),
                            //errorText: _validationTextPassword,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        );
                      }),
                    ),
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
                      child: Obx(() {
                        return TextFormField(
                          validator: FormValidator.notEmptyValidator,
                          obscureText: _resetPasswordController
                              .isRetypePasswordVisible.value,
                          onSaved: (value) {
                            _resetPasswordController.confirmPassword.value =
                                value!;
                          },
                          decoration: InputDecoration(
                            labelText: "Confirm password",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: AppCustomColors.primaryColor,
                                  width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: AppCustomColors.primaryColor,
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: AppCustomColors.primaryColor,
                                  width: 2),
                            ),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppCustomColors.greyTextColor,
                                fontFamily: 'Poppins'),
                            prefixIcon: IconButton(
                              onPressed: () {
                                _resetPasswordController.isRetypePasswordVisible
                                    .toggle();
                              },
                              icon: Icon(
                                _resetPasswordController
                                        .isRetypePasswordVisible.value
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                color: AppCustomColors.greyTextColor,
                              ),
                            ),
                            //errorText: _validationTextPassword,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: KSize.getHeight(context, 59)),
                  KButton(
                    buttonText: 'Submit',
                    borderRadius: 12,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {
                          MyDialog.loadingDialog(context, 'Resetting Password');
                          final response = await _resetPasswordController
                              .resetPassword(ResetPasswordRequest(
                                  email: email,
                                  password:
                                      _resetPasswordController.password.value));
                          MyDialog.closeDialog(context);
                          if (response.result != null) {
                            Utils.showSnackBar(
                                context, "Password Reset successful");
                            try {
                              MyDialog.loadingDialog(context, "Signing In");
                              final response = await _resetPasswordController
                                  .signInWithEmail(email);
                              MyDialog.closeDialog(context);
                              if (response.result != null) {
                                Utils.showSnackBar(context, "Login Successful");
                                Utils.navigateToPage(
                                    context, LandingScreen(), 300, true);
                                ;
                              } else {
                                Utils.showSnackBar(
                                    context, response.error!.message!);
                              }
                            } catch (e) {
                              Utils.showSnackBar(
                                  context, "Email or Password is incorrect");
                            }
                          } else {
                            Utils.showSnackBar(
                                context, response.error!.message!);
                          }
                        } catch (e) {
                          Utils.showSnackBar(context, 'Password reset failed');
                        }
                      }
                    },
                  ),
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
