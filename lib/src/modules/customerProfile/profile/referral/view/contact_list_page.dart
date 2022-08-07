import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_sync_contact_response.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/referral/controller/referralController.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/referral/widgets/single_contract_row.dart';

class ContactListPage extends StatelessWidget {
  final controller = Get.put(ReferalController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppCustomColors.primaryColor,
          title: Text(
            'Refer & Earn',
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextButton(
                  onPressed: () async {
                    MyDialog.loadingDialog(context, "Referring All");
                    final result = await controller.referAll();
                    MyDialog.closeDialog(context);
                    if (result) {
                      Utils.showSnackBar(context, "Refer Successful");
                    } else {
                      Utils.showSnackBar(context, "Unable to Refer now");
                    }
                  },
                  child: Text(
                    "Refer All",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TabBar(
                indicatorColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: AppCustomColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                unselectedLabelColor: AppCustomColors.primaryColor,
                labelColor: Color(0xffffffff),
                tabs: [
                  Tab(
                    child: Text(
                      "Phone Contacts",
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                    //text: "Phone Contacts",
                  ),
                  Tab(
                    child: Text(
                      "My Referrers",
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                    //text: "Phone Contacts",
                  ),
                  Tab(
                    child: Text(
                      "New Contact",
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                    //text: "Phone Contacts",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // first tab bar view widget
                    Container(
                      child: Center(
                        child: Obx(
                          () => SafeArea(
                            child: controller.syncontractList.isNotEmpty
                                ? ListView.builder(
                                    itemCount:
                                        controller.syncontractList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      SnycContactResult? c =
                                          controller.syncontractList[index];

                                      return SingleContactRow(
                                          c: c, controller: controller);
                                    },
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                        ),
                      ),
                    ),

                    // second tab bar viiew widget
                    Container(
                      child: Center(
                        child: Obx(
                          () => SafeArea(
                            child: controller.syncontractList.isNotEmpty
                                ? ListView.builder(
                                    itemCount:
                                        controller.syncontractList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      SnycContactResult c =
                                          controller.syncontractList[index];
                                      return c.isReferred!
                                          ? SingleContactRow(
                                              c: c, controller: controller)
                                          : Container();
                                    },
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value != null) {
                                  controller.firstName.value = value;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "First Name",
                                fillColor: Colors.white,
                                /*border: OutlineInputBorder(
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
                                  ),*/
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppCustomColors.greyTextColor,
                                    fontFamily: 'Poppins'),
                                // errorText: _validationTextPassword,
                              ),
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                if (value != null) {
                                  controller.firstName.value = value;
                                }
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value != null) {
                                  controller.lastName.value = value;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Last Name",
                                fillColor: Colors.white,

                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppCustomColors.greyTextColor,
                                    fontFamily: 'Poppins'),
                                // errorText: _validationTextPassword,
                              ),
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                if (value != null) {
                                  controller.lastName.value = value;
                                }
                                //_signUpController.confirmPassword.value = value!;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              /*decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppCustomColors.primaryColor,
                                      width: 2),
                                  color: AppCustomColors.whiteColor,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),*/
                              child: InternationalPhoneNumberInput(
                                  spaceBetweenSelectorAndTextField: 2,
                                  onInputChanged: (value) {
                                    /* _signUpController.initialDialCode.value =
                                    value.dialCode!;
                                    _signUpController.initialIsoCode.value = value.isoCode!;*/
                                  },
                                  initialValue: PhoneNumber(
                                      dialCode:
                                          controller.initialDialCode.value,
                                      isoCode: controller.initialIsoCode.value),
                                  validator: (value) {},
                                  onSaved: (value) {
                                    if (value != null) {
                                      controller.phone.value =
                                          value.phoneNumber!;
                                    }
                                    //_signUpController.phone.value = value.phoneNumber!,
                                  }),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value != null) {
                                  controller.email.value = value;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Email",
                                fillColor: Colors.white,

                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppCustomColors.greyTextColor,
                                    fontFamily: 'Poppins'),
                                // errorText: _validationTextPassword,
                              ),
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                if (value != null) {
                                  controller.email.value = value;
                                }
                              },
                            ),
                            SizedBox(height: 30),
                            SizedBox(height: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppCustomColors.primaryColor),
                              child: Text(
                                'Submit',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () async {
                                MyDialog.loadingDialog(context, "Referring");
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  final response =
                                      await controller.addNewContract();
                                  MyDialog.closeDialog(context);
                                  if ((response.success)) {
                                    Utils.showSnackBar(
                                        context, "Referred Successful");
                                  } else {
                                    Utils.showSnackBar(
                                        context, "${response.error!.message}");
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
