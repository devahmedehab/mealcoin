import 'package:flutter/material.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/common/shimmer_loading.dart';
import 'package:chefsandmeals_customer/src/common/string64_image_converter.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_button.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/profileDetails/controller/update_frofile_controller.dart';

class ProfileUpdateScreen extends StatelessWidget {
  final controller = Get.put(UpdateProfileController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppCustomColors.whiteColor,
          child: ListView(
            children: [
              Stack(
                children: [
                  Positioned(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: _height / 3,
                    color: AppCustomColors.primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_rounded,
                                    color: AppCustomColors.whiteColor,
                                  )),
                              customTextWidget("Update Profile", _width / 20,
                                  FontWeight.w400, AppCustomColors.whiteColor),
                            ],
                          ),
                          Spacer(),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(
                                () => Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(60)),
                                  child: controller.user.value.pictureBase64 !=
                                          null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: FancyShimmerImage(
                                              imageUrl: ImageConverter
                                                  .convertStringToImage(
                                                      controller.user.value
                                                          .pictureBase64!),
                                              boxFit: BoxFit.cover,
                                              height: 40),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: Image.asset(
                                              "assets/images/place_holder.png",
                                              height: 40,
                                              fit: BoxFit.cover),
                                        ),
                                ),
                              ),
                              Positioned(
                                  bottom: _height / 150,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      Get.defaultDialog(
                                        title:
                                            "Select From Where do You Want to Pick image!",
                                        content: Container(
                                          height: _height * 0.2,
                                          width: _width,
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  controller.picture.value = "";
                                                  controller.picture.value =
                                                      await Utils
                                                          .pickImageFromCamera();
                                                  print(
                                                      "${controller.picture.value}");
                                                },
                                                child: Container(
                                                  height: 120,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          color: AppCustomColors
                                                              .primaryColor)),
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: AppCustomColors
                                                        .primaryColor,
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  controller.picture.value = "";
                                                  controller.picture.value =
                                                      await Utils
                                                          .pickImageFromGallery();
                                                  print(
                                                      "${controller.picture.value}");
                                                },
                                                child: Container(
                                                  height: 120,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          color: AppCustomColors
                                                              .primaryColor)),
                                                  child: Icon(
                                                    Icons.photo,
                                                    color: AppCustomColors
                                                        .primaryColor,
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: _height / 26,
                                      width: _height / 26,
                                      decoration: BoxDecoration(
                                        color: AppCustomColors.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: _height / 20,
                          ),
                        ],
                      ),
                    ),
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: _height / 3.5),
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Form(
                            key: _formKey,
                            child: Obx(() => controller.user.value.firstName !=
                                    null
                                ? Container(
                                    margin: EdgeInsets.all(8),
                                    child: Stack(
                                      children: [
                                        Card(
                                          elevation: 3,
                                          child: Container(
                                            width: _width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 30),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                customTextWidget(
                                                    "First Name",
                                                    18,
                                                    FontWeight.w400,
                                                    AppCustomColors
                                                        .greyTextColor),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Obx(() => TextFormField(
                                                      initialValue: controller
                                                          .user.value.firstName,
                                                      onSaved: (value) {
                                                        controller.firstName
                                                            .value = value!;
                                                      },
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                customTextWidget(
                                                    "Last Name",
                                                    18,
                                                    FontWeight.w400,
                                                    AppCustomColors
                                                        .greyTextColor),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Obx(() => TextFormField(
                                                      initialValue: controller
                                                          .user.value.lastName!,
                                                      onSaved: (value) {
                                                        controller.lastName
                                                            .value = value!;
                                                      },
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    DatePicker.showDatePicker(
                                                        context,
                                                        showTitleActions: true,
                                                        minTime: DateTime(
                                                            1900, 1, 1),
                                                        maxTime: DateTime.now(),
                                                        theme: DatePickerTheme(
                                                          backgroundColor:
                                                              AppCustomColors
                                                                  .primaryColor,
                                                          itemStyle: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          cancelStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          doneStyle: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        onChanged: (date) {},
                                                        onConfirm: (date) {
                                                      controller.dateOfBirth
                                                              .value =
                                                          date.toString();
                                                    },
                                                        currentTime:
                                                            DateTime.now(),
                                                        locale: LocaleType.en);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Obx(() {
                                                        return customTextWidget(
                                                            controller
                                                                    .dateOfBirth
                                                                    .value
                                                                    .isEmpty
                                                                ? "Birth Date : Select"
                                                                : "Birth Date : ${Utils.formteDate(DateTime.parse(controller.dateOfBirth.value))}",
                                                            18,
                                                            FontWeight.w400,
                                                            AppCustomColors
                                                                .greyTextColor);
                                                      }),
                                                      Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 30,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                customTextWidget(
                                                    "Email",
                                                    18,
                                                    FontWeight.w400,
                                                    AppCustomColors
                                                        .greyTextColor),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Obx(() => TextFormField(
                                                      initialValue: controller
                                                          .user.value.email!,
                                                      onSaved: (value) {
                                                        controller.email.value =
                                                            value!;
                                                      },
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                customTextWidget(
                                                    "Phone",
                                                    18,
                                                    FontWeight.w400,
                                                    AppCustomColors
                                                        .greyTextColor),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Obx(() {
                                                  return InternationalPhoneNumberInput(
                                                    inputBorder:
                                                        InputBorder.none,
                                                    spaceBetweenSelectorAndTextField:
                                                        2,
                                                    onInputChanged: (value) {
                                                      controller.initialDialCode
                                                              .value =
                                                          value.dialCode!;
                                                      controller.initialIsoCode
                                                              .value =
                                                          value.isoCode!;
                                                    },
                                                    initialValue: PhoneNumber(
                                                        dialCode: controller
                                                            .initialDialCode
                                                            .value,
                                                        isoCode: controller
                                                            .initialIsoCode
                                                            .value),
                                                    validator: (value) {},
                                                    onSaved: (value) =>
                                                        controller.phone.value =
                                                            value.phoneNumber!,
                                                  );
                                                }),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4)),
                                                              content:
                                                                  Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child: Container(
                                                                          decoration: BoxDecoration(border: Border.all(color: AppCustomColors.primaryColor, width: 2), borderRadius: BorderRadius.circular(4)),
                                                                          child: Obx(() {
                                                                            return Container(
                                                                              height: _height * 0.6,
                                                                              child: Container(
                                                                                height: _height * 0.5,
                                                                                child: ListView.builder(
                                                                                    shrinkWrap: true,
                                                                                    itemCount: controller.countries.length,
                                                                                    itemBuilder: (context, index) {
                                                                                      var item = controller.countries[index];
                                                                                      return InkWell(
                                                                                        onTap: () {
                                                                                          controller.selectedCountry.value = item;
                                                                                          controller.getAllState();
                                                                                          Get.back();
                                                                                        },
                                                                                        child: Card(
                                                                                            child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Text(
                                                                                            "${item.displayName}",
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'Poppins',
                                                                                              decoration: TextDecoration.none,
                                                                                              fontSize: 16,
                                                                                              color: AppCustomColors.greyTextColor,
                                                                                              fontWeight: FontWeight.w400,
                                                                                            ),
                                                                                          ),
                                                                                        )),
                                                                                      );
                                                                                    }),
                                                                              ),
                                                                            );
                                                                          })),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ));
                                                        });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Obx(() {
                                                        return customTextWidget(
                                                            controller
                                                                        .selectedCountry
                                                                        .value
                                                                        .displayName ==
                                                                    null
                                                                ? "Country : Select"
                                                                : "Country : ${controller.selectedCountry.value.displayName}",
                                                            18,
                                                            FontWeight.w400,
                                                            AppCustomColors
                                                                .greyTextColor);
                                                      }),
                                                      Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 30,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (controller
                                                            .selectedCountry
                                                            .value
                                                            .id !=
                                                        null) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
                                                                content:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        child: Container(
                                                                            decoration: BoxDecoration(border: Border.all(color: AppCustomColors.primaryColor, width: 2), borderRadius: BorderRadius.circular(4)),
                                                                            child: Obx(() {
                                                                              return Container(
                                                                                height: _height * 0.6,
                                                                                child: Container(
                                                                                  height: _height * 0.5,
                                                                                  child: ListView.builder(
                                                                                      shrinkWrap: true,
                                                                                      itemCount: controller.states.length,
                                                                                      itemBuilder: (context, index) {
                                                                                        var item = controller.states[index];
                                                                                        return InkWell(
                                                                                          onTap: () {
                                                                                            controller.selectedState.value = item;
                                                                                            Get.back();
                                                                                          },
                                                                                          child: Card(
                                                                                              child: Padding(
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: Text(
                                                                                              "${item.displayName}",
                                                                                              style: TextStyle(
                                                                                                fontFamily: 'Poppins',
                                                                                                decoration: TextDecoration.none,
                                                                                                fontSize: 16,
                                                                                                color: AppCustomColors.greyTextColor,
                                                                                                fontWeight: FontWeight.w400,
                                                                                              ),
                                                                                            ),
                                                                                          )),
                                                                                        );
                                                                                      }),
                                                                                ),
                                                                              );
                                                                            })),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ));
                                                          });
                                                    } else {
                                                      Utils.showSnackBar(
                                                          context,
                                                          "Please Select Country First");
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Obx(() {
                                                        return customTextWidget(
                                                            controller
                                                                        .selectedState
                                                                        .value
                                                                        .displayName ==
                                                                    null
                                                                ? "State : Select"
                                                                : "State : ${controller.selectedState.value.displayName}",
                                                            18,
                                                            FontWeight.w400,
                                                            AppCustomColors
                                                                .greyTextColor);
                                                      }),
                                                      Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 30,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                customTextWidget(
                                                    "City",
                                                    18,
                                                    FontWeight.w400,
                                                    AppCustomColors
                                                        .greyTextColor),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Obx(() => TextFormField(
                                                      initialValue: controller
                                                              .user
                                                              .value
                                                              .city ??
                                                          "",
                                                      onSaved: (value) {
                                                        controller.city.value =
                                                            value!;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  'Enter City'),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                customTextWidget(
                                                    "Zip Code",
                                                    18,
                                                    FontWeight.w400,
                                                    AppCustomColors
                                                        .greyTextColor),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Obx(() => TextFormField(
                                                      initialValue: controller
                                                              .user
                                                              .value
                                                              .zipCode ??
                                                          "",
                                                      onSaved: (value) {
                                                        controller.zipCode
                                                            .value = value!;
                                                      },
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              'Enter Zip Code'),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                customTextWidget(
                                                    "Address",
                                                    18,
                                                    FontWeight.w400,
                                                    AppCustomColors
                                                        .greyTextColor),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Obx(() => TextFormField(
                                                      initialValue: controller
                                                              .user
                                                              .value
                                                              .address ??
                                                          "",
                                                      onSaved: (value) {
                                                        controller.address
                                                            .value = value!;
                                                      },
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              'Enter Address'),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                KButton(
                                                  buttonText: "Update",
                                                  onPressed: () {
                                                    _formKey.currentState!
                                                        .save();
                                                    MyDialog.loadingDialog(
                                                        context,
                                                        "Updating User Information");
                                                    controller.editUserInfo();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Center(child: HeadingValueLoading())),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
