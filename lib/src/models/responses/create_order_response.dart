import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final createOrderResponse = createOrderResponseFromMap(jsonString);

class CreateOrderResponse {
  CreateOrderResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  int? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory CreateOrderResponse.fromJson(String str) =>
      CreateOrderResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateOrderResponse.fromMap(Map<String, dynamic> json) =>
      CreateOrderResponse(
        result: json["result"] == null ? null : json["result"],
        targetUrl: json["targetUrl"],
        success: json["success"],
        error:
            json["error"] == null ? null : ErrorResponse.fromMap(json["error"]),
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}
