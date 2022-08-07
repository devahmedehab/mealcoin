import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final addWishListResponse = addWishListResponseFromMap(jsonString);

class AddWishListResponse {
  AddWishListResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  bool? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory AddWishListResponse.fromJson(String str) =>
      AddWishListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddWishListResponse.fromMap(Map<String, dynamic> json) =>
      AddWishListResponse(
        result: json["result"] ?? null,
        targetUrl: json["targetUrl"] ?? null,
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
