import 'dart:convert';

import 'error.dart';

// To parse this JSON data, do
//
//     final verifyPasswordResetCodeByEmailResponse = verifyPasswordResetCodeByEmailResponseFromMap(jsonString);

class VerifyPasswordResetCodeByEmailResponse {
  VerifyPasswordResetCodeByEmailResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  VerifyCodeEmailResult? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory VerifyPasswordResetCodeByEmailResponse.fromJson(String str) =>
      VerifyPasswordResetCodeByEmailResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifyPasswordResetCodeByEmailResponse.fromMap(
          Map<String, dynamic> json) =>
      VerifyPasswordResetCodeByEmailResponse(
        result: json["result"] == null
            ? null
            : VerifyCodeEmailResult.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error:
            json["error"] == null ? null : ErrorResponse.fromMap(json["error"]),
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": result?.toMap(),
        "targetUrl": targetUrl,
        "success": success,
        "error": error?.toMap(),
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class VerifyCodeEmailResult {
  VerifyCodeEmailResult({
    this.email,
    this.canReset,
  });

  String? email;
  bool? canReset;

  factory VerifyCodeEmailResult.fromJson(String str) =>
      VerifyCodeEmailResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifyCodeEmailResult.fromMap(Map<String, dynamic> json) =>
      VerifyCodeEmailResult(
        email: json["email"],
        canReset: json["canReset"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "canReset": canReset,
      };
}
