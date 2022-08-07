import 'package:flutter/material.dart';

import '../hubSelectionScreen.dart';

Future<dynamic> hubSelectionModalWidget(
    BuildContext context, String filterType) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            // border: Border.all(color: AppCustomColors.primaryColor,width: 2),
                            borderRadius: BorderRadius.circular(18)),
                        child: HubSelectionScreen(
                          filterType: filterType,
                        )),
                  ),
                ],
              ),
            ));
      });
}
