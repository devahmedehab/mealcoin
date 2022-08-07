import 'dart:convert';

import 'error.dart';

// To parse this JSON data, do
//
//     final sendPasswordResetCodeByEmailResponse = sendPasswordResetCodeByEmailResponseFromMap(jsonString);

class SendPasswordResetCodeByEmailResponse {
  SendPasswordResetCodeByEmailResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  PasswordResetCodeResult? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory SendPasswordResetCodeByEmailResponse.fromJson(String str) =>
      SendPasswordResetCodeByEmailResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SendPasswordResetCodeByEmailResponse.fromMap(
          Map<String, dynamic> json) =>
      SendPasswordResetCodeByEmailResponse(
        result: json["result"] == null
            ? null
            : PasswordResetCodeResult.fromMap(json["result"]),
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

class PasswordResetCodeResult {
  PasswordResetCodeResult({
    this.email,
  });

  String? email;

  factory PasswordResetCodeResult.fromJson(String str) =>
      PasswordResetCodeResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PasswordResetCodeResult.fromMap(Map<String, dynamic> json) =>
      PasswordResetCodeResult(
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
      };
}
