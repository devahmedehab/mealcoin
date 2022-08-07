import 'dart:convert';

import 'error.dart';

// To parse this JSON data, do
//
//     final resetPasswordResponse = resetPasswordResponseFromMap(jsonString);

class ResetPasswordResponse {
  ResetPasswordResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  ResetPasswordResult? result;
  dynamic targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory ResetPasswordResponse.fromJson(String str) =>
      ResetPasswordResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResetPasswordResponse.fromMap(Map<String, dynamic> json) =>
      ResetPasswordResponse(
        result: json["result"] == null
            ? null
            : ResetPasswordResult.fromMap(json["result"]),
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

class ResetPasswordResult {
  ResetPasswordResult({
    this.canLogin,
  });

  bool? canLogin;

  factory ResetPasswordResult.fromJson(String str) =>
      ResetPasswordResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResetPasswordResult.fromMap(Map<String, dynamic> json) =>
      ResetPasswordResult(
        canLogin: json["canLogin"],
      );

  Map<String, dynamic> toMap() => {
        "canLogin": canLogin,
      };
}
