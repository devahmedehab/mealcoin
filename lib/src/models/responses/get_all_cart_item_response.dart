import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final getAllCartItemResponse = getAllCartItemResponseFromMap(jsonString);

class GetAllCartItemResponse {
  GetAllCartItemResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  CartResult? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetAllCartItemResponse.fromJson(String str) =>
      GetAllCartItemResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllCartItemResponse.fromMap(Map<String, dynamic> json) =>
      GetAllCartItemResponse(
        result:
            json["result"] == null ? null : CartResult.fromMap(json["result"]),
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

class CartResult {
  CartResult({
    this.subTotal,
    this.total,
    this.taxPercentage,
    this.taxAmount,
    this.totalDiscount,
    this.taxRateId,
    this.cartItems,
  });

  double? subTotal;
  double? total;
  double? taxPercentage;
  double? taxAmount;
  double? totalDiscount;
  int? taxRateId;
  List<CartItem>? cartItems;

  factory CartResult.fromJson(String str) =>
      CartResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartResult.fromMap(Map<String, dynamic> json) => CartResult(
        subTotal: json["subTotal"].toDouble(),
        total: json["total"].toDouble(),
        taxPercentage: json["taxPercentage"].toDouble(),
        taxAmount: json["taxAmount"].toDouble(),
        totalDiscount: json["totalDiscount"] == null
            ? null
            : json["totalDiscount"].toDouble(),
        taxRateId: json["taxRateId"] == null ? null : json["taxRateId"],
        cartItems: List<CartItem>.from(
            json["cartItems"].map((x) => CartItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "subTotal": subTotal,
        "total": total,
        "taxPercentage": taxPercentage,
        "taxAmount": taxAmount,
        "totalDiscount": totalDiscount,
        "taxRateId": taxRateId,
        "cartItems": List<dynamic>.from(cartItems!.map((x) => x.toMap())),
      };
}

class CartItem {
  CartItem({
    this.id,
    this.productId,
    this.storeId,
    this.productName,
    this.productPicture,
    this.quantity,
    this.unitPrice,
    this.unitTotalAmount,
  });

  int? id;
  int? productId;
  int? storeId;
  String? productName;
  String? productPicture;
  int? quantity;
  double? unitPrice;
  double? unitTotalAmount;

  factory CartItem.fromJson(String str) => CartItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartItem.fromMap(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        productId: json["productId"],
        storeId: json["storeId"],
        productName: json["productName"],
        productPicture: json["productPicture"],
        quantity: json["quantity"],
        unitPrice: json["unitPrice"].toDouble(),
        unitTotalAmount: json["unitTotalAmount"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "productId": productId,
        "storeId": storeId,
        "productName": productName,
        "productPicture": productPicture,
        "quantity": quantity,
        "unitPrice": unitPrice,
        "unitTotalAmount": unitTotalAmount,
      };
}
