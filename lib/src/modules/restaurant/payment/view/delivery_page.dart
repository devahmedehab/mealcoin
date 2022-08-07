import 'package:flutter/material.dart';

import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/myaddress/view/add_new_address.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/controller/cartController.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  DeliveryDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
            padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 19)),
             child: Text('Select Delivery or Pickup',
               style: KTextStyle.headline7.copyWith(color: KColor.black, height: 1)),
        ),
           SizedBox(height: KSize.getHeight(context, 25)),
           Padding(
          padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return cartController.deliveryTypeList.isEmpty
                ? CircularProgressIndicator()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartController.deliveryTypeList.length,
                    itemBuilder: (context, index) {
                      var item = cartController.deliveryTypeList[index];
                      return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: KSize.getWidth(context, 19)),
                          child: GestureDetector(
                              onTap: () {
                                cartController.deliveryTypeId.value = item.id!;
                                cartController.selectedDeliveryType.value =
                                    index;
                              },
                              child: Row(
                                children: [
                                  Obx(() {
                                    return Radio<int>(
                                        value: index,
                                        groupValue: cartController
                                            .selectedDeliveryType.value,
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                          (states) => cartController
                                                      .selectedDeliveryType
                                                      .value ==
                                                  index
                                              ? KColor.primary
                                              : KColor.gray2,
                                        ),
                                        activeColor: cartController
                                                    .selectedDeliveryType
                                                    .value ==
                                                index
                                            ? KColor.primary
                                            : KColor.gray2,
                                        onChanged: (val) {
                                          //setSelectedDeliveryOrPickup(val!);
                                          cartController.selectedDeliveryType
                                              .value = val!;
                                        });
                                  }),
                                  Text(
                                    '${item.displayName}',
                                    style: KTextStyle.headline8.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: cartController
                                                .selectedDeliveryType
                                                .value ==
                                            index
                                        ? KColor.primary
                                        : KColor.gray2),
                                  ),
                                ],
                              )));
                    });
          }),
        ),
        /*selectedDeliveryOrPickup == 1 ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                           children: [
                             Padding(
                               padding:
                               EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 19)),
                               child: GestureDetector(
                                 onTap: () {
                                   setSelectedDelivery(1);
                                 },
                                 child: Row(
                                   children: [
                                     Radio<int>(
                                         value: 1,
                                         groupValue: selectedDelivery,
                                         fillColor: MaterialStateColor.resolveWith(
                                               (states) =>
                                               selectedDelivery == 1 ? KColor.primary : KColor.gray2,
                                         ),
                                         activeColor:
                                         selectedDelivery == 1 ? KColor.primary : KColor.gray2,
                                         onChanged: (val) {
                                           setSelectedDelivery(val!);
                                         }),
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           'Schedule Delivery',
                                           style: KTextStyle.headline8.copyWith(
                                               fontWeight: FontWeight.w500,
                                               color:
                                               selectedDelivery == 1 ? KColor.primary : KColor
                                                   .gray2),
                                         ),
                                         Text(
                                             '(We serve from 10 am to 10 pm EST)',
                                             style: TextStyle(color: KColor.gray2)),
                                       ],
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             selectedDelivery == 1 ? Padding(
                               padding: const EdgeInsets.symmetric(vertical: 5.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(left: 35.0),
                                     child: InkWell(
                                       onTap: (){
                                         DatePicker.showDatePicker(
                                             context,
                                             showTitleActions: true,
                                             minTime: DateTime(1900, 1, 1),
                                             maxTime: DateTime.now(),
                                             theme: DatePickerTheme(
                                               backgroundColor: AppCustomColors.primaryColor,
                                               itemStyle: TextStyle(color: Colors.white),
                                               cancelStyle: TextStyle(color: Colors.white),
                                               doneStyle: TextStyle(color: Colors.white),
                                             ),
                                             onChanged: (date) {
                                             }, onConfirm: (date) {
                                           //controller.dateOfBirth.value = date.toString();
                                         },
                                             currentTime: DateTime.now(),
                                             locale: LocaleType.en);

                                       },
                                       child: Container(
                                           width: size.width * 0.38,
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Icon(Icons.date_range,color: AppCustomColors.primaryColor,),
                                               SizedBox(width: 5,),
                                               Text("Select Date",style: TextStyle(color: AppCustomColors.primaryColor,),),
                                             ],
                                           )
                                       ),
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(right: 35.0),
                                     child: InkWell(
                                       onTap: (){
                                         pickTime();
                                       },
                                       child: Container(
                                           width: size.width * 0.38,
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Icon(Icons.timelapse,color: AppCustomColors.primaryColor,),
                                               SizedBox(width: 5,),
                                               Text("Select Time",style: TextStyle(color: AppCustomColors.primaryColor,),),
                                             ],
                                           )),
                                     ),
                                   ),
                                 ],
                               ),
                             ) : Container(),
                             Padding(
                               padding:
                               EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 19)),
                               child: GestureDetector(
                                 onTap: () {
                                   setSelectedDelivery(2);
                                 },
                                 child: Row(
                                   children: [
                                     Radio<int>(
                                         value: 2,
                                         groupValue: selectedDelivery,
                                         fillColor: MaterialStateColor.resolveWith(
                                               (states) =>
                                           selectedDelivery == 2 ? KColor.primary : KColor.gray2,
                                         ),
                                         activeColor:
                                         selectedDelivery == 2 ? KColor.primary : KColor.gray2,
                                         onChanged: (val) {
                                           setSelectedDelivery(val!);
                                         }),
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           'Custom',
                                           style: KTextStyle.headline8.copyWith(
                                               fontWeight: FontWeight.w500,
                                               color:
                                               selectedDelivery == 2 ? KColor.primary : KColor
                                                   .gray2),
                                         ),
                                       ],
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ],
                 ),
            ) : Container(),*/

        // Padding(
        //     padding:
        //     EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 19)),
        //     child: GestureDetector(
        //         onTap: () {
        //           //setSelectedDeliveryOrPickup(2);
        //           cartController.selectedDeliveryType.value = 2;
        //         },
        //         child: Row(
        //           children: [
        //             Obx(() {
        //               return Radio<int>(
        //                   value: 2,
        //                   groupValue: cartController.selectedDeliveryType
        //                       .value,
        //                   fillColor: MaterialStateColor.resolveWith(
        //                         (states) =>
        //                     cartController.selectedDeliveryType.value == 2
        //                         ? KColor.primary
        //                         : KColor.gray2,
        //                   ),
        //                   activeColor: cartController.selectedDeliveryType
        //                       .value == 2
        //                       ? KColor.primary
        //                       : KColor.gray2,
        //                   onChanged: (val) {
        //                     cartController.selectedDeliveryType.value =
        //                     val!;
        //                   });
        //             }),
        //             Flexible(
        //               child: Obx(() {
        //                 return Text(
        //                   'Pickup',
        //                   style: KTextStyle.headline8.copyWith(
        //                       fontWeight: FontWeight.w500,
        //                       color: cartController.selectedDeliveryType
        //                           .value == 2
        //                           ? KColor.primary
        //                           : KColor.gray2),
        //                 );
        //               }),
        //             ),
        //           ],
        //         ))
        // ),
        /* selectedDeliveryOrPickup == 2? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  width: size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Select Pickup Point"),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                ),
              ),
            ) : Container()*/

        SizedBox(height: KSize.getHeight(context, 25)),

        Padding(
      padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 19)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Select your address',
              style: KTextStyle.headline7
                  .copyWith(color: KColor.black, height: 1)),
          TextButton(
            onPressed: () {
              Get.to(() => AddNewAdressPage());
            },
            child: Text('+ New Address',
                style: TextStyle(color: Colors.blue, fontSize: 16)),
          ),
        ],
      ),
        ),

        ///delivery address
        Obx(
      () => cartController.addressList.isNotEmpty
          ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cartController.addressList.length,
              itemBuilder: (context, index) {
                var item = cartController.addressList[index].contactAddress!;
                return InkWell(
                  onTap: () {
                    cartController.selectedAddress.value = item.id!;
                    cartController.zipCode.value = item.zipCode!;
                    cartController.stateId.value = item.stateId!;
                    cartController.customerName.value =
                        cartController.addressList[index].contactName!;
                    cartController.deliveryAddress.value = item.fullAddress! +
                        item.city! +
                        cartController.addressList[index].stateName! +
                        cartController.addressList[index].countryName!;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 6),
                    child: Obx(() {
                      return Container(
                        decoration: BoxDecoration(
                            color: KColor.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: cartController.selectedAddress.value ==
                                        item.id!
                                    ? AppCustomColors.primaryColor
                                    : Colors.grey,
                                width: 2)
                            ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: [
                                Divider(),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.title,
                                      color: Colors.deepOrange,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      item.title!,
                                      style: KTextStyle.bodyText3,
                                    ),
                                    const Spacer(),
                                    Obx(
                                      () => cartController
                                                  .selectedAddress.value ==
                                              item.id!
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                ),
                                                child: const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: KSize.getHeight(context, 10),
                                ),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),

                                    const Icon(
                                      Icons.person,
                                      color: Colors.deepOrange,
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      cartController
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
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.deepOrange,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: size.width - 70,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "${item.fullAddress!}, ${item.city!}, ${cartController.addressList[index].stateName!}, ${cartController.addressList[index].countryName!},",
                                          style: KTextStyle.bodyText2
                                              .copyWith(height: 1.5),
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
                                      Icons.message_outlined,
                                      color: Colors.deepOrange,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),

                                    Text(
                                      "${cartController.addressList[index].contactAddress!.noteForDelivery!}",
                                      style: KTextStyle.bodyText2
                                          .copyWith(height: 1.5),
                                    ),

                                    //Spacer()
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
        )
      ]),
    );
  }

  pickTime() {
    return Get.defaultDialog(
        title: "Select Time",
        titleStyle: TextStyle(color: Colors.white),
        content: TimePickerSpinner(
          is24HourMode: false,
          normalTextStyle: TextStyle(fontSize: 24, color: Colors.black),
          highlightedTextStyle: TextStyle(fontSize: 24, color: Colors.white),
          spacing: 50,
          itemHeight: 80,
          isForce2Digits: true,
          minutesInterval: 10,
          onTimeChange: (time) {
            setState(() {
              //_dateTime = time;
              print("$time");
            });
          },
        ),
        backgroundColor: AppCustomColors.primaryColor,
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              )),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Done",
                style: TextStyle(color: Colors.white),
              )),
        ]);
  }
}
