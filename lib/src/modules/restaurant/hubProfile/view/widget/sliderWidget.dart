import 'dart:math';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

Widget sliderWidget(double width, Random random) {
  return Container(
    margin: EdgeInsets.only(bottom: 18),
    child: SizedBox(
        height: 220,
        child: CarouselSlider(
          options: CarouselOptions(
            height: 220.0,
            autoPlay: true,
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Color((random.nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                        borderRadius: BorderRadius.circular(14)),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            'slider $i',
                            style: TextStyle(fontSize: 22.0),
                          ),
                        )));
              },
            );
          }).toList(),
        )),
  );
}
