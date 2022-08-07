// import 'package:chefsandmeals_customer/src/global%20widgets/k_app_bar.dart';
// import 'package:chefsandmeals_customer/src/style/k_color.dart';
// import 'package:chefsandmeals_customer/src/style/k_size.dart';
// import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';
// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// import 'delivery_slider_screen.dart';
//
// class AddToCartScreen extends StatefulWidget {
//   const AddToCartScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddToCartScreen> createState() => _AddToCartScreenState();
// }
//
// class _AddToCartScreenState extends State<AddToCartScreen> {
//   int _n = 0;
//
//   void add() {
//     setState(() {
//       _n++;
//     });
//   }
//
//   void minus() {
//     setState(() {
//       if (_n != 0) _n--;
//     });
//   }
//
//   final List<String> foodImageList = [
//     'assets/images/itemPicture.png',
//     'assets/images/itemPicture2.png',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: KAppBar(
//         isCustomLeading: true,
//         customIcon: Icons.arrow_back_ios,
//         customTitle: Text('Cart'),
//         customAction: [
//           Image.asset(
//             'assets/images/wallet.png',
//             height: KSize.getHeight(context, 26.89),
//             width: KSize.getWidth(context, 33.69),
//             fit: BoxFit.contain,
//           ),
//           SizedBox(
//             width: KSize.getWidth(context, 14.3),
//           ),
//           Image.asset(
//             'assets/images/cart.png',
//             height: KSize.getHeight(context, 27.19),
//             width: KSize.getWidth(context, 30.08),
//             fit: BoxFit.contain,
//           ),
//           SizedBox(
//             width: KSize.getWidth(context, 14.3),
//           ),
//           Image.asset(
//             'assets/images/share.png',
//             height: KSize.getHeight(context, 21.77),
//             width: KSize.getWidth(context, 19.68),
//             fit: BoxFit.contain,
//           ),
//           SizedBox(
//             width: KSize.getWidth(context, 14.3),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: KSize.getHeight(context, 28)),
//             Padding(
//               padding:
//                   EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 21)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Your Order',
//                     style: KTextStyle.headline7.copyWith(color: KColor.black),
//                   ),
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           primary: KColor.primary,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25))),
//                       onPressed: () {},
//                       child: Text(
//                         'Add more item',
//                         style: KTextStyle.subTitle1,
//                       ))
//                 ],
//               ),
//             ),
//             SizedBox(height: KSize.getHeight(context, 37)),
//
//             /// Order List
//             SizedBox(
//               height: KSize.getHeight(context, 221),
//               child: ListView.builder(
//                 itemCount: 2,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Card(
//                     margin: EdgeInsets.only(bottom: 11),
//                     child: Container(
//                       height: KSize.getHeight(context, 105),
//                       color: KColor.white,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: KSize.getWidth(context, 11),
//                             vertical: KSize.getHeight(context, 19)),
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               foodImageList[index],
//                               height: KSize.getHeight(context, 66),
//                               width: KSize.getWidth(context, 66),
//                               fit: BoxFit.contain,
//                             ),
//                             SizedBox(width: KSize.getWidth(context, 9.1)),
//                             Column(
//                               children: [
//                                 Spacer(),
//                                 //SizedBox(height: KSize.getHeight(context, 5)),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Ginger Chicken Curry',
//                                       style: KTextStyle.subTitle1.copyWith(
//                                           fontSize: 18,
//                                           color: KColor.black,
//                                           height: 1),
//                                     ),
//                                     // Spacer(),
//                                     Text(
//                                       '\$35',
//                                       style: KTextStyle.subTitle3.copyWith(
//                                           color: KColor.black,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: KSize.getHeight(context, 13)),
//                                 Row(
//                                   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     /// Counter
//                                     Container(
//                                       height: KSize.getHeight(context, 26),
//                                       width: KSize.getWidth(context, 77),
//                                       decoration: BoxDecoration(
//                                           color: KColor.whiteSmoke,
//                                           borderRadius:
//                                               BorderRadius.circular(20)),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Container(
//                                             height:
//                                                 KSize.getHeight(context, 24),
//                                             width: KSize.getWidth(context, 24),
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 color: KColor.primary
//                                                 /*border: Border.all(
//                                           color: KColor.white,
//                                         )*/
//                                                 ),
//                                             child: InkWell(
//                                               onTap: () {
//                                                 minus();
//                                               },
//                                               child: Icon(
//                                                 Icons.remove,
//                                                 color: KColor.white,
//                                                 size: 15,
//                                               ),
//                                             ),
//                                           ),
//                                           Text(
//                                             '$_n',
//                                             style: KTextStyle.subTitle1
//                                                 .copyWith(
//                                                     fontSize: 18,
//                                                     color: KColor.black),
//                                           ),
//                                           Container(
//                                             height:
//                                                 KSize.getHeight(context, 24),
//                                             width: KSize.getWidth(context, 24),
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 color: KColor.primary),
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 add();
//                                                 print('kkkk');
//                                               },
//                                               child: Icon(
//                                                 Icons.add,
//                                                 color: KColor.white,
//                                                 size: 15,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         width: KSize.getWidth(context, 5.1)),
//                                     Text(
//                                       'x  \$ 40',
//                                       style: KTextStyle.subTitle3.copyWith(
//                                           color: KColor.black,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       'Member Price',
//                                       style: KTextStyle.subTitle3.copyWith(
//                                           fontWeight: FontWeight.normal),
//                                     ),
//                                     SizedBox(
//                                         width: KSize.getWidth(context, 2.9)),
//                                     Text(
//                                       '\$20',
//                                       style: KTextStyle.subTitle3.copyWith(
//                                           color: KColor.black,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             //Spacer(),
//             Container(
//               height: KSize.getHeight(context, 302),
//               color: KColor.white,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: KSize.getWidth(context, 11),
//                     vertical: KSize.getHeight(context, 20)),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Sub Total',
//                           style:
//                               KTextStyle.headline8.copyWith(color: KColor.gray),
//                         ),
//                         Text(
//                           '\$ 115.00',
//                           style:
//                               KTextStyle.headline8.copyWith(color: KColor.gray),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: KSize.getHeight(context, 14)),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Sales Tax (8.75%)',
//                           style: KTextStyle.headline8.copyWith(
//                               color: KColor.gray,
//                               fontWeight: FontWeight.normal),
//                         ),
//                         Text(
//                           '\$ 1.00',
//                           style: KTextStyle.headline8.copyWith(
//                               color: KColor.gray,
//                               fontWeight: FontWeight.normal),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: KSize.getHeight(context, 14)),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Delivery Charge',
//                           style: KTextStyle.headline8.copyWith(
//                               color: KColor.gray,
//                               fontWeight: FontWeight.normal),
//                         ),
//                         Text(
//                           '\$ 4.00',
//                           style: KTextStyle.headline8.copyWith(
//                               color: KColor.gray,
//                               fontWeight: FontWeight.normal),
//                         ),
//                       ],
//                     ),
//                     Spacer(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'HubsDeal Member Payable',
//                           style: KTextStyle.bodyText.copyWith(
//                               color: KColor.primary,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         Text(
//                           '\$ 70',
//                           style: KTextStyle.bodyText.copyWith(
//                               color: KColor.primary,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: KSize.getHeight(context, 32)),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'HubsDeal Member Saved',
//                           style: KTextStyle.bodyText.copyWith(
//                               color: KColor.primary,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         Text(
//                           '\$ 45',
//                           style: KTextStyle.bodyText.copyWith(
//                               color: KColor.primary,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     //SizedBox(height: KSize.getHeight(context, 28)),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               height: KSize.getHeight(context, 75),
//               color: KColor.primary,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: KSize.getWidth(context, 22)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Image.asset(
//                       'assets/images/cart_in_btn.png',
//                       height: KSize.getHeight(context, 38.5),
//                       width: KSize.getWidth(context, 43.57),
//                       fit: BoxFit.contain,
//                     ),
//                     Spacer(),
//                     Text(
//                       'Checkout now',
//                       style: KTextStyle.headline8.copyWith(
//                           fontWeight: FontWeight.w500, color: KColor.white),
//                     ),
//                     Spacer(),
//                     Text(
//                       'Pay \$126',
//                       style: KTextStyle.headline8.copyWith(
//                           fontWeight: FontWeight.w500, color: KColor.white),
//                     ),
//                     SizedBox(
//                       width: KSize.getWidth(context, 15.5),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         Icons.arrow_forward_ios,
//                         color: KColor.white,
//                       ),
//                       onPressed: () {
//                         context.nextPage(DeliverySliderScreen());
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
