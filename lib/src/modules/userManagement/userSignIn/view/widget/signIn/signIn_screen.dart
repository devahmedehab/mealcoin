import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/bottomNav/customBottomNavigationBar.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/common/validators/form_validator.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_button.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/logIn_with_fb_button.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/profileDetails/view/user_dashbord_screen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/view/landingScreen.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/resetPassword/view/widget/forgot_password_screen/forgot_password_screen.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/controller/signin_controller.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/widget/signUp/signup_screen.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isPasswordVisible = false;
  bool rememberMe = false;

  void _onRememberMeChanged(bool? newValue) => setState(() {
        print(newValue);
        rememberMe = newValue!;
      });

  final SignInController _signInController = Get.put(SignInController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.white,
      body: BottomNavBarCustom(
        selectedIndex: 0,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: KSize.getWidth(context, 25),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: KSize.getHeight(context, 70)),
                    Image.asset(
                      'assets/images/logo3.png',
                      height: KSize.getHeight(context, 127),
                      width: KSize.getWidth(context, 127),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: KSize.getHeight(context, 28)),
                    Text(
                      'Login Chefs & Meals',
                      style: KTextStyle.headline4,
                    ),
                    SizedBox(height: KSize.getHeight(context, 28)),
                    LogInWithFbButton(
                      onPressed: () async {
                        try {
                          var response =
                              await _signInController.loginWithFacebook();
                          if (response.success) {
                            if (response.result!.accessToken == null) {
                              Utils.showSnackBar(
                                  context, "${response.error!.message}");
                            } else {
                              Utils.showSnackBar(context, "Login Successful");
                              Get.off(() => LandingScreen());
                            }
                          } else {
                            Utils.showSnackBar(
                                context, response.error!.message!);
                          }
                        } catch (e) {
                          Utils.showSnackBar(context, "Unable to Login Now");
                        }
                      },
                      buttonText: 'Continue With Facebook',
                      image: 'assets/images/fbLogo.png',
                      height: KSize.getHeight(context, 50),
                      width: KSize.getWidth(context, 50),
                      textStyle: KTextStyle.subTitle1,
                      iconColor: Colors.white,
                      backgroundColor: Colors.blue.shade900,
                    ),
                    SizedBox(height: KSize.getHeight(context, 19)),
                    Container(
                        height: KSize.getHeight(context, 54),
                        width: context.screenWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                                color: AppCustomColors.primaryColor, width: 2)),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: KColor.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          onPressed: () async {
                            try {
                              var response =
                                  await _signInController.loginWithGoogle();
                              if (response.success) {
                                if (response.result!.accessToken == null) {
                                  Utils.showSnackBar(
                                      context, "${response.error!.message}");
                                } else {
                                  Utils.showSnackBar(
                                      context, "Login Successful");
                                  Get.off(() => LandingScreen());
                                }
                              } else {
                                Utils.showSnackBar(
                                    context, response.error!.message!);
                              }
                            } catch (e) {
                              Utils.showSnackBar(
                                  context, "Unable to Login Now");
                            }
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Transform.translate(
                                offset: Offset(-22, 0),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: KSize.getWidth(context, 6),
                                    top: KSize.getHeight(context, 6),
                                    bottom: KSize.getHeight(context, 6),
                                  ),
                                  child: Image.asset(
                                    'assets/images/googleIcon.png',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              //Spacer(),
                              Transform.translate(
                                  offset: Offset(-15, 0),
                                  child: Text(
                                    "Continue with Google",
                                    style: KTextStyle.subTitle1
                                        .copyWith(color: Colors.black),
                                    //SignInScreen != null?KTextStyle.bodyText:KTextStyle.overLine
                                  )),
                              //Spacer()
                            ],
                          ),
                          //color: Color(0xff00CC96),
                        )),
                    Platform.isIOS
                        ? SizedBox(height: KSize.getHeight(context, 19))
                        : Container(),
                    Platform.isIOS
                        ? Container(
                            height: KSize.getHeight(context, 54),
                            width: context.screenWidth,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                    color: AppCustomColors.primaryColor,
                                    width: 2)),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: KColor.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  )),
                              onPressed: () async {
                                try {
                                  var response =
                                      await _signInController.signInWithApple();
                                  if (response!.success) {
                                    if (response.result!.accessToken == null) {
                                      Utils.showSnackBar(context,
                                          "${response.error!.message}");
                                    } else {
                                      Utils.showSnackBar(
                                          context, "Login Successful");
                                      Get.off(() => LandingScreen());
                                    }
                                  } else {
                                    Utils.showSnackBar(
                                        context, response.error!.message!);
                                  }
                                } catch (e) {
                                  Utils.showSnackBar(
                                      context, "Unable to Login Now");
                                }
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Transform.translate(
                                    offset: Offset(-22, 0),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: KSize.getWidth(context, 6),
                                        top: KSize.getHeight(context, 6),
                                        bottom: KSize.getHeight(context, 6),
                                      ),
                                      child: Image.asset(
                                        'assets/icons/apple.png',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  //Spacer(),
                                  Transform.translate(
                                      offset: Offset(-15, 0),
                                      child: Text(
                                        "Continue with Apple",
                                        style: KTextStyle.subTitle1
                                            .copyWith(color: Colors.black),
                                        //SignInScreen != null?KTextStyle.bodyText:KTextStyle.overLine
                                      )),
                                  //Spacer()
                                ],
                              ),
                              //color: Color(0xff00CC96),
                            ))
                        : Container(),
                    SizedBox(height: KSize.getHeight(context, 10)),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Divider(
                          color: AppCustomColors.greyTextColor,
                          thickness: 1,
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Or",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.none,
                              fontSize: 14,
                              color: AppCustomColors.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: KSize.getHeight(context, 10)),
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
                          validator: FormValidator.notEmptyValidator,
                          decoration: InputDecoration(
                            labelText: "Email Address",
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
                            prefixIcon: Icon(
                              Icons.email,
                              color: AppCustomColors.greyTextColor,
                            ),
                            //errorText: _validationTextPassword,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) => _signInController
                              .userNameOrEmailAddress.value = value!,
                        ),
                      ),
                    ),
                    SizedBox(height: KSize.getHeight(context, 20)),
                    Container(
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.blue.withOpacity(0.5),width: 1),
                        color: AppCustomColors.whiteColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(15.0),
                        child: Obx(() {
                          return TextFormField(
                            validator: FormValidator.notEmptyValidator,
                            decoration: InputDecoration(
                              labelText: "Password",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: AppCustomColors.primaryColor,
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: AppCustomColors.primaryColor,
                                    width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: AppCustomColors.primaryColor,
                                    width: 2),
                              ),
                              prefixIcon: IconButton(
                                  icon: Icon(
                                    _signInController.isPasswordVisible.value
                                        ? Icons.lock_open_rounded
                                        : Icons.lock_rounded,
                                    color: _signInController
                                            .isPasswordVisible.value
                                        ? AppCustomColors.primaryColor
                                        : AppCustomColors.greyTextColor,
                                  ),
                                  onPressed: () {
                                    print('tt');
                                    _signInController.isPasswordVisible
                                        .toggle();
                                  }),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppCustomColors.greyTextColor,
                                  fontFamily: 'Poppins'),
                              // errorText: _validationTextPassword,
                            ),
                            keyboardType: TextInputType.text,
                            onChanged: (value) =>
                                _signInController.password.value = value,
                            onSaved: (value) =>
                                _signInController.password.value = value!,
                            obscureText:
                                !_signInController.isPasswordVisible.value,
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: KSize.getHeight(context, 8)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                checkColor: AppCustomColors.containerBgColor,
                                activeColor: AppCustomColors.primaryColor,
                                value: rememberMe,
                                onChanged: _onRememberMeChanged),
                            // Icon(Icons.check_box_outline_blank_rounded),
                            Text(
                              'Remember Password',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                decoration: TextDecoration.none,
                                fontSize: 14,
                                color: AppCustomColors.blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Utils.navigateToPage(
                                context, ForgotPasswordScreen(), 250, false);
                          },
                          child: Text(
                            'Forgot Password?',
                            style: KTextStyle.bodyText2.copyWith(
                              color: AppCustomColors.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: AppCustomColors.primaryColor,
                              decorationThickness: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: KSize.getHeight(context, 18)),
                    KButton(
                      buttonText: 'Sign In',
                      borderRadius: 12,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          try {
                            MyDialog.loadingDialog(context, "Signing In");
                            final response =
                                await _signInController.signInWithEmail();
                            MyDialog.closeDialog(context);
                            if (response.result != null) {
                              if (response.result!.accessToken == null) {
                                Utils.showSnackBar(context,
                                    "${response.result!.errorMessage}");
                              } else {
                                Utils.showSnackBar(context, "Login Successful");
                                Get.off(() => LandingScreen());
                              }
                            } else {
                              Utils.showSnackBar(
                                  context, response.error!.message!);
                            }
                          } catch (e) {
                            print("MY E $e");
                            Utils.showSnackBar(
                                context, "Email or Password is incorrect");
                          }
                        }
                      },
                    ),
                    /*         SizedBox(height: KSize.getHeight(context, 12)),
                    LogInWithFbButton(
                      onPressed: () async {
                        try {
                          var response =
                              await _signInController.loginWithFacebook();
                          if (response.success) {
                            if (response.result!.accessToken == null) {
                              Utils.showSnackBar(
                                  context, "${response.error!.message}");
                            } else {
                              Utils.showSnackBar(context, "Login Successful");
                              Get.off(() => UserDashBoardPage());
                            }
                          } else {
                            Utils.showSnackBar(
                                context, response.error!.message!);
                          }
                        } catch (e) {
                          Utils.showSnackBar(context, "Unable to Login Now");
                        }
                      },
                      buttonText: 'Continue With Facebook',
                      image: 'assets/images/fbLogo.png',
                      height: KSize.getHeight(context, 50),
                      width: KSize.getWidth(context, 50),
                      textStyle: KTextStyle.subTitle1,
                      iconColor: Colors.white,
                      backgroundColor: Colors.blue.shade900,
                    ),
                    SizedBox(height: KSize.getHeight(context, 19)),
                    Container(
                        height: KSize.getHeight(context, 54),
                        width: context.screenWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                                color: AppCustomColors.primaryColor, width: 2)),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: KColor.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          onPressed: () async {
                            try {
                              var response =
                                  await _signInController.loginWithGoogle();
                              if (response.success) {
                                if (response.result!.accessToken == null) {
                                  Utils.showSnackBar(
                                      context, "${response.error!.message}");
                                } else {
                                  Utils.showSnackBar(
                                      context, "Login Successful");
                                  Get.off(() => UserDashBoardPage());
                                }
                              } else {
                                Utils.showSnackBar(
                                    context, response.error!.message!);
                              }
                            } catch (e) {
                              Utils.showSnackBar(
                                  context, "Unable to Login Now");
                            }
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Transform.translate(
                                offset: Offset(-22, 0),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: KSize.getWidth(context, 6),
                                    top: KSize.getHeight(context, 6),
                                    bottom: KSize.getHeight(context, 6),
                                  ),
                                  child: Image.asset(
                                    'assets/images/googleIcon.png',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              //Spacer(),
                              Transform.translate(
                                  offset: Offset(-15, 0),
                                  child: Text(
                                    "Continue with Google",
                                    style: KTextStyle.subTitle1
                                        .copyWith(color: Colors.black),
                                    //SignInScreen != null?KTextStyle.bodyText:KTextStyle.overLine
                                  )),
                              //Spacer()
                            ],
                          ),
                          //color: Color(0xff00CC96),
                        )),
                    Platform.isIOS
                        ? SizedBox(height: KSize.getHeight(context, 19))
                        : Container(),
                    Platform.isIOS
                        ? Container(
                            height: KSize.getHeight(context, 54),
                            width: context.screenWidth,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                    color: AppCustomColors.primaryColor,
                                    width: 2)),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: KColor.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  )),
                              onPressed: () async {
                                try {
                                  var response =
                                      await _signInController.signInWithApple();
                                  if (response!.success) {
                                    if (response.result!.accessToken == null) {
                                      Utils.showSnackBar(context,
                                          "${response.error!.message}");
                                    } else {
                                      Utils.showSnackBar(
                                          context, "Login Successful");
                                      Get.off(() => UserDashBoardPage());
                                    }
                                  } else {
                                    Utils.showSnackBar(
                                        context, response.error!.message!);
                                  }
                                } catch (e) {
                                  Utils.showSnackBar(
                                      context, "Unable to Login Now");
                                }
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Transform.translate(
                                    offset: Offset(-22, 0),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: KSize.getWidth(context, 6),
                                        top: KSize.getHeight(context, 6),
                                        bottom: KSize.getHeight(context, 6),
                                      ),
                                      child: Image.asset(
                                        'assets/icons/apple.png',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  //Spacer(),
                                  Transform.translate(
                                      offset: Offset(-15, 0),
                                      child: Text(
                                        "Continue with Apple",
                                        style: KTextStyle.subTitle1
                                            .copyWith(color: Colors.black),
                                        //SignInScreen != null?KTextStyle.bodyText:KTextStyle.overLine
                                      )),
                                  //Spacer()
                                ],
                              ),
                              //color: Color(0xff00CC96),
                            ))
                        : Container(),
                    SizedBox(height: KSize.getHeight(context, 22)),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account yet?",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            color: AppCustomColors.blackColor,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Utils.navigateToPage(
                                context, SignUpScreen(), 250, true);
                          },
                          child: Text(
                            'Create Now',
                            style: KTextStyle.caption.copyWith(
                                fontSize: 18,
                                color: KColor.gray,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: KSize.getHeight(context, 18)),
                    /*GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Go Back',
                        style: KTextStyle.caption.copyWith(
                          fontSize: 16,
                          color: KColor.gray,
                        ),
                      ),
                    ),
                    SizedBox(height: KSize.getHeight(context, 51)),*/
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
