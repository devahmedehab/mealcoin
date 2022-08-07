import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/view/landingScreen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/global%20widgets/k_app_bar.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/myOrders/controller/orderController.dart';
import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final controller = Get.put(OrderController());
  bool expand = false;
  int? tapped;
  late AnimationController animateControl;
  late Animation<Offset> offset;

  onPop(){
    Get.offAll(()=>LandingScreen());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()=>onPop(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppCustomColors.primaryColor,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: (){
                Get.offAll(()=>LandingScreen());
              },
              icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
            ),

          ),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Obx(
                () => controller.ordersByContactResponse.value.result == null
                    ? Center(child: new CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: controller
                            .ordersByContactResponse.value.result!.items!.length,
                        itemBuilder: (context, index) {
                          var item = controller.ordersByContactResponse.value
                              .result!.items![index];
                          return InkWell(
                            onTap: () {
                              debugPrint('List item $index tapped $expand');
                              setState(() {
                                /// XOR operand returns when either or both conditions are true
                                /// `tapped == null` on initial app start, [tapped] is null
                                /// `index == tapped` initiate action only on tapped item
                                /// `!expand` should check previous expand action
                                expand = ((tapped == null) ||
                                        ((index == tapped) || !expand))
                                    ? !expand
                                    : expand;

                                /// This tracks which index was tapped
                                tapped = index;
                                debugPrint('current expand state: $expand');
                              });
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  SizedBox(height: KSize.getHeight(context, 41)),
                                  Row(
                                    children: [
                                      Container(
                                        width: size.width * 0.20,
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  '# ${item.id}',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  '${item.creationTime}',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Image.asset(
                                              'assets/images/line.png',
                                              fit: BoxFit.contain,
                                              height:
                                                  KSize.getHeight(context, 35),
                                            ),
                                          ],
                                        ),
                                      ),

                                      /// China Gate Chef
                                      Container(
                                        width: size.width * 0.45,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            item.storeName == null
                                                ? Text("Burger King",
                                                    style: KTextStyle.subTitle3
                                                        .copyWith(
                                                            color: KColor.black))
                                                : Text(item.storeName!,
                                                    style: KTextStyle.subTitle3
                                                        .copyWith(
                                                            color: KColor.black)),
                                            SizedBox(
                                                height:
                                                    KSize.getHeight(context, 2)),
                                            Text(
                                              '${item.orderItems!.first.productName} \ndetails..',
                                              style: KTextStyle.bodyText2
                                                  .copyWith(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),

                                      /// $225
                                      Container(
                                        width: size.width * 0.29,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('\$${item.totalAmount}',
                                                style: KTextStyle.headline7),
                                            SizedBox(
                                                height:
                                                    KSize.getHeight(context, 5)),
                                            Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: AppCustomColors
                                                      .primaryColor,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0),
                                                  )),
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Text(
                                                        item.orderStatusName ??
                                                            "",
                                                        style: KTextStyle.overLine
                                                            .copyWith(
                                                                fontSize: 8,
                                                                color:
                                                                    KColor.white,
                                                                letterSpacing: 0),
                                                      ))),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: KSize.getHeight(context, 16)),
                                  Divider(color: KColor.darkGray, thickness: 1.2),
                                  SizedBox(height: KSize.getHeight(context, 24)),
                                  expand == true && index == tapped
                                      ? Column(
                                          children: [
                                            /*  Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Transform.translate(
                                                  offset: Offset(-45, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        '4:00 pm',
                                                        style: KTextStyle.caption,
                                                      ),
                                                      Text('Order Placed',
                                                          style: KTextStyle.caption
                                                              .copyWith(
                                                                  color:
                                                                      KColor.gray)),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: KSize.getWidth(
                                                        context, 17)),
                                                Transform.translate(
                                                  offset: Offset(-45, 0),
                                                  child: Container(
                                                    height: KSize.getHeight(
                                                        context, 47),
                                                    width:
                                                        KSize.getWidth(context, 47),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: KColor.primary,
                                                            width: 2)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(6.0),
                                                      child: Container(
                                                          height: KSize.getHeight(
                                                              context, 35),
                                                          width: KSize.getWidth(
                                                              context, 35),
                                                          decoration: BoxDecoration(
                                                            color: KColor.primary,
                                                            shape: BoxShape.circle,
                                                            // border: Border.all(color: KColor.primary,width: 2)
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Image.asset(
                                                              'assets/images/tick.png',
                                                              height:
                                                                  KSize.getHeight(
                                                                      context, 17),
                                                              width: KSize.getWidth(
                                                                  context, 17),
                                                              fit: BoxFit.contain,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Image.asset(
                                              'assets/images/dotLine.png',
                                              height: KSize.getHeight(context, 50),
                                              width: KSize.getWidth(context, 32),
                                              fit: BoxFit.contain,
                                            ),

                                            /// Second Order Status
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Transform.translate(
                                                  offset: Offset(33, 0),
                                                  child: Container(
                                                    height: KSize.getHeight(
                                                        context, 47),
                                                    width:
                                                        KSize.getWidth(context, 47),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                KColor.lightGray2,
                                                            width: 2)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(6.0),
                                                      child: Container(
                                                          height: KSize.getHeight(
                                                              context, 35),
                                                          width: KSize.getWidth(
                                                              context, 35),
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color:
                                                                KColor.lightGray2,
                                                            shape: BoxShape.circle,
                                                            // border: Border.all(color: KColor.primary,width: 2)
                                                          ),
                                                          child: Text(
                                                            'Track\nOrder',
                                                            style: KTextStyle
                                                                .overLine
                                                                .copyWith(
                                                                    fontSize: 8,
                                                                    letterSpacing:
                                                                        0.2),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                Transform.translate(
                                                  offset: Offset(45, 0),
                                                  child: Text(
                                                    '4:30pm\nIn Transist',
                                                    style: KTextStyle.caption
                                                        .copyWith(
                                                            color: KColor.gray),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Image.asset(
                                              'assets/images/dotLine.png',
                                              height: KSize.getHeight(context, 50),
                                              width: KSize.getWidth(context, 32),
                                              fit: BoxFit.contain,
                                              color: KColor.lightGray,
                                            ),

                                            /// Third Order Status
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Transform.translate(
                                                  offset: Offset(-35, 0),
                                                  child: Text('5:00pm\nDelivered',
                                                      style: KTextStyle.caption
                                                          .copyWith(
                                                              color: KColor.gray)),
                                                ),
                                                SizedBox(
                                                    width: KSize.getWidth(
                                                        context, 17)),
                                                Transform.translate(
                                                  offset: Offset(-35, 0),
                                                  child: Container(
                                                    height: KSize.getHeight(
                                                        context, 47),
                                                    width:
                                                        KSize.getWidth(context, 47),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: KColor.primary,
                                                            width: 2)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(6.0),
                                                      child: Container(
                                                          height: KSize.getHeight(
                                                              context, 35),
                                                          width: KSize.getWidth(
                                                              context, 35),
                                                          decoration: BoxDecoration(
                                                            color: KColor.primary,
                                                            shape: BoxShape.circle,
                                                            // border: Border.all(color: KColor.primary,width: 2)
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Image.asset(
                                                              'assets/images/tick.png',
                                                              height:
                                                                  KSize.getHeight(
                                                                      context, 17),
                                                              width: KSize.getWidth(
                                                                  context, 17),
                                                              fit: BoxFit.contain,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    KSize.getHeight(context, 22)),*/

                                            ListView.builder(
                                                physics: ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    item.orderItems!.length,
                                                itemBuilder: (context, index) {
                                                  var order =
                                                      item.orderItems![index];
                                                  return Row(
                                                    children: [
                                                      Container(
                                                        width: size.width * 0.7,
                                                        child: Text(
                                                          '${order.productName} (${order.quantity})',
                                                          style: KTextStyle
                                                              .bodyText2
                                                              .copyWith(
                                                                  fontSize: 15),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        '\$${order.unitPrice}',
                                                        style: KTextStyle
                                                            .subTitle3
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    KColor.black),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                            SizedBox(
                                                height:
                                                    KSize.getHeight(context, 6)),

                                            /*        Row(
                                              children: [
                                                Spacer(),
                                                Text(
                                                  'Sub Total',
                                                  style: KTextStyle.bodyText2
                                                      .copyWith(fontSize: 15),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '\$00',
                                                  style: KTextStyle.subTitle3
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: KColor.black),
                                                ),
                                              ],
                                            ),*/
                                            SizedBox(
                                                height:
                                                    KSize.getHeight(context, 6)),
                                            Row(
                                              children: [
                                                Text(
                                                  'Total Item ',
                                                  style: KTextStyle.bodyText2
                                                      .copyWith(fontSize: 15),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '${item.orderItems!.length}',
                                                  style: KTextStyle.subTitle3
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: KColor.black),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    KSize.getHeight(context, 6)),
                                            Row(
                                              children: [
                                                Text(
                                                  'Sales Tax ',
                                                  style: KTextStyle.bodyText2
                                                      .copyWith(fontSize: 15),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '\$${item.totalTaxAmount}',
                                                  style: KTextStyle.subTitle3
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: KColor.black),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    KSize.getHeight(context, 6)),
                                            Row(
                                              children: [
                                                Text(
                                                  'Delivery Type ',
                                                  style: KTextStyle.bodyText2
                                                      .copyWith(fontSize: 15),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '${item.deliveryTypeName ?? "-"}',
                                                  style: KTextStyle.subTitle3
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: KColor.black),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    KSize.getHeight(context, 6)),
                                            /*    Row(
                                              children: [
                                                Text(
                                                  'Delivery Charges',
                                                  style: KTextStyle.bodyText2
                                                      .copyWith(fontSize: 15),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '\$00',
                                                  style: KTextStyle.subTitle3
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: KColor.black),
                                                ),
                                              ],
                                            ),*/
                                            SizedBox(
                                                height:
                                                    KSize.getHeight(context, 12)),
                                            Row(
                                              children: [
                                                Text(
                                                  'Total',
                                                  style: KTextStyle.bodyText2
                                                      .copyWith(fontSize: 15),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '\$${item.totalAmount}',
                                                  style: KTextStyle.subTitle3
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: KColor.black),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ))),
    );
  }
}
