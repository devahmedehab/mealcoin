import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_app_bar.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_country_response.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/myaddress/controller/address_controller.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/profileDetails/controller/update_frofile_controller.dart';

import 'my_address_profile.dart';

class AddNewAdressPage extends StatefulWidget {
  const AddNewAdressPage({Key? key}) : super(key: key);

  @override
  _AddNewAdressPageState createState() => _AddNewAdressPageState();
}

class _AddNewAdressPageState extends State<AddNewAdressPage> {
  final controller = Get.put(AddressController());

  final _formKey = GlobalKey<FormState>();

  bool _groupValue = false;

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: KAppBar(
        customTitle: Row(
          children: [
            SizedBox(width: _width / 17),
            Spacer(),
            Transform.translate(
                offset: Offset(-15, 0),
                child: Text(controller.editMode == false
                    ? 'Add new Address'
                    : "Update Address")),
            Spacer(),
            controller.editMode == true
                ? IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "DELETE Address",
                        content: Text("Do you want to delete this Address?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () async {
                                Get.back();
                                MyDialog.loadingDialog(
                                    context, "Deleting Address");
                                final result = await controller
                                    .deleteAddress(controller.id.value);
                                MyDialog.closeDialog(context);
                                if ((result)) {
                                  Get.to(() => ProDetailsScreen());
                                  Utils.showSnackBar(
                                      context, "Delete SuccessFul");
                                } else {
                                  Utils.showSnackBar(
                                      context, "Unable to Delete");
                                }
                              },
                              child: Text("Delete")),
                        ],
                      );
                    },
                  )
                : Container(),
          ],
        ),
      ),
      body: Obx(
        () => Container(
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
                      controller.title.value = value;
                    }
                  },
                  initialValue: controller.title.value,
                  decoration: InputDecoration(
                    labelText: "title",
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
                      controller.title.value = value;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: controller.fullAddress.value,
                  validator: (value) {
                    if (value != null) {
                      controller.fullAddress.value = value;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "address",
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
                      controller.fullAddress.value = value;
                    }
                    //_signUpController.confirmPassword.value = value!;
                  },
                ),
                TextFormField(
                  initialValue: controller.city.value,
                  validator: (value) {
                    if (value != null) {
                      controller.city.value = value;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "city",
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
                      controller.city.value = value;
                    }
                    //_signUpController.confirmPassword.value = value!;
                  },
                ),
                TextFormField(
                  initialValue: controller.zipCode.value,
                  validator: (value) {
                    if (value != null) {
                      controller.zipCode.value = value;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "zip code",
                    fillColor: Colors.white,

                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppCustomColors.greyTextColor,
                        fontFamily: 'Poppins'),
                    // errorText: _validationTextPassword,
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    if (value != null) {
                      controller.zipCode.value = value;
                    }
                    //_signUpController.confirmPassword.value = value!;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownButton(
                  hint: controller.dropDownValue.isEmpty
                      ? Text(
                          'Select Country',
                          style: TextStyle(fontSize: 17),
                        )
                      : Text(
                          controller.dropDownValue.value,
                          style: TextStyle(fontSize: 17),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.blue),
                  items: controller.countries.map(
                    (CountryResult country) {
                      return DropdownMenuItem<CountryResult>(
                        value: country,
                        child: Text(country.displayName!),
                      );
                    },
                  ).toList(),
                  onChanged: (CountryResult? country) {
                    setState(() async {
                      controller.selectedCountry.value = country!;
                      controller.countryId.value = country.id!;
                      controller.dropDownValue.value = country.displayName!;
                      MyDialog.loadingDialog(context, "Loading State");
                      await controller.getAllState();
                      MyDialog.closeDialog(context);
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownButton(
                  hint: controller.stateValue.isEmpty
                      ? Text(
                          'Select State',
                          style: TextStyle(fontSize: 17),
                        )
                      : Text(
                          controller.stateValue.value,
                          style: TextStyle(fontSize: 17),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.blue),
                  items: controller.states.map(
                    (CountryResult country) {
                      return DropdownMenuItem<CountryResult>(
                        value: country,
                        child: Text(country.displayName!),
                      );
                    },
                  ).toList(),
                  onChanged: (CountryResult? country) {
                    setState(() {
                      controller.stateValue.value = country!.displayName!;
                      controller.stateId.value = country.id!;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: controller.noteForDelivery.value,
                  minLines: 2,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value != null) {
                      controller.noteForDelivery.value = value;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "note for  delivery",
                    fillColor: Colors.white,

                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppCustomColors.greyTextColor,
                        fontFamily: 'Poppins'),
                    // errorText: _validationTextPassword,
                  ),
                  onSaved: (value) {
                    if (value != null) {
                      controller.noteForDelivery.value = value;
                    }
                    //_signUpController.confirmPassword.value = value!;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Text('Is Active', style: TextStyle(fontSize: 18)),
                    Expanded(
                      flex: 1,
                      child: Obx(() {
                        return RadioListTile(
                          value: true,
                          groupValue: controller.isActive.value,
                          title: Text("Yes"),
                          onChanged: (bool? newValue) {
                            setState(() {
                              controller.isActive.value = newValue!;
                              _groupValue = newValue;
                            });
                          },
                          activeColor: Colors.red,
                          selected: false,
                        );
                      }),
                    ),
                    Expanded(
                      flex: 1,
                      child: Obx(() {
                        return RadioListTile(
                          value: false,
                          groupValue: controller.isActive.value,
                          title: Text("No"),
                          onChanged: (bool? newValue) {
                            setState(() {
                              controller.isActive.value = newValue!;
                              _groupValue = newValue;
                            });
                          },
                          activeColor: Colors.red,
                          selected: false,
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                controller.editMode == false
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppCustomColors.primaryColor),
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () async {
                          MyDialog.loadingDialog(context, "Adding Address");
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final response =
                                await controller.createNewAddress();
                            MyDialog.closeDialog(context);
                            if ((response)) {
                              Get.back();
                              Utils.showSnackBar(context, "Added Successful");
                            } else {
                              Utils.showSnackBar(context, "Added to fail");
                            }
                          }
                        },
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppCustomColors.primaryColor),
                        child: Text(
                          'Update',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () async {
                          MyDialog.loadingDialog(context, "Updating Address");
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final response =
                                await controller.createNewAddress();
                            MyDialog.closeDialog(context);
                            if ((response)) {
                              Get.back();
                              Utils.showSnackBar(context, "Update Successful");
                            } else {
                              Utils.showSnackBar(context, "update fail");

                              /* Utils.showSnackBar(
                            context, "${response.error!.message}");*/
                            }
                          }
                        },
                      )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
