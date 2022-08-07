import 'package:flutter/material.dart';

import 'delivery_or_pickup_screen.dart';
import 'payment_details_screen.dart';

class DeliverySliderScreen extends StatefulWidget {
  const DeliverySliderScreen({Key? key}) : super(key: key);

  @override
  State<DeliverySliderScreen> createState() => _DeliverySliderScreenState();
}

class _DeliverySliderScreenState extends State<DeliverySliderScreen> {
  int _currentPage = 0;

  final List<Widget> list = [
    DeliveryOrPickupScreen(),
    PaymentDetailsScreen(),
  ];
  PageController _controller = PageController(
    initialPage: 0,
  );

  onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Expanded(
          child: Container(color: Colors.blue),
        )
        // backgroundColor: KColor.gray,
        );
  }
}
