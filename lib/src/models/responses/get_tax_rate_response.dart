import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final getTaxRateResponse = getTaxRateResponseFromMap(jsonString);

class GetTaxRateResponse {
  GetTaxRateResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  TaxRateResult? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetTaxRateResponse.fromJson(String str) =>
      GetTaxRateResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTaxRateResponse.fromMap(Map<String, dynamic> json) =>
      GetTaxRateResponse(
        result: json["result"] == null
            ? null
            : TaxRateResult.fromMap(json["result"]),
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

class TaxRateResult {
  TaxRateResult({this.combinedRate, this.id});

  double? combinedRate;
  int? id;

  factory TaxRateResult.fromJson(String str) =>
      TaxRateResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaxRateResult.fromMap(Map<String, dynamic> json) => TaxRateResult(
        combinedRate: json["combinedRate"].toDouble(),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "combinedRate": combinedRate,
        "id": id,
      };
}
