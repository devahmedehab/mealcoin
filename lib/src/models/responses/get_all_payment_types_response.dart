import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final getAllPaymentTypeResponse = getAllPaymentTypeResponseFromMap(jsonString);

class GetAllPaymentTypeResponse {
  GetAllPaymentTypeResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  List<Result>? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetAllPaymentTypeResponse.fromJson(String str) =>
      GetAllPaymentTypeResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllPaymentTypeResponse.fromMap(Map<String, dynamic> json) =>
      GetAllPaymentTypeResponse(
        result: json["result"] == null
            ? null
            : List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
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

class Result {
  Result({
    this.id,
    this.displayName,
  });

  int? id;
  String? displayName;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        displayName: json["displayName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "displayName": displayName,
      };
}
