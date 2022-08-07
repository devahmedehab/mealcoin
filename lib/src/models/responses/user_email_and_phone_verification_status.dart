import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final userEmailAndPhoneVerificationStatus = userEmailAndPhoneVerificationStatusFromMap(jsonString);

class UserEmailAndPhoneVerificationStatus {
  UserEmailAndPhoneVerificationStatus({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  VerificationResult? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory UserEmailAndPhoneVerificationStatus.fromJson(String str) =>
      UserEmailAndPhoneVerificationStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserEmailAndPhoneVerificationStatus.fromMap(
          Map<String, dynamic> json) =>
      UserEmailAndPhoneVerificationStatus(
        result: json["result"] == null
            ? null
            : VerificationResult.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error:
            json["error"] == null ? null : ErrorResponse.fromMap(json["error"]),
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class VerificationResult {
  VerificationResult({
    this.phoneNumber,
    this.isPhoneNumberConfirmed,
    this.email,
    this.isEmailConfirmed,
    this.subscribetToEmail,
    this.subscribetToSms,
  });

  String? phoneNumber;
  bool? isPhoneNumberConfirmed;
  String? email;
  bool? isEmailConfirmed;
  bool? subscribetToEmail;
  bool? subscribetToSms;

  factory VerificationResult.fromJson(String str) =>
      VerificationResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerificationResult.fromMap(Map<String, dynamic> json) =>
      VerificationResult(
        phoneNumber: json["phoneNumber"],
        isPhoneNumberConfirmed: json["isPhoneNumberConfirmed"],
        email: json["email"],
        isEmailConfirmed: json["isEmailConfirmed"],
        subscribetToEmail: json["subscribetToEmail"],
        subscribetToSms: json["subscribetToSms"],
      );

  Map<String, dynamic> toMap() => {
        "phoneNumber": phoneNumber,
        "isPhoneNumberConfirmed": isPhoneNumberConfirmed,
        "email": email,
        "isEmailConfirmed": isEmailConfirmed,
        "subscribetToEmail": subscribetToEmail,
        "subscribetToSms": subscribetToSms,
      };
}
