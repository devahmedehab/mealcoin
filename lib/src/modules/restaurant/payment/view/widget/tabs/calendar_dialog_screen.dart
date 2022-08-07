import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:chefsandmeals_customer/src/style/k_textStyle.dart';

class CalendarDialogScreen extends StatelessWidget {
  const CalendarDialogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: KSize.getHeight(context, 380),
      decoration: BoxDecoration(
          color: KColor.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: KSize.getHeight(context, 31)),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 20)),
            child: SfDateRangePicker(
              /*initialSelectedDate:dateTime,
              onSelectionChanged: (dateTime){

              },*/
              toggleDaySelection: true,
              rangeSelectionColor: KColor.primary.withOpacity(0.5),
              startRangeSelectionColor: KColor.primary,
              endRangeSelectionColor: KColor.primary,
              todayHighlightColor: KColor.primary,
              selectionColor: KColor.primary,
              view: DateRangePickerView.month,
              rangeTextStyle: KTextStyle.bodyText.copyWith(color: KColor.white),
              allowViewNavigation: true,
              enableMultiView: false,
              headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: KTextStyle.headline8.copyWith(
                      color: KColor.primary, fontWeight: FontWeight.w500)),
              monthViewSettings:
                  const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              selectionMode: DateRangePickerSelectionMode.range,
            ),
          ),
          SizedBox(width: KSize.getWidth(context, 42)),
        ],
      ),
    );
  }
}
