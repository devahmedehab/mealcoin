import 'dart:convert';

import 'error.dart';

// To parse this JSON data, do
//
//     final loginWithSocialResponse = loginWithSocialResponseFromMap(jsonString);

class LoginWithSocialResponse {
  LoginWithSocialResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  Result? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory LoginWithSocialResponse.fromJson(String str) =>
      LoginWithSocialResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginWithSocialResponse.fromMap(Map<String, dynamic> json) =>
      LoginWithSocialResponse(
        result: json["result"] == null ? null : Result.fromMap(json["result"]),
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
        "error": error!.toMap(),
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class Result {
  Result({
    this.userId,
    this.contactId,
    this.membershipTypeId,
    this.accessToken,
    this.encryptedAccessToken,
    this.expireInSeconds,
    this.waitingForActivation,
    this.returnUrl,
    this.refreshToken,
    this.refreshTokenExpireInSeconds,
  });

  int? userId;
  int? contactId;
  int? membershipTypeId;
  String? accessToken;
  String? encryptedAccessToken;
  int? expireInSeconds;
  bool? waitingForActivation;
  String? returnUrl;
  String? refreshToken;
  int? refreshTokenExpireInSeconds;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        userId: json["userId"],
        contactId: json["contactId"],
        membershipTypeId: json["membershipTypeId"],
        accessToken: json["accessToken"],
        encryptedAccessToken: json["encryptedAccessToken"],
        expireInSeconds: json["expireInSeconds"],
        waitingForActivation: json["waitingForActivation"],
        returnUrl: json["returnUrl"],
        refreshToken: json["refreshToken"],
        refreshTokenExpireInSeconds: json["refreshTokenExpireInSeconds"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "contactId": contactId,
        "membershipTypeId": membershipTypeId,
        "accessToken": accessToken,
        "encryptedAccessToken": encryptedAccessToken,
        "expireInSeconds": expireInSeconds,
        "waitingForActivation": waitingForActivation,
        "returnUrl": returnUrl,
        "refreshToken": refreshToken,
        "refreshTokenExpireInSeconds": refreshTokenExpireInSeconds,
      };
}
