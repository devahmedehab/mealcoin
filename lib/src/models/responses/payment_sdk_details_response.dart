import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final getPaymentSdkDetailsResponse = getPaymentSdkDetailsResponseFromMap(jsonString);

class GetPaymentSdkDetailsResponse {
  GetPaymentSdkDetailsResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  SdkDetailsResult? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetPaymentSdkDetailsResponse.fromJson(String str) =>
      GetPaymentSdkDetailsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPaymentSdkDetailsResponse.fromMap(Map<String, dynamic> json) =>
      GetPaymentSdkDetailsResponse(
        result: json["result"] == null
            ? null
            : SdkDetailsResult.fromMap(json["result"]),
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

class SdkDetailsResult {
  SdkDetailsResult({
    this.environment,
    this.applicationId,
    this.accessToken,
    this.locationId,
  });

  String? environment;
  String? applicationId;
  String? accessToken;
  String? locationId;

  factory SdkDetailsResult.fromJson(String str) =>
      SdkDetailsResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SdkDetailsResult.fromMap(Map<String, dynamic> json) =>
      SdkDetailsResult(
        environment: json["environment"],
        applicationId: json["applicationId"],
        accessToken: json["accessToken"],
        locationId: json["locationId"],
      );

  Map<String, dynamic> toMap() => {
        "environment": environment,
        "applicationId": applicationId,
        "accessToken": accessToken,
        "locationId": locationId,
      };
}
