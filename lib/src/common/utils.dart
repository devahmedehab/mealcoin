import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontFamily: 'Poppins',
          decoration: TextDecoration.none,
          fontSize: 16,
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void navigateToPage(
      BuildContext context, Widget widget, int duration, bool replacePage) {
    if (replacePage) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          fullscreenDialog: true,
          transitionDuration: Duration(milliseconds: duration),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity:
                  animation, // CurvedAnimation(parent: animation, curve: Curves.elasticInOut),
              child: child,
            );
          },
        ),
      );
    } else {
      Navigator.of(context).push(
        PageRouteBuilder(
          fullscreenDialog: true,
          transitionDuration: Duration(milliseconds: duration),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity:
                  animation, // CurvedAnimation(parent: animation, curve: Curves.elasticInOut),
              child: child,
            );
          },
        ),
      );
    }
  }

  static void launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  static String formteDate(DateTime date) {
    final fdate = DateFormat('dd MMM yyyy').format(date).toString();
    return fdate;
  }

  static String formteTime(DateTime date) {
    final ftime = DateFormat('HH : mm a').format(date).toString();
    return ftime;
  }

  static Future<String> pickImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    List<int> imageBytes = File(photo!.path).readAsBytesSync();
    print(imageBytes);
    var base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  static Future<String> pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    List<int> imageBytes = File(photo!.path).readAsBytesSync();
    print(imageBytes);
    var base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}
