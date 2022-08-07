import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final getAllCountryResponse = getAllCountryResponseFromMap(jsonString);

class GetAllCountryAndStateResponse {
  GetAllCountryAndStateResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  List<CountryResult>? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetAllCountryAndStateResponse.fromJson(String str) =>
      GetAllCountryAndStateResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllCountryAndStateResponse.fromMap(Map<String, dynamic> json) =>
      GetAllCountryAndStateResponse(
        result: json["result"] == null
            ? null
            : List<CountryResult>.from(
                json["result"].map((x) => CountryResult.fromMap(x))),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error:
            json["error"] == null ? null : ErrorResponse.fromMap(json["error"]),
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

class CountryResult {
  CountryResult({
    this.id,
    this.displayName,
  });

  int? id;
  String? displayName;

  factory CountryResult.fromJson(String str) =>
      CountryResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CountryResult.fromMap(Map<String, dynamic> json) => CountryResult(
        id: json["id"],
        displayName: json["displayName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "displayName": displayName,
      };
}
