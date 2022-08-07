import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final getAllSyncContactResponse = getAllSyncContactResponseFromMap(jsonString);

class GetAllSyncContactResponse {
  GetAllSyncContactResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  List<SnycContactResult>? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetAllSyncContactResponse.fromJson(String str) =>
      GetAllSyncContactResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllSyncContactResponse.fromMap(Map<String, dynamic> json) =>
      GetAllSyncContactResponse(
        result: json["result"] == null
            ? null
            : List<SnycContactResult>.from(
                json["result"].map((x) => SnycContactResult.fromMap(x))),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"] == null ? null : json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result!.map((x) => x.toMap())),
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class SnycContactResult {
  SnycContactResult({
    this.id,
    this.isReferred,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
  });

  int? id;
  bool? isReferred;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;

  factory SnycContactResult.fromJson(String str) =>
      SnycContactResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SnycContactResult.fromMap(Map<String, dynamic> json) =>
      SnycContactResult(
        id: json["id"],
        isReferred: json["isReferred"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobile: json["mobile"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "isReferred": isReferred,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "email": email,
      };
}
