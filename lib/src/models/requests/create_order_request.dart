import 'dart:convert';

// To parse this JSON data, do
//
//     final createOrderRequest = createOrderRequestFromMap(jsonString);

class CreateOrderRequest {
  CreateOrderRequest(
      {this.isDeliveryOrPickup,
      this.fullName,
      this.email,
      this.phone,
      this.deliveryAddress,
      this.zipCode,
      this.customerInstruction,
      this.deliveryFee,
      this.subTotalExcludedTax,
      this.totalDiscountAmount,
      this.totalTaxAmount,
      this.totalAmount,
      this.contactId,
      this.contactAddressId,
      this.currencyId,
      this.paymentId,
      this.paymentTypeId,
      this.isPaymentCompleted,
      this.taxRateId,
      this.isAsap,
      this.pickupDate,
      this.pickupTime,
      this.deliveryDate,
      this.deliveryTime,
      this.deliveryCharge,
      this.serviceCharge,
      this.gratuityAmount,
      this.gratuityPercentage,
      this.orderItems,
      this.storeId,
      this.deliveryTypeId});

  bool? isDeliveryOrPickup;
  String? fullName;
  String? email;
  String? phone;
  String? deliveryAddress;
  String? zipCode;
  String? customerInstruction;
  double? deliveryFee;
  double? subTotalExcludedTax;
  double? totalDiscountAmount;
  double? totalTaxAmount;
  double? totalAmount;
  int? contactId;
  int? contactAddressId;
  int? currencyId;
  String? paymentId;
  int? paymentTypeId;
  bool? isPaymentCompleted;
  int? taxRateId;
  bool? isAsap;
  String? pickupDate;
  String? pickupTime;
  String? deliveryDate;
  String? deliveryTime;
  double? deliveryCharge;
  double? serviceCharge;
  double? gratuityAmount;
  double? gratuityPercentage;
  int? storeId;
  int? deliveryTypeId;
  List<OrderItem>? orderItems;

  factory CreateOrderRequest.fromJson(String str) =>
      CreateOrderRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateOrderRequest.fromMap(Map<String, dynamic> json) =>
      CreateOrderRequest(
        isDeliveryOrPickup: json["isDeliveryOrPickup"],
        fullName: json["fullName"],
        email: json["email"],
        phone: json["phone"],
        deliveryAddress: json["deliveryAddress"],
        zipCode: json["zipCode"],
        customerInstruction: json["customerInstruction"],
        deliveryFee: json["deliveryFee"].toDouble(),
        subTotalExcludedTax: json["subTotalExcludedTax"].toDouble(),
        totalDiscountAmount: json["totalDiscountAmount"].toDouble(),
        totalTaxAmount: json["totalTaxAmount"].toDouble(),
        totalAmount: json["totalAmount"].toDouble(),
        contactId: json["contactId"],
        contactAddressId: json["contactAddressId"],
        currencyId: json["currencyId"],
        paymentId: json["paymentId"],
        paymentTypeId: json["paymentTypeId"],
        isPaymentCompleted: json["isPaymentCompleted"],
        taxRateId: json["taxRateId"],
        isAsap: json["isAsap"],
        pickupDate: json["pickupDate"],
        pickupTime: json["pickupTime"],
        deliveryDate: json["deliveryDate"],
        deliveryTime: json["deliveryTime"],
        deliveryCharge: json["deliveryCharge"].toDouble(),
        serviceCharge: json["serviceCharge"].toDouble(),
        gratuityAmount: json["gratuityAmount"].toDouble(),
        gratuityPercentage: json["gratuityPercentage"].toDouble(),
        deliveryTypeId: json["deliveryTypeId"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "isDeliveryOrPickup": isDeliveryOrPickup,
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "deliveryAddress": deliveryAddress,
        "zipCode": zipCode,
        "customerInstruction": customerInstruction,
        "deliveryFee": deliveryFee,
        "subTotalExcludedTax": subTotalExcludedTax,
        "totalDiscountAmount": totalDiscountAmount,
        "totalTaxAmount": totalTaxAmount,
        "totalAmount": totalAmount,
        "contactId": contactId,
        "contactAddressId": contactAddressId,
        "currencyId": currencyId,
        "paymentId": paymentId,
        "paymentTypeId": paymentTypeId,
        "isPaymentCompleted": isPaymentCompleted,
        "taxRateId": taxRateId,
        "isAsap": isAsap,
        "pickupDate": pickupDate,
        "pickupTime": pickupTime,
        "deliveryDate": deliveryDate,
        "deliveryTime": deliveryTime,
        "deliveryCharge": deliveryCharge,
        "serviceCharge": serviceCharge,
        "gratuityAmount": gratuityAmount,
        "gratuityPercentage": gratuityPercentage,
        "storeId": storeId,
        "deliveryTypeId": deliveryTypeId,
        "orderItems": List<dynamic>.from(orderItems!.map((x) => x.toMap())),
      };
}

class OrderItem {
  OrderItem({
    this.quantity,
    this.unitPrice,
    this.productId,
    this.storeId,
  });

  int? quantity;
  double? unitPrice;
  int? productId;
  int? storeId;

  factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        quantity: json["quantity"],
        unitPrice: json["unitPrice"].toDouble(),
        productId: json["productId"],
        storeId: json["storeId"],
      );

  Map<String, dynamic> toMap() => {
        "quantity": quantity,
        "unitPrice": unitPrice,
        "productId": productId,
        "storeId": storeId,
      };
}
