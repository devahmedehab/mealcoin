import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final addContactResponse = addContactResponseFromMap(jsonString);

class AddContactResponse {
  AddContactResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  dynamic? result;
  dynamic? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory AddContactResponse.fromJson(String str) =>
      AddContactResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddContactResponse.fromMap(Map<String, dynamic> json) =>
      AddContactResponse(
        result: json["result"],
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
