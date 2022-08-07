import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final userInfoForEdit = userInfoForEditFromMap(jsonString);

class UserInfoForEdit {
  UserInfoForEdit({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  EditUserInfo? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory UserInfoForEdit.fromJson(String str) =>
      UserInfoForEdit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfoForEdit.fromMap(Map<String, dynamic> json) => UserInfoForEdit(
        result: json["result"] == null
            ? null
            : EditUserInfo.fromMap(json["result"]),
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

class EditUserInfo {
  EditUserInfo({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.zipCode,
    this.countryId,
    this.stateId,
    this.city,
    this.dateOfBirth,
    this.picture,
    this.pictureBase64,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? address;
  String? zipCode;
  int? countryId;
  int? stateId;
  String? city;
  String? dateOfBirth;
  String? picture;
  String? pictureBase64;

  factory EditUserInfo.fromJson(String str) =>
      EditUserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditUserInfo.fromMap(Map<String, dynamic> json) => EditUserInfo(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        zipCode: json["zipCode"],
        countryId: json["countryId"],
        stateId: json["stateId"],
        city: json["city"],
        dateOfBirth: json["dateOfBirth"],
        picture: json["picture"],
        pictureBase64: json["pictureBase64"],
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "address": address,
        "zipCode": zipCode,
        "countryId": countryId,
        "stateId": stateId,
        "city": city,
        "dateOfBirth": dateOfBirth,
        "picture": picture,
        "pictureBase64": pictureBase64,
      };
}
