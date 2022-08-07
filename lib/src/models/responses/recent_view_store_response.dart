import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final recentViewedStoreResponse = recentViewedStoreResponseFromMap(jsonString);

class RecentViewedStoreResponse {
  RecentViewedStoreResponse({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  List<RecentStoreResult>? result;
  dynamic? targetUrl;
  bool? success;
  ErrorResponse? error;
  bool? unAuthorizedRequest;
  bool? abp;

  factory RecentViewedStoreResponse.fromJson(String str) =>
      RecentViewedStoreResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecentViewedStoreResponse.fromMap(Map<String, dynamic> json) =>
      RecentViewedStoreResponse(
        result: List<RecentStoreResult>.from(
            json["result"].map((x) => RecentStoreResult.fromMap(x))),
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
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class RecentStoreResult {
  RecentStoreResult({
    this.id,
    this.name,
    this.logoId,
    this.logoUrl,
  });

  int? id;
  String? name;
  String? logoId;
  String? logoUrl;

  factory RecentStoreResult.fromJson(String str) =>
      RecentStoreResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecentStoreResult.fromMap(Map<String, dynamic> json) =>
      RecentStoreResult(
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
