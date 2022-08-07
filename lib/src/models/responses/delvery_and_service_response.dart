import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final deliveryChargeAndServiceResponse = deliveryChargeAndServiceResponseFromMap(jsonString);

class DeliveryChargeAndServiceResponse {
  DeliveryChargeAndServiceResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  StoreSettingResult? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory DeliveryChargeAndServiceResponse.fromJson(String str) =>
      DeliveryChargeAndServiceResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeliveryChargeAndServiceResponse.fromMap(Map<String, dynamic> json) =>
      DeliveryChargeAndServiceResponse(
        result: StoreSettingResult.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
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

class StoreSettingResult {
  StoreSettingResult({
    this.storeSetting,
  });

  StoreSetting? storeSetting;

  factory StoreSettingResult.fromJson(String str) =>
      StoreSettingResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoreSettingResult.fromMap(Map<String, dynamic> json) =>
      StoreSettingResult(
        storeSetting: StoreSetting.fromMap(json["storeSetting"]),
      );

  Map<String, dynamic> toMap() => {
        "storeSetting": storeSetting!.toMap(),
      };
}

class StoreSetting {
  StoreSetting({
    this.deliveryCharge,
    this.serviceCharge,
  });

  double? deliveryCharge;
  double? serviceCharge;

  factory StoreSetting.fromJson(String str) =>
      StoreSetting.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoreSetting.fromMap(Map<String, dynamic> json) => StoreSetting(
        deliveryCharge: json["deliveryCharge"],
        serviceCharge: json["serviceCharge"],
      );

  Map<String, dynamic> toMap() => {
        "deliveryCharge": deliveryCharge,
        "serviceCharge": serviceCharge,
      };
}
