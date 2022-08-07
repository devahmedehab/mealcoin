import 'dart:convert';

class ImageConverter {
  static String convertStringToImage(String image) {
    return utf8.decode(base64Url.decode(image));
  }
}
