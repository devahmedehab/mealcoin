import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final populorStoreResponse = populorStoreResponseFromMap(jsonString);

class PopularStoreResponse {
  PopularStoreResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  List<StoreResult>? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory PopularStoreResponse.fromJson(String str) =>
      PopularStoreResponse.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory PopularStoreResponse.fromMap(Map<String, dynamic> json) =>
      PopularStoreResponse(
        result: json["result"] == null
            ? null
            : List<StoreResult>.from(
                json["result"].map((x) => StoreResult.fromMap(x))),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result!.map((x) => x.toMap())),
        "targetUrl": targetUrl,
        "success": success,
        "error": error!.toMap(),
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class StoreResult {
  StoreResult({
    this.id,
    this.name,
    this.logoId,
    this.logoUrl,
  });

  int? id;
  String? name;
  String? logoId;
  String? logoUrl;

  factory StoreResult.fromJson(String str) =>
      StoreResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoreResult.fromMap(Map<String, dynamic> json) => StoreResult(
        id: json["id"],
        name: json["name"],
        logoId: json["logoId"],
        logoUrl: json["logoUrl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "logoId": logoId,
        "logoUrl": logoUrl,
      };
}
