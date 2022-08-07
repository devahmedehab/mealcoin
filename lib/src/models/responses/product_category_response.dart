import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final productCategoryResponse = productCategoryResponseFromMap(jsonString);

class ProductCategoryResponse {
  ProductCategoryResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  List<ProductCategoryResult>? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory ProductCategoryResponse.fromJson(String str) =>
      ProductCategoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductCategoryResponse.fromMap(Map<String, dynamic> json) =>
      ProductCategoryResponse(
        result: json["result"] == null
            ? null
            : List<ProductCategoryResult>.from(
                json["result"].map((x) => ProductCategoryResult.fromMap(x))),
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

class ProductCategoryResult {
  ProductCategoryResult({
    this.id,
    this.name,
    this.pictureId,
    this.pictureUrl,
  });

  int? id;
  String? name;
  int? pictureId;
  String? pictureUrl;

  factory ProductCategoryResult.fromJson(String str) =>
      ProductCategoryResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductCategoryResult.fromMap(Map<String, dynamic> json) =>
      ProductCategoryResult(
        id: json["id"],
        name: json["name"],
        pictureId: json["pictureId"] == null ? null : json["pictureId"],
        pictureUrl: json["pictureUrl"] == null ? null : json["pictureUrl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "pictureId": pictureId == null ? null : pictureId,
        "pictureUrl": pictureUrl == null ? null : pictureUrl,
      };
}
