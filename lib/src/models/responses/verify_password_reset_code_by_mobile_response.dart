import 'dart:convert';

import 'error.dart';

// To parse this JSON data, do
//
//     final verifyPasswordResetCodeByMobileResponse = verifyPasswordResetCodeByMobileResponseFromMap(jsonString);

class VerifyPasswordResetCodeByMobileResponse {
  VerifyPasswordResetCodeByMobileResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  VerifyCodePhoneResult? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory VerifyPasswordResetCodeByMobileResponse.fromJson(String str) =>
      VerifyPasswordResetCodeByMobileResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifyPasswordResetCodeByMobileResponse.fromMap(
          Map<String, dynamic> json) =>
      VerifyPasswordResetCodeByMobileResponse(
        result: json["result"] == null
            ? null
            : VerifyCodePhoneResult.fromMap(json["result"]),
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

class VerifyCodePhoneResult {
  VerifyCodePhoneResult({
    this.email,
    this.canReset,
  });

  String? email;
  bool? canReset;

  factory VerifyCodePhoneResult.fromJson(String str) =>
      VerifyCodePhoneResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifyCodePhoneResult.fromMap(Map<String, dynamic> json) =>
      VerifyCodePhoneResult(
        email: json["email"],
        canReset: json["canReset"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "canReset": canReset,
      };
}
