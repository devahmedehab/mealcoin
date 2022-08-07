import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final getAllOrdersByContactResponse = getAllOrdersByContactResponseFromMap(jsonString);

class GetAllOrdersByContactResponse {
  GetAllOrdersByContactResponse({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  OrderResult? result;
  dynamic targetUrl;
  bool? success;
  ErrorResponse? error;
  bool? unAuthorizedRequest;
  bool? abp;

  factory GetAllOrdersByContactResponse.fromJson(String str) =>
      GetAllOrdersByContactResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllOrdersByContactResponse.fromMap(Map<String, dynamic> json) =>
      GetAllOrdersByContactResponse(
        result: json["result"] = OrderResult.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"] == null
            ? null
            : ErrorResponse.fromJson(json["error"]),
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

class OrderResult {
  OrderResult({
    this.totalCount,
    this.items,
  });

  int? totalCount;
  List<Item>? items;

  factory OrderResult.fromJson(String str) =>
      OrderResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderResult.fromMap(Map<String, dynamic> json) => OrderResult(
        totalCount: json["totalCount"],
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount,
        "items": List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class Item {
  Item(
      {this.id,
      this.totalAmount,
      this.discountAmount,
      this.totalTaxAmount,
      this.isPaymentCompleted,
      this.isDeliveryOrPickUp,
      this.paymentTypeName,
      this.orderStatusName,
      this.pickupStatusName,
      this.currencyName,
      this.currencyIcon,
      this.deliveryDate,
      this.deliveryTime,
      this.creationTime,
      this.orderStatusColorCode,
      this.pickupStatusColorCode,
      this.storeId,
      this.storeName,
      this.orderItems,
      this.deliveryTypeName});

  int? id;
  double? totalAmount;
  double? discountAmount;
  double? totalTaxAmount;
  bool? isPaymentCompleted;
  bool? isDeliveryOrPickUp;
  String? paymentTypeName;
  String? orderStatusName;
  String? pickupStatusName;
  String? currencyName;
  String? currencyIcon;
  String? deliveryDate;
  String? deliveryTime;
  String? creationTime;
  String? orderStatusColorCode;
  String? pickupStatusColorCode;
  int? storeId;
  String? storeName;
  String? deliveryTypeName;
  List<OrderItem>? orderItems;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        totalAmount: json["totalAmount"],
        discountAmount: json["discountAmount"],
        totalTaxAmount: json["totalTaxAmount"],
        isPaymentCompleted: json["isPaymentCompleted"],
        isDeliveryOrPickUp: json["isDeliveryOrPickUp"],
        paymentTypeName: json["paymentTypeName"],
        orderStatusName: json["orderStatusName"],
        pickupStatusName: json["pickupStatusName"],
        currencyName: json["currencyName"],
        currencyIcon: json["currencyIcon"],
        deliveryDate: json["deliveryDate"],
        deliveryTime: json["deliveryTime"],
        creationTime: json["creationTime"],
        orderStatusColorCode: json["orderStatusColorCode"],
        pickupStatusColorCode: json["pickupStatusColorCode"],
        storeId: json["storeId"],
        storeName: json["storeName"],
        deliveryTypeName: json["deliveryTypeName"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "totalAmount": totalAmount,
        "discountAmount": discountAmount,
        "totalTaxAmount": totalTaxAmount,
        "isPaymentCompleted": isPaymentCompleted,
        "isDeliveryOrPickUp": isDeliveryOrPickUp,
        "paymentTypeName": paymentTypeName,
        "orderStatusName": orderStatusName,
        "pickupStatusName": pickupStatusName,
        "currencyName": currencyName,
        "currencyIcon": currencyIcon,
        "deliveryDate": deliveryDate,
        "deliveryTime": deliveryTime,
        "creationTime": creationTime,
        "orderStatusColorCode": orderStatusColorCode,
        "pickupStatusColorCode": pickupStatusColorCode,
        "storeId": storeId,
        "storeName": storeName,
        "deliveryTypeName": deliveryTypeName,
        "orderItems": List<dynamic>.from(orderItems!.map((x) => x.toMap())),
      };
}

class OrderItem {
  OrderItem({
    this.productId,
    this.productName,
    this.quantity,
    this.unitPrice,
  });

  int? productId;
  String? productName;
  int? quantity;
  double? unitPrice;

  factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        productId: json["productId"],
        productName: json["productName"],
        quantity: json["quantity"],
        unitPrice: json["unitPrice"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "productName": productName,
        "quantity": quantity,
        "unitPrice": unitPrice,
      };
}
