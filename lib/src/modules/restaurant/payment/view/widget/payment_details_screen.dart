import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_app_bar.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_textfield.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/controller/cartController.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

import '../confirmOrderScreen.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  late int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height - 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Select Payment Type',
                style: KTextStyle.headline7
                    .copyWith(color: KColor.black, height: 1)),
          ),
          SizedBox(height: KSize.getHeight(context, 25)),

          /// My wallet radio button
          SizedBox(
            height: size.height * 0.4,
            child: Obx(() {
              return ListView.builder(
                  itemCount: cartController.paymentType.length,
                  itemBuilder: (context, index) {
                    var item = cartController.paymentType[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: KSize.getWidth(context, 19)),
                      child: GestureDetector(
                        onTap: () {
                          //setSelectedRadio(2);
                          cartController.selectedPaymentType.value = item.id!;
                          cartController.checkPaymentType();
                        },
                        child: Row(
                          children: [
                            Obx(() {
                              return Radio<int>(
                                  value: item.id!,
                                  groupValue:
                                      cartController.selectedPaymentType.value,
                                  fillColor: MaterialStateColor.resolveWith(
                                    (set) => cartController
                                                .selectedPaymentType.value ==
                                            item.id!
                                        ? KColor.primary
                                        : KColor.gray2,
                                  ),
                                  activeColor: cartController
                                              .selectedPaymentType.value ==
                                          item.id!
                                      ? KColor.primary
                                      : KColor.gray2,
                                  onChanged: (val) {
                                    //setSelectedRadio(val!);
                                    cartController.selectedPaymentType.value =
                                        val!;
                                  });
                            }),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(() {
                                        return Text(
                                          '${item.displayName}',
                                          style: KTextStyle.headline8.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: cartController
                                                          .selectedPaymentType
                                                          .value ==
                                                      item.id!
                                                  ? KColor.primary
                                                  : KColor.gray2),
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
          )
          /* Padding(
            padding:
            EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 19)),
            child: GestureDetector(
              onTap: () {
                setSelectedRadio(1);
              },
              child: Row(
                children: [
                  Radio<int>(
                      value: 1,
                      groupValue: selectedRadio,
                      fillColor: MaterialStateColor.resolveWith(
                            (states) =>
                        selectedRadio == 1 ? KColor.primary : KColor.gray2,
                      ),
                      activeColor:
                      selectedRadio == 1 ? KColor.primary : KColor.gray2,
                      onChanged: (val) {
                        setSelectedRadio(val!);
                      }),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${cartController.paymentType}',
                          style: KTextStyle.headline8.copyWith(
                              fontWeight: FontWeight.w500,
                              color: selectedRadio == 1
                                  ? KColor.primary
                                  : KColor.gray2),
                        ),
                        SizedBox(height: KSize.getHeight(context, 3)),
                        Text(
                          'Be ready with enough cash when our delivery guy\nreached at your place',
                          style: KTextStyle.bodyText2.copyWith(
                              color: selectedRadio == 1
                                  ? KColor.primary
                                  : KColor.gray),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: KSize.getHeight(context, 24)),
          /// Cash On Delivery
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 19)),
            child: GestureDetector(
              onTap: () {
                setSelectedRadio(2);
              },
              child: Row(
                children: [
                  Radio<int>(
                      value: 2,
                      groupValue: selectedRadio,
                      fillColor: MaterialStateColor.resolveWith(
                            (states) =>
                        selectedRadio == 2 ? KColor.primary : KColor.gray2,
                      ),
                      activeColor:
                      selectedRadio == 2 ? KColor.primary : KColor.gray2,
                      onChanged: (val) {
                        setSelectedRadio(val!);
                      }),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cash on Delivery',
                              style: KTextStyle.headline8.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: selectedRadio == 2
                                      ? KColor.primary
                                      : KColor.gray2),
                            ),
                            Text(
                              'Recharge Wallet',
                              style: KTextStyle.bodyText2.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: KColor.primary),
                            ),
                          ],
                        ),
                        SizedBox(height: KSize.getHeight(context, 3)),
                        Text(
                          '(\$ 15)',
                          style: KTextStyle.bodyText2.copyWith(
                              color: selectedRadio == 2
                                  ? KColor.primary
                                  : KColor.gray),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),*/
          /*,SizedBox(height: KSize.getHeight(context, 38)),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 19)),
            child: GestureDetector(
              onTap: () {
                setSelectedRadio(3);
              },
              child: Row(
                children: [
                  Radio<int>(
                      value: 3,
                      groupValue: selectedRadio,
                      fillColor: MaterialStateColor.resolveWith(
                            (states) =>
                        selectedRadio == 3 ? KColor.primary : KColor.gray2,
                      ),
                      activeColor:
                      selectedRadio == 3 ? KColor.primary : KColor.gray2,
                      onChanged: (val) {
                        setSelectedRadio(val!);
                      }),
                  Text(
                    'Credit Card',
                    style: KTextStyle.headline8.copyWith(
                        fontWeight: FontWeight.w500,
                        color:
                        selectedRadio == 3 ? KColor.primary : KColor.gray2),
                  ),
                ],
              ),
            ),
          ),*/
          ,
          SizedBox(height: KSize.getHeight(context, 41)),
        ],
      ),
    );
    /*return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: KSize.getHeight(context, 17)),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 19)),
            child: Text('Select Delivery or Time',
                style: KTextStyle.headline7
                    .copyWith(color: KColor.black, height: 1)),
          ),
          SizedBox(height: KSize.getHeight(context, 25)),

          /// Cash On Delivery
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 19)),
            child: GestureDetector(
              onTap: () {
                setSelectedRadio(1);
              },
              child: Row(
                children: [
                  Radio<int>(
                      value: 1,
                      groupValue: selectedRadio,
                      fillColor: MaterialStateColor.resolveWith(
                        (states) =>
                            selectedRadio == 1 ? KColor.primary : KColor.gray2,
                      ),
                      activeColor:
                          selectedRadio == 1 ? KColor.primary : KColor.gray2,
                      onChanged: (val) {
                        setSelectedRadio(val!);
                      }),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Wallet',
                          style: KTextStyle.headline8.copyWith(
                              fontWeight: FontWeight.w500,
                              color: selectedRadio == 1
                                  ? KColor.primary
                                  : KColor.gray2),
                        ),
                        SizedBox(height: KSize.getHeight(context, 3)),
                        Text(
                          'Be ready with enough cash when our delivery guy\nreached at your place',
                          style: KTextStyle.bodyText2.copyWith(
                              color: selectedRadio == 1
                                  ? KColor.primary
                                  : KColor.gray),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: KSize.getHeight(context, 24)),

          /// My wallet radio button
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 19)),
            child: GestureDetector(
              onTap: () {
                setSelectedRadio(2);
              },
              child: Row(
                children: [
                  Radio<int>(
                      value: 2,
                      groupValue: selectedRadio,
                      fillColor: MaterialStateColor.resolveWith(
                        (states) =>
                            selectedRadio == 2 ? KColor.primary : KColor.gray2,
                      ),
                      activeColor:
                          selectedRadio == 2 ? KColor.primary : KColor.gray2,
                      onChanged: (val) {
                        setSelectedRadio(val!);
                      }),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cash on Delivery',
                              style: KTextStyle.headline8.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: selectedRadio == 2
                                      ? KColor.primary
                                      : KColor.gray2),
                            ),
                            Text(
                              'Recharge Wallet',
                              style: KTextStyle.bodyText2.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: KColor.primary),
                            ),
                          ],
                        ),
                        SizedBox(height: KSize.getHeight(context, 3)),
                        Text(
                          '(\$ 15)',
                          style: KTextStyle.bodyText2.copyWith(
                              color: selectedRadio == 2
                                  ? KColor.primary
                                  : KColor.gray),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: KSize.getHeight(context, 38)),

          /// Credit card radio button
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 19)),
            child: GestureDetector(
              onTap: () {
                setSelectedRadio(3);
              },
              child: Row(
                children: [
                  Radio<int>(
                      value: 3,
                      groupValue: selectedRadio,
                      fillColor: MaterialStateColor.resolveWith(
                        (states) =>
                            selectedRadio == 3 ? KColor.primary : KColor.gray2,
                      ),
                      activeColor:
                          selectedRadio == 3 ? KColor.primary : KColor.gray2,
                      onChanged: (val) {
                        setSelectedRadio(val!);
                      }),
                  Text(
                    'Credit Card',
                    style: KTextStyle.headline8.copyWith(
                        fontWeight: FontWeight.w500,
                        color:
                            selectedRadio == 3 ? KColor.primary : KColor.gray2),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: KSize.getHeight(context, 41)),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 24)),
            child: KTextField(
              hintText: 'Name on Card',
            ),
          ),
          SizedBox(height: KSize.getHeight(context, 25)),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 24)),
            child: KTextField(
              hintText: 'Card Number',
            ),
          ),
          SizedBox(height: KSize.getHeight(context, 43)),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 24)),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: KSize.getHeight(context, 50),
                    color: KColor.white,
                    child: TextField(
                      decoration:
                          InputDecoration(hintText: 'Expiry Date (DD/MM)'),
                    ),
                  ),
                ),
                SizedBox(width: KSize.getWidth(context, 24)),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: KSize.getHeight(context, 50),
                    color: KColor.white,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'CVV Number'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            height: KSize.getHeight(context, 75),
            width: double.infinity,
            color: KColor.primary,
            alignment: Alignment.center,
            child: Row(
              children: [
                Spacer(),
                Transform.translate(
                  offset: Offset(15, 0),
                  child: Text(
                    'CONFIRM ORDER',
                    style: KTextStyle.headline8.copyWith(
                        color: KColor.white, fontWeight: FontWeight.w500),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: KColor.white),
                  onPressed: () {
                    // context.nextPage(ConfirmOrderScreen());
                    Utils.navigateToPage(
                        context, ConfirmOrderScreen(), 200, false);
                  },
                ),
                SizedBox(
                  width: KSize.getWidth(context, 17),
                )
              ],
            ),
          )
        ],
      );*/
  }
}
