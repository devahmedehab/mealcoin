import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/controller/cartController.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class ConfirmOrderScreen extends StatefulWidget {
  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var f = new NumberFormat("###.##", "en_US");

    /* var saleTax = f.format((cartController.cart.value.subTotal! *
        cartController.taxRate.value.combinedRate! *
        100) / 100);
    cartController.saleTax.value = double.parse(saleTax);

    var deliveryCharge = cartController.storeSetting.value.storeSetting!.deliveryCharge;
    cartController.deliveryCharge.value = double.parse(deliveryCharge);

    var total = f.format(cartController.cart.value.subTotal! + (cartController.cart.value.subTotal! *
        cartController.taxRate.value.combinedRate! *
        100) / 100 + cartController.storeSetting.value.storeSetting!.deliveryCharge);
    cartController.deliveryCharge.value = double.parse(total);*/

    cartController.calculateSaleTax();
    cartController.calculateDeliveryCharge();
    cartController.getTotalAmount();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //physics: NeverScrollableScrollPhysics(),
        children: [
          Image.asset(
            'assets/images/Rectangle.png',
            height: KSize.getHeight(context, 18),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            color: KColor.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: KSize.getWidth(context, 30),
                  vertical: KSize.getHeight(context, 24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chefs & Meals',
                    style: KTextStyle.headline7,
                  ),
                  SizedBox(height: KSize.getHeight(context, 24)),
                  Text(
                    'Order Details',
                    style:
                        KTextStyle.headline7.copyWith(color: KColor.blackShade),
                  ),
                  SizedBox(height: KSize.getHeight(context, 11.5)),
                  Divider(
                    thickness: 2,
                  ),
                  Obx(() {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cartController.fastCheckout.value
                            ? cartController.fastCheckOutList.length
                            : cartController.cartList.length,
                        itemBuilder: (context, index) {
                          var item = cartController.fastCheckout.value
                              ? cartController.fastCheckOutList[index]
                              : cartController.cartList[index];
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.7,
                                      child: Text(
                                        "${item.productName}",
                                        style: KTextStyle.headline7.copyWith(
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.ellipsis,
                                            color: KColor.black),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${item.quantity}",
                                          style: KTextStyle.headline7.copyWith(
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          " X ",
                                          style: KTextStyle.headline7.copyWith(
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "${item.unitPrice} ",
                                          style: KTextStyle.headline7.copyWith(
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "${item.unitTotalAmount}",
                                  style: KTextStyle.headline7.copyWith(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                      color: KColor.black),
                                ),
                              ],
                            ),
                          );
                        });
                  }),

                  /// Sub total
                  SizedBox(height: KSize.getHeight(context, 11.5)),
                  Padding(
                    padding: EdgeInsets.only(left: KSize.getWidth(context, 0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Total',
                          style: KTextStyle.headline7
                              .copyWith(color: KColor.blackShade),
                        ),
                        Text(
                          '\$ ${cartController.cart.value.subTotal}',
                          style: KTextStyle.headline7
                              .copyWith(color: KColor.blackShade),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: KSize.getHeight(context, 14)),
                  Obx(() => cartController.taxRate.value.combinedRate != null
                      ? Padding(
                          padding:
                              EdgeInsets.only(left: KSize.getWidth(context, 0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sales Tax (${cartController.taxRate.value.combinedRate! * 100} %)',
                                style: KTextStyle.headline8.copyWith(
                                    color: KColor.darkGray2,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '\$ ${f.format(cartController.saleTax.value)}',
                                style: KTextStyle.headline8.copyWith(
                                    color: KColor.darkGray2,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        )
                      : Container()),
                  SizedBox(height: KSize.getHeight(context, 15)),

                  /// Delivery Charge
                  Obx(() => cartController.storeSetting.value.storeSetting!
                              .deliveryCharge !=
                          null
                      ? Padding(
                          padding:
                              EdgeInsets.only(left: KSize.getWidth(context, 0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery Charge',
                                style: KTextStyle.headline8.copyWith(
                                    color: KColor.darkGray2,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '\$ ${f.format(cartController.deliveryCharge.value)}',
                                style: KTextStyle.headline8.copyWith(
                                    color: KColor.darkGray2,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        )
                      : Container()),
                  SizedBox(height: KSize.getHeight(context, 25)),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(height: KSize.getHeight(context, 18.5)),

                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: [
                          Text(
                            "Tips are welcome",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(height: KSize.getHeight(context, 18.5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  cartController.gratuityPercent.value = 10;
                                  cartController.gratuityAmount.value =
                                      double.parse(f.format(
                                          (cartController.cart.value.subTotal! /
                                                  100) *
                                              10));
                                  cartController.getTotalAmount();
                                },
                                child: Obx(() {
                                  return Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: cartController
                                                    .gratuityPercent.value ==
                                                10
                                            ? AppCustomColors.primaryColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.lightBlue,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Obx(() {
                                            return Text(
                                              "10%",
                                              style: TextStyle(
                                                  color: cartController
                                                              .gratuityPercent
                                                              .value ==
                                                          10
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            );
                                          }),
                                          Obx(() {
                                            return Text(
                                              "\$ ${f.format((cartController.cart.value.subTotal! / 100) * 10)}",
                                              style: TextStyle(
                                                  color: cartController
                                                              .gratuityPercent
                                                              .value ==
                                                          10
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            );
                                          }),
                                        ],
                                      ));
                                }),
                              ),
                              SizedBox(width: 18.5),
                              InkWell(
                                onTap: () {
                                  cartController.gratuityPercent.value = 15;
                                  cartController.gratuityAmount.value =
                                      double.parse(f.format(
                                          (cartController.cart.value.subTotal! /
                                                  100) *
                                              15));
                                  cartController.getTotalAmount();
                                },
                                child: Obx(() {
                                  return Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: cartController
                                                    .gratuityPercent.value ==
                                                15
                                            ? AppCustomColors.primaryColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.lightBlue,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "15%",
                                            style: TextStyle(
                                                color: cartController
                                                            .gratuityPercent
                                                            .value ==
                                                        15
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "\$ ${f.format((cartController.cart.value.subTotal! / 100) * 15)}",
                                            style: TextStyle(
                                                color: cartController
                                                            .gratuityPercent
                                                            .value ==
                                                        15
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ));
                                }),
                              ),
                              SizedBox(width: 18.5),
                              InkWell(
                                onTap: () {
                                  cartController.gratuityPercent.value = 25;
                                  cartController.gratuityAmount.value =
                                      double.parse(f.format(
                                          (cartController.cart.value.subTotal! /
                                                  100) *
                                              25));
                                  cartController.getTotalAmount();
                                },
                                child: Obx(() {
                                  return Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: cartController
                                                    .gratuityPercent.value ==
                                                25
                                            ? AppCustomColors.primaryColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.lightBlue,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "25%",
                                            style: TextStyle(
                                                color: cartController
                                                            .gratuityPercent
                                                            .value ==
                                                        25
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "\$ ${f.format((cartController.cart.value.subTotal! / 100) * 25)}",
                                            style: TextStyle(
                                                color: cartController
                                                            .gratuityPercent
                                                            .value ==
                                                        25
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ));
                                }),
                              ),
                              //SizedBox(width: 18.5),
                            ],
                          ),
                          SizedBox(height: 10.5),
                          Text(
                            "OR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 10.5),
                          Container(
                            width: size.width,
                            child: TextFormField(
                              validator: (value) {
                                if (value != null) {}
                              },
                              onChanged: (value) {
                                cartController.gratuityAmount.value =
                                    double.parse(value);
                                cartController.getTotalAmount();
                              },
                              decoration: InputDecoration(
                                prefixText: "\$",
                                labelText: "Amount",
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppCustomColors.greyTextColor,
                                    fontFamily: 'Poppins'),
                                // errorText: _validationTextPassword,
                              ),
                              keyboardType: TextInputType.number,
                              onSaved: (value) {
                                if (value != null) {}
                              },
                            ),
                          ),
                        ],
                      )),

                  SizedBox(height: 18.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gratuity',
                        style: KTextStyle.subTitle1
                            .copyWith(color: KColor.blackShade),
                      ),
                      Obx(() {
                        return Text(
                          '\$ ${(cartController.gratuityAmount)}',
                          style: KTextStyle.subTitle1
                              .copyWith(color: KColor.blackShade),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 18.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: KTextStyle.headline7
                            .copyWith(color: KColor.blackShade),
                      ),
                      Obx(() {
                        return Text(
                          '\$ ${f.format(cartController.totalAmount.value)}',
                          style: KTextStyle.headline7
                              .copyWith(color: KColor.blackShade),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: KSize.getHeight(context, 18.5)),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(height: KSize.getHeight(context, 14.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
