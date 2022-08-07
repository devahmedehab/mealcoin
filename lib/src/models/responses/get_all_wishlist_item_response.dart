import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final getAllWishListItem = getAllWishListItemFromMap(jsonString);

class GetAllWishListItem {
  GetAllWishListItem({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  WishListResult? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetAllWishListItem.fromJson(String str) =>
      GetAllWishListItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllWishListItem.fromMap(Map<String, dynamic> json) =>
      GetAllWishListItem(
        result: json["result"] == null
            ? null
            : WishListResult.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error:
            json["error"] == null ? null : ErrorResponse.fromMap(json["error"]),
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": result!.toMap(),
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class WishListResult {
  WishListResult({
    this.totalCount,
    this.items,
  });

  int? totalCount;
  List<WishListItem>? items;

  factory WishListResult.fromJson(String str) =>
      WishListResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WishListResult.fromMap(Map<String, dynamic> json) => WishListResult(
        totalCount: json["totalCount"],
        items: List<WishListItem>.from(
            json["items"].map((x) => WishListItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount,
        "items": List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class WishListItem {
  WishListItem({
    this.wishList,
    this.contactName,
    this.storeName,
    this.productName,
    this.regularPrice,
    this.salesPrice,
    this.membershipPrice,
    this.stockQuantity,
    this.categoryName,
    this.picture,
    this.isPackageProduct,
    this.pictureBinaryObjectId,
    this.storeLogo,
    this.productUrl,
    this.storeUrl,
  });

  WishList? wishList;
  String? contactName;
  String? storeName;
  String? productName;
  double? regularPrice;
  double? salesPrice;
  double? membershipPrice;
  int? stockQuantity;
  String? categoryName;
  String? picture;
  bool? isPackageProduct;
  String? pictureBinaryObjectId;
  String? storeLogo;
  String? productUrl;
  String? storeUrl;

  factory WishListItem.fromJson(String str) =>
      WishListItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WishListItem.fromMap(Map<String, dynamic> json) => WishListItem(
        wishList: WishList.fromMap(json["wishList"]),
        contactName: json["contactName"],
        storeName: json["storeName"],
        productName: json["productName"],
        regularPrice: json["regularPrice"].toDouble(),
        salesPrice:
            json["salesPrice"] == null ? null : json["salesPrice"].toDouble(),
        membershipPrice: json["membershipPrice"] == null
            ? null
            : json["membershipPrice"].toDouble(),
        stockQuantity: json["stockQuantity"],
        categoryName: json["categoryName"] ?? null,
        picture: json["picture"] ?? null,
        isPackageProduct: json["isPackageProduct"] ?? null,
        pictureBinaryObjectId: json["pictureBinaryObjectId"] ?? null,
        storeLogo: json["storeLogo"] ?? null,
        productUrl: json["productUrl"] ?? null,
        storeUrl: json["storeUrl"] ?? null,
      );

  Map<String, dynamic> toMap() => {
        "wishList": wishList!.toMap(),
        "contactName": contactName,
        "storeName": storeName,
        "productName": productName,
        "regularPrice": regularPrice,
        "salesPrice": salesPrice,
        "membershipPrice": membershipPrice,
        "stockQuantity": stockQuantity,
        "categoryName": categoryName,
        "picture": picture,
        "isPackageProduct": isPackageProduct,
        "pictureBinaryObjectId": pictureBinaryObjectId,
        "storeLogo": storeLogo,
        "productUrl": productUrl,
        "storeUrl": storeUrl,
      };
}

class WishList {
  WishList({
    this.date,
    this.storeId,
    this.productId,
    this.id,
  });

  String? date;
  int? storeId;
  int? productId;
  int? id;

  factory WishList.fromJson(String str) => WishList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WishList.fromMap(Map<String, dynamic> json) => WishList(
        date: json["date"],
        storeId: json["storeId"],
        productId: json["productId"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "date": date,
        "storeId": storeId,
        "productId": productId,
        "id": id,
      };
}
