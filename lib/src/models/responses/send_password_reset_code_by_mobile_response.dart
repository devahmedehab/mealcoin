import 'dart:convert';

import 'error.dart';

// To parse this JSON data, do
//
//     final sendPasswordResetCodeByMobileResponse = sendPasswordResetCodeByMobileResponseFromMap(jsonString);

class SendPasswordResetCodeByMobileResponse {
  SendPasswordResetCodeByMobileResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  MobileResult? result;
  dynamic targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory SendPasswordResetCodeByMobileResponse.fromJson(String str) =>
      SendPasswordResetCodeByMobileResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SendPasswordResetCodeByMobileResponse.fromMap(
          Map<String, dynamic> json) =>
      SendPasswordResetCodeByMobileResponse(
        result: json["result"] == null
            ? null
            : MobileResult.fromMap(json["result"]),
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
        "error": error!.toMap(),
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class MobileResult {
  MobileResult({
    this.phone,
  });

  String? phone;

  factory MobileResult.fromJson(String str) =>
      MobileResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MobileResult.fromMap(Map<String, dynamic> json) => MobileResult(
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "phone": phone,
      };
}
