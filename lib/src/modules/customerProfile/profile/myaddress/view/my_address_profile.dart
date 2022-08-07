import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fdottedline/fdottedline.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_app_bar.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/myaddress/controller/address_controller.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

import 'add_new_address.dart';

class ProDetailsScreen extends StatelessWidget {
  final controller = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    print("height: ${_height}");
    print("width: ${_width}");
    return Scaffold(
      appBar: KAppBar(
        customTitle: Row(
          children: [
            SizedBox(width: _width / 17),
            Spacer(),
            Transform.translate(
                offset: Offset(-15, 0), child: Text('My Address')),
            Spacer(),
          ],
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  controller.editMode.value = false;
                  controller.title.value = "";

                  controller.fullAddress.value = "";

                  controller.city.value = "";
                  controller.zipCode.value = "";

                  controller.noteForDelivery.value = "";

                  controller.dropDownValue.value = "";
                  controller.stateValue.value = "";

                  Get.to(() => AddNewAdressPage());
                },
                child: FDottedLine(
                  color: KColor.blue,
                  height: _height / 16,
                  width: _width / 2.06,
                  strokeWidth: 2.0,
                  space: 2.0,
                  child: Container(
                    height: _height / 16,
                    width: _width / 2.06,
                    color: KColor.blue.withOpacity(0.2),
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(
                          Icons.add,
                          color: KColor.blue,
                          size: _width / 20,
                        ),
                        Text('Add address',
                            style: KTextStyle.bodyText2.copyWith(
                                fontSize: _width / 29, color: KColor.blue)),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: controller.addressList.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.addressList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                  color: KColor.white,
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                          color: KColor.lightGray2))),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),

                                        Icon(
                                          Icons.title,
                                          color: Colors.deepOrange,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),

                                        Text(
                                          controller.addressList[index]
                                              .contactAddress!.title!,
                                          style: KTextStyle.bodyText3,
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            controller.title.value = controller
                                                .addressList[index]
                                                .contactAddress!
                                                .title!;

                                            controller.fullAddress.value =
                                                controller
                                                    .addressList[index]
                                                    .contactAddress!
                                                    .fullAddress!;

                                            controller.city.value = controller
                                                .addressList[index]
                                                .contactAddress!
                                                .city!;
                                            controller.zipCode.value =
                                                controller.addressList[index]
                                                    .contactAddress!.zipCode!;

                                            controller.noteForDelivery.value =
                                                controller
                                                    .addressList[index]
                                                    .contactAddress!
                                                    .noteForDelivery!;

                                            controller.dropDownValue.value =
                                                controller.addressList[index]
                                                    .countryName!;
                                            controller.stateValue.value =
                                                controller.addressList[index]
                                                    .stateName!;
                                            controller.id.value = controller
                                                .addressList[index]
                                                .contactAddress!
                                                .id!;

                                            controller.stateId.value =
                                                controller.addressList[index]
                                                    .contactAddress!.stateId!;

                                            controller.countryId.value =
                                                controller.addressList[index]
                                                    .contactAddress!.countryId!;

                                            controller.isActive.value =
                                                controller.addressList[index]
                                                    .contactAddress!.isActive!;

                                            Get.to(() => AddNewAdressPage());
                                            controller.editMode.value = true;
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              'Edit',
                                              style: KTextStyle.bodyText2
                                                  .copyWith(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: AppCustomColors
                                                          .primarySwatchColor),
                                            ),
                                          ),
                                        ),
                                        //Spacer()
                                      ],
                                    ),
                                    SizedBox(
                                      height: KSize.getHeight(context, 10),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),

                                        Icon(
                                          Icons.person,
                                          color: Colors.deepOrange,
                                        ),

                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          controller
                                              .addressList[index].contactName!,
                                          style: KTextStyle.bodyText2,
                                        ),

                                        //Spacer()
                                      ],
                                    ),
                                    SizedBox(
                                      height: KSize.getHeight(context, 10),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),

                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.deepOrange,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),

                                        Expanded(
                                          child: Text(
                                            "${controller.addressList[index].contactAddress!.fullAddress!}, ${controller.addressList[index].contactAddress!.city!}, ${controller.addressList[index].stateName!}, ${controller.addressList[index].countryName!},",
                                            style: KTextStyle.bodyText2
                                                .copyWith(height: 1.5),
                                          ),
                                        ),
                                        //Spacer()
                                      ],
                                    ),
                                    SizedBox(
                                      height: KSize.getHeight(context, 10),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),

                                        Icon(
                                          Icons.message_outlined,
                                          color: Colors.deepOrange,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),

                                        Text(
                                          "${controller.addressList[index].contactAddress!.noteForDelivery!}",
                                          style: KTextStyle.bodyText2
                                              .copyWith(height: 1.5),
                                        ),

                                        //Spacer()
                                      ],
                                    ),
                                    if (index == 0)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: KSize.getHeight(context, 25),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: KColor.blue)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              'Default shipping and billing address',
                                              style:
                                                  TextStyle(color: KColor.blue),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
