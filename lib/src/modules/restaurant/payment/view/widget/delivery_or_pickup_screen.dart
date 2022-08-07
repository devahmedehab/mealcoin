import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_app_bar.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/controller/cartController.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/payment/view/delivery_page.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

import '../confirmOrderScreen.dart';
import 'payment_details_screen.dart';

class DeliveryOrPickupScreen extends StatefulWidget {
  @override
  State<DeliveryOrPickupScreen> createState() => _DeliveryOrPickupScreenState();
}

class _DeliveryOrPickupScreenState extends State<DeliveryOrPickupScreen> {
  final List<String> statusList = [
    'Deliver',
    'Payment',
    'Confirm',
  ];

  final List<String> statusImageList = [
    'assets/images/Group1.png',
    'assets/images/Group2.png',
    'assets/images/Group3.png',
  ];

  int _currentPage = 0;
  String orderState = "PROCESS TO PAYMENT";
  final List<Widget> listOfScreen = [
    DeliveryDetailsScreen(),
    PaymentDetailsScreen(),
    ConfirmOrderScreen()
  ];

  PageController _controller = PageController(
    initialPage: 0,
  );

  onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

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
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: KAppBar(
        isCustomLeading: true,
        customIcon: Icons.arrow_back_ios,
        customTitle: Text('Payment Process'),
      ),
      body: Container(
        child: Stack(
          children: [
            ListView(
              //physics: NeverScrollableScrollPhysics(),
              children: [
                /// Pagination
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: KSize.getWidth(context, 22),
                    vertical: 10,
                  ),
                  child: Container(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List<Widget>.generate(3, (int index) {
                        return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    statusList[index],
                                    style: KTextStyle.headline7.copyWith(
                                        color: (index == _currentPage ||
                                                index == _currentPage - 1 ||
                                                index == _currentPage - 2)
                                            ? KColor.black
                                            : KColor.gray),
                                  ),
                                  Image.asset(
                                    statusImageList[index],
                                    height: KSize.getHeight(context, 48),
                                    width: KSize.getWidth(context, 48),
                                    fit: BoxFit.contain,
                                    color: (index == _currentPage ||
                                            index == _currentPage - 1 ||
                                            index == _currentPage - 2)
                                        ? KColor.primary
                                        : KColor.gray,
                                  )
                                ],
                              ),
                            ));
                      }),
                    ),
                  ),
                ),
                Container(
                  child: listOfScreen[_currentPage],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () async {
                  if (_currentPage == 0) {
                    if (cartController.deliveryTypeId.value > 0 &&
                        cartController.selectedAddress > 0) {
                      if (_currentPage < 2) {
                        MyDialog.loadingDialog(context, "Processing");
                        final response = await cartController.getTaxRate();
                        MyDialog.closeDialog(context);
                        setState(() {
                          _currentPage = _currentPage + 1;
                          orderState = "Process to confirm";
                        });
                      } else {}
                    } else {
                      Utils.showSnackBar(
                          context, "Please select order type & address");
                    }
                  } else if (_currentPage == 1) {
                    if (cartController.selectedPaymentType.value > 0) {
                      if (cartController.selectedPaymentType.value == 1 &&
                          cartController.nonce.isNotEmpty) {
                        if (_currentPage < 2) {
                          setState(() {
                            _currentPage = _currentPage + 1;
                            orderState = "Confirm";
                          });
                        } else {}
                      } else if (cartController.selectedPaymentType.value !=
                          1) {
                        if (_currentPage < 2) {
                          setState(() {
                            _currentPage = _currentPage + 1;
                            orderState = "Confirm";
                          });
                        } else {}
                      }
                    } else {
                      Utils.showSnackBar(context, "Please select payment type");
                    }
                  } else if (_currentPage == 2) {
                    MyDialog.loadingDialog(context, "Creating Order");
                    if (cartController.selectedPaymentType.value > 0) {
                      await cartController.createOrder();
                      MyDialog.closeDialog(context);
                    } else {
                      MyDialog.closeDialog(context);
                    }
                  }
                },
                child: Container(
                  height: KSize.getHeight(context, 50),
                  width: double.infinity,
                  color: KColor.primary,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Spacer(),
                      Transform.translate(
                        offset: Offset(15, 0),
                        child: Text(
                          '$orderState',
                          style: KTextStyle.headline8.copyWith(
                              color: KColor.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon:
                            Icon(Icons.arrow_forward_ios, color: KColor.white),
                        onPressed: () {
                          // context.nextPage(ConfirmOrderScreen());
                        },
                      ),
                      SizedBox(
                        width: KSize.getWidth(context, 17),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
