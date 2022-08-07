import 'dart:convert';

import 'error.dart';

// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromMap(jsonString);

class LoginResponse {
  LoginResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  LoginWithEmailResult? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory LoginResponse.fromJson(String str) =>
      LoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        result: LoginWithEmailResult.fromMap(json["result"]),
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

class LoginWithEmailResult {
  LoginWithEmailResult({
    this.contactId,
    this.phone,
    this.errorMessage,
    this.membershipTypeId,
    this.accessToken,
    this.encryptedAccessToken,
    this.expireInSeconds,
    this.shouldResetPassword,
    this.passwordResetCode,
    this.userId,
    this.requiresTwoFactorVerification,
    this.twoFactorAuthProviders,
    this.twoFactorRememberClientToken,
    this.returnUrl,
    this.refreshToken,
    this.refreshTokenExpireInSeconds,
  });

  int? contactId;
  String? phone;
  String? errorMessage;
  int? membershipTypeId;
  String? accessToken;
  String? encryptedAccessToken;
  int? expireInSeconds;
  bool? shouldResetPassword;
  String? passwordResetCode;
  int? userId;
  bool? requiresTwoFactorVerification;
  List<String>? twoFactorAuthProviders;
  String? twoFactorRememberClientToken;
  String? returnUrl;
  String? refreshToken;
  int? refreshTokenExpireInSeconds;

  factory LoginWithEmailResult.fromJson(String str) =>
      LoginWithEmailResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginWithEmailResult.fromMap(Map<String, dynamic> json) =>
      LoginWithEmailResult(
        contactId: json["contactId"],
        phone: json["phone"],
        errorMessage: json["errorMessage"],
        membershipTypeId: json["membershipTypeId"],
        accessToken: json["accessToken"],
        encryptedAccessToken: json["encryptedAccessToken"],
        expireInSeconds: json["expireInSeconds"],
        shouldResetPassword: json["shouldResetPassword"],
        passwordResetCode: json["passwordResetCode"],
        userId: json["userId"],
        requiresTwoFactorVerification: json["requiresTwoFactorVerification"],
        twoFactorAuthProviders: json["twoFactorAuthProviders"],
        twoFactorRememberClientToken: json["twoFactorRememberClientToken"],
        returnUrl: json["returnUrl"],
        refreshToken: json["refreshToken"],
        refreshTokenExpireInSeconds: json["refreshTokenExpireInSeconds"],
      );

  Map<String, dynamic> toMap() => {
        "contactId": contactId,
        "phone": phone,
        "errorMessage": errorMessage,
        "membershipTypeId": membershipTypeId,
        "accessToken": accessToken,
        "encryptedAccessToken": encryptedAccessToken,
        "expireInSeconds": expireInSeconds,
        "shouldResetPassword": shouldResetPassword,
        "passwordResetCode": passwordResetCode,
        "userId": userId,
        "requiresTwoFactorVerification": requiresTwoFactorVerification,
        "twoFactorAuthProviders": twoFactorAuthProviders,
        "twoFactorRememberClientToken": twoFactorRememberClientToken,
        "returnUrl": returnUrl,
        "refreshToken": refreshToken,
        "refreshTokenExpireInSeconds": refreshTokenExpireInSeconds,
      };
}
