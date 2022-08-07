import 'dart:convert';

import 'error.dart';

// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromMap(jsonString);

class SignUpResponse {
  SignUpResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  SignUpResult? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory SignUpResponse.fromJson(String str) =>
      SignUpResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignUpResponse.fromMap(Map<String, dynamic> json) => SignUpResponse(
        result: json["result"] == null
            ? null
            : SignUpResult.fromMap(json["result"]),
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

class SignUpResult {
  SignUpResult({
    this.phone,
  });

  String? phone;

  factory SignUpResult.fromJson(String str) =>
      SignUpResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignUpResult.fromMap(Map<String, dynamic> json) => SignUpResult(
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "phone": phone,
      };
}
