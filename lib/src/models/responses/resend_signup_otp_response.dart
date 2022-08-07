import 'dart:convert';

import 'error.dart';

// To parse this JSON data, do
//
//     final resendSignUpOtpResponse = resendSignUpOtpResponseFromMap(jsonString);

class ResendSignUpOtpResponse {
  ResendSignUpOtpResponse({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  ResendOTPResult? result;
  String? targetUrl;
  bool? success;
  ErrorResponse? error;
  bool? unAuthorizedRequest;
  bool? abp;

  factory ResendSignUpOtpResponse.fromJson(String str) =>
      ResendSignUpOtpResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResendSignUpOtpResponse.fromMap(Map<String, dynamic> json) =>
      ResendSignUpOtpResponse(
        result: json["result"] == null
            ? null
            : ResendOTPResult.fromMap(json["result"]),
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

class ResendOTPResult {
  ResendOTPResult({
    this.phone,
  });

  String? phone;

  factory ResendOTPResult.fromJson(String str) =>
      ResendOTPResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResendOTPResult.fromMap(Map<String, dynamic> json) => ResendOTPResult(
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "phone": phone,
      };
}
