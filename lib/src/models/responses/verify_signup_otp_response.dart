import 'dart:convert';

import 'error.dart';

// To parse this JSON data, do
//
//     final resendSignUpOtpResponse = resendSignUpOtpResponseFromMap(jsonString);

class VerifySignUpOtpResponse {
  VerifySignUpOtpResponse({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  VerifyOTPResult? result;
  String? targetUrl;
  bool? success;
  ErrorResponse? error;
  bool? unAuthorizedRequest;
  bool? abp;

  factory VerifySignUpOtpResponse.fromJson(String str) =>
      VerifySignUpOtpResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifySignUpOtpResponse.fromMap(Map<String, dynamic> json) =>
      VerifySignUpOtpResponse(
        result: json["result"] == null
            ? null
            : VerifyOTPResult.fromMap(json["result"]),
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

class VerifyOTPResult {
  VerifyOTPResult({
    this.canLogin,
  });

  bool? canLogin;

  factory VerifyOTPResult.fromJson(String str) =>
      VerifyOTPResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifyOTPResult.fromMap(Map<String, dynamic> json) => VerifyOTPResult(
        canLogin: json["canLogin"],
      );

  Map<String, dynamic> toMap() => {
        "canLogin": canLogin,
      };
}
