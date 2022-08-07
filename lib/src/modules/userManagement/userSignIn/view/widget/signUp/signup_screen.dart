import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/common/validators/form_validator.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_button.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/logIn_with_fb_button.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/profileDetails/view/user_dashbord_screen.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/controller/signup_controller.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/widget/signIn/signIn_screen.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userVerification/view/widget/mobileVerification/mobile_verification_screen.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _signUpController = Get.put(SignUpController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KColor.white,
      body: Container(
        height: _height,
        width: _width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: KSize.getHeight(context, 20)),
                Image.asset(
                  'assets/images/logo3.png',
                  height: KSize.getHeight(context, 80),
                  width: KSize.getWidth(context, 80),
                  fit: BoxFit.contain,
                ),
                SizedBox(height: KSize.getHeight(context, 24)),
                Container(
                  width: _width,
                  alignment: Alignment.center,
                  child: Text(
                    'Create Chefs & Meals Account',
                    style: KTextStyle.headline6
                        .copyWith(color: AppCustomColors.primaryColor),
                  ),
                ),
                SizedBox(height: KSize.getHeight(context, 17)),
                LogInWithFbButton(
                  onPressed: () async {
                    try {
                      var response =
                          await _signUpController.loginWithFacebook();
                      if (response.success) {
                        if (response.result!.accessToken == null) {
                          Utils.showSnackBar(
                              context, "${response.error!.message}");
                        } else {
                          Utils.showSnackBar(context, "Login Successful");
                          Get.to(() => UserDashBoardPage());
                        }
                      } else {
                        Utils.showSnackBar(context, response.error!.message!);
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
                SizedBox(height: KSize.getHeight(context, 12)),
                !Platform.isIOS
                    ? Container()
                    : Container(
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
                            final response =
                                await _signUpController.signInWithApple();
                            if (response!.success) {
                              if (response.result!.accessToken == null) {
                                Utils.showSnackBar(
                                    context, "${response.error!.message}");
                              } else {
                                Utils.showSnackBar(
                                    context, "Signup Successful");
                                Get.off(() => UserDashBoardPage());
                              }
                            } else {
                              Utils.showSnackBar(
                                  context, response.error!.message!);
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
                        )),
                SizedBox(height: KSize.getHeight(context, 12)),
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
                SizedBox(height: KSize.getHeight(context, 12)),
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
                      onPressed: () {
                        // SignInApple.clickAppleSignIn();
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
                SizedBox(height: KSize.getHeight(context, 22)),
                Divider(
                  color: AppCustomColors.greyTextColor,
                  thickness: 1,
                ),
                SizedBox(height: KSize.getHeight(context, 12)),
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
                        labelText: "First Name",
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
                          Icons.person,
                          color: AppCustomColors.greyTextColor,
                        ),
                        //errorText: _validationTextPassword,
                      ),
                      keyboardType: TextInputType.name,
                      onSaved: (value) =>
                          _signUpController.firstName.value = value!,
                    ),
                  ),
                ),
                SizedBox(height: KSize.getHeight(context, 12)),
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
                        labelText: "Last Name",
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
                          Icons.person,
                          color: AppCustomColors.greyTextColor,
                        ),
                        //errorText: _validationTextPassword,
                      ),
                      keyboardType: TextInputType.name,
                      onSaved: (value) =>
                          _signUpController.lastName.value = value!,
                    ),
                  ),
                ),
                SizedBox(height: KSize.getHeight(context, 14)),
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
                      validator: FormValidator.emailValidator,
                      decoration: InputDecoration(
                        labelText: "Email Address",
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
                      onSaved: (value) =>
                          _signUpController.email.value = value!,
                    ),
                  ),
                ),
                SizedBox(height: KSize.getHeight(context, 14)),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppCustomColors.primaryColor, width: 2),
                    color: AppCustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Obx(() {
                    return InternationalPhoneNumberInput(
                      inputBorder: InputBorder.none,
                      spaceBetweenSelectorAndTextField: 2,
                      onInputChanged: (value) {
                        print(value);
                        _signUpController.initialDialCode.value =
                            value.dialCode!;
                        _signUpController.initialIsoCode.value = value.isoCode!;
                      },
                      initialValue: PhoneNumber(
                          dialCode: _signUpController.initialDialCode.value,
                          isoCode: _signUpController.initialIsoCode.value),
                      validator: (value) {},
                      onSaved: (value) =>
                          _signUpController.phone.value = value.phoneNumber!,
                    );
                  }),
                ),
                SizedBox(height: KSize.getHeight(context, 14)),
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
                                color: AppCustomColors.primaryColor, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppCustomColors.primaryColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppCustomColors.primaryColor, width: 2),
                          ),
                          prefixIcon: IconButton(
                              icon: Icon(
                                _signUpController.isPasswordVisible.value
                                    ? Icons.lock_open_rounded
                                    : Icons.lock_rounded,
                                color: _signUpController.isPasswordVisible.value
                                    ? AppCustomColors.primaryColor
                                    : AppCustomColors.greyTextColor,
                              ),
                              onPressed: () {
                                _signUpController.isPasswordVisible.toggle();
                              }),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppCustomColors.greyTextColor,
                              fontFamily: 'Poppins'),
                          // errorText: _validationTextPassword,
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: (value) =>
                            _signUpController.password.value = value,
                        onSaved: (value) =>
                            _signUpController.password.value = value!,
                        obscureText: !_signUpController.isPasswordVisible.value,
                      );
                    }),
                  ),
                ),
                SizedBox(height: KSize.getHeight(context, 14)),
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
                        validator: (value) {
                          if (_signUpController.password.value != value) {
                            return "Passwords do not match!";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppCustomColors.primaryColor, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppCustomColors.primaryColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppCustomColors.primaryColor, width: 2),
                          ),
                          prefixIcon: IconButton(
                              icon: Icon(
                                _signUpController.isConfirmPasswordVisible.value
                                    ? Icons.lock_open_rounded
                                    : Icons.lock_rounded,
                                color: _signUpController
                                        .isConfirmPasswordVisible.value
                                    ? AppCustomColors.primaryColor
                                    : AppCustomColors.greyTextColor,
                              ),
                              onPressed: () {
                                _signUpController.isConfirmPasswordVisible
                                    .toggle();
                              }),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppCustomColors.greyTextColor,
                              fontFamily: 'Poppins'),
                          // errorText: _validationTextPassword,
                        ),
                        keyboardType: TextInputType.text,
                        onSaved: (value) =>
                            _signUpController.confirmPassword.value = value!,
                        obscureText:
                            !_signUpController.isConfirmPasswordVisible.value,
                      );
                    }),
                  ),
                ),
                SizedBox(height: KSize.getHeight(context, 14)),
                KButton(
                  buttonText: 'Sign Up',
                  borderRadius: 12,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        final response =
                            await _signUpController.signUpWithEmail();
                        if (response.result!.phone != null) {
                          Utils.showSnackBar(
                              context, "User successfully created");
                          Utils.navigateToPage(
                              context,
                              MobileVerificationScreen(
                                phone: response.result!.phone!,
                                email: _signUpController.email.value,
                                password: _signUpController.password.value,
                              ),
                              300,
                              true);
                        } else {
                          Utils.showSnackBar(context, response.error!.message!);
                        }
                      } catch (e) {
                        Utils.showSnackBar(context, "Unable to create User");
                      }
                    }
                  },
                ),
                SizedBox(height: KSize.getHeight(context, 32)),
                Divider(
                  color: AppCustomColors.greyTextColor,
                  thickness: 1,
                ),
                SizedBox(height: KSize.getHeight(context, 10)),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "By creating your Chefs & Meals account you agree to the",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.none,
                      fontSize: 14,
                      color: AppCustomColors.blackColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Utils.launchURL(
                              "https://www.chefsnmeals.com/termsOfUse");
                        },
                        child: Text(
                          "Terms of Use",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            color: AppCustomColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "and",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          decoration: TextDecoration.none,
                          fontSize: 14,
                          color: AppCustomColors.blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Utils.launchURL(
                              "https://www.chefsnmeals.com/privacy-policy");
                        },
                        child: Text(
                          "Privacy Policy",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            color: AppCustomColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: KSize.getHeight(context, 32)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Already a member? ",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          decoration: TextDecoration.none,
                          fontSize: _width / 24,
                          color: AppCustomColors.greyTextColor,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Utils.navigateToPage(
                            context, SignInScreen(), 250, true);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          decoration: TextDecoration.none,
                          fontSize: _width / 24,
                          color: AppCustomColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: KSize.getHeight(context, 32)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
