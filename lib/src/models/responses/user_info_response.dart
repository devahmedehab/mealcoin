import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final userInfoResponse = userInfoResponseFromMap(jsonString);

class UserInfoResponse {
  UserInfoResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  UserInfoResult? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory UserInfoResponse.fromJson(String str) =>
      UserInfoResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfoResponse.fromMap(Map<String, dynamic> json) =>
      UserInfoResponse(
        result: json["result"] == null
            ? null
            : UserInfoResult.fromMap(json["result"]),
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
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class UserInfoResult {
  UserInfoResult({
    this.userId,
    this.fullName,
    this.firstName,
    this.surname,
    this.userName,
    this.emailAddress,
    this.phone,
    this.profilePicture,
    this.contactId,
    this.membershipTypeId,
    this.walletAmount,
    this.rewardPoints,
    this.numberOfOrders,
  });

  int? userId;
  String? fullName;
  String? firstName;
  String? surname;
  String? userName;
  String? emailAddress;
  String? phone;
  String? profilePicture;
  int? contactId;
  int? membershipTypeId;
  double? walletAmount;
  int? rewardPoints;
  int? numberOfOrders;

  factory UserInfoResult.fromJson(String str) =>
      UserInfoResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfoResult.fromMap(Map<String, dynamic> json) => UserInfoResult(
        userId: json["userId"],
        fullName: json["fullName"],
        firstName: json["firstName"],
        surname: json["surname"],
        userName: json["userName"],
        emailAddress: json["emailAddress"],
        phone: json["phone"],
        profilePicture: json["profilePicture"],
        contactId: json["contactId"],
        membershipTypeId: json["membershipTypeId"],
        walletAmount: json["walletAmount"] == null
            ? null
            : json["walletAmount"].toDouble(),
        rewardPoints: json["rewardPoints"],
        numberOfOrders: json["numberOfOrders"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "fullName": fullName,
        "firstName": firstName,
        "surname": surname,
        "userName": userName,
        "emailAddress": emailAddress,
        "phone": phone,
        "profilePicture": profilePicture,
        "contactId": contactId,
        "membershipTypeId": membershipTypeId,
        "walletAmount": walletAmount,
        "rewardPoints": rewardPoints,
        "numberOfOrders": numberOfOrders,
      };
}
