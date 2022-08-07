import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final productResponse = productResponseFromMap(jsonString);

class ProductResponse {
  ProductResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  List<ProductResult>? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory ProductResponse.fromJson(String str) =>
      ProductResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponse.fromMap(Map<String, dynamic> json) => ProductResponse(
        result: json["result"] == null
            ? null
            : List<ProductResult>.from(
                json["result"].map((x) => ProductResult.fromMap(x))),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error:
            json["error"] == null ? null : ErrorResponse.fromMap(json["error"]),
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result!.map((x) => x.toMap())),
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class ProductResult {
  ProductResult({
    this.productId,
    this.productName,
    this.picture,
    this.regularPrice,
    this.salesPrice,
    this.shortDescription,
    this.stockQuantity,
    this.ratingScore,
    this.currencyIcon,
    this.storeId,
    this.storeName,
    this.storeLogo,
    this.currencyId,
    this.membershipPrice,
    this.membershipTypeName,
  });

  int? productId;
  String? productName;
  String? picture;
  double? regularPrice;
  double? salesPrice;
  String? shortDescription;
  int? stockQuantity;
  double? ratingScore;
  String? currencyIcon;
  int? storeId;
  String? storeName;
  String? storeLogo;
  int? currencyId;
  double? membershipPrice;
  String? membershipTypeName;

  factory ProductResult.fromJson(String str) =>
      ProductResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResult.fromMap(Map<String, dynamic> json) => ProductResult(
        productId: json["productId"],
        productName: json["productName"],
        picture: json["picture"],
        regularPrice: json["regularPrice"].toDouble(),
        salesPrice:
            json["salesPrice"] == null ? null : json["salesPrice"].toDouble(),
        shortDescription: json["shortDescription"],
        stockQuantity: json["stockQuantity"],
        ratingScore:
            json["ratingScore"] == null ? null : json["ratingScore"].toDouble(),
        currencyIcon: json["currencyIcon"],
        storeId: json["storeId"],
        storeName: json["storeName"],
        storeLogo: json["storeLogo"],
        currencyId: json["currencyId"],
        membershipPrice: json["membershipPrice"] == null
            ? null
            : json["membershipPrice"].toDouble(),
        membershipTypeName: json["membershipTypeName"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "productName": productName,
        "picture": picture,
        "regularPrice": regularPrice,
        "salesPrice": salesPrice,
        "shortDescription": shortDescription,
        "stockQuantity": stockQuantity,
        "ratingScore": ratingScore,
        "currencyIcon": currencyIcon,
        "storeId": storeId,
        "storeName": storeName,
        "storeLogo": storeLogo,
        "currencyId": currencyId,
        "membershipPrice": membershipPrice,
        "membershipTypeName": membershipTypeName,
      };
}
