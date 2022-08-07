import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final getAllDeliveryTypeResponse = getAllDeliveryTypeResponseFromMap(jsonString);

class GetAllDeliveryTypeResponse {
  GetAllDeliveryTypeResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  List<DeliveryTypeResult>? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetAllDeliveryTypeResponse.fromJson(String str) =>
      GetAllDeliveryTypeResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllDeliveryTypeResponse.fromMap(Map<String, dynamic> json) =>
      GetAllDeliveryTypeResponse(
        result: json["result"] == null
            ? null
            : List<DeliveryTypeResult>.from(
                json["result"].map((x) => DeliveryTypeResult.fromMap(x))),
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

class DeliveryTypeResult {
  DeliveryTypeResult({
    this.id,
    this.displayName,
    this.pictureId,
    this.picture,
  });

  int? id;
  String? displayName;
  String? pictureId;
  String? picture;

  factory DeliveryTypeResult.fromJson(String str) =>
      DeliveryTypeResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeliveryTypeResult.fromMap(Map<String, dynamic> json) =>
      DeliveryTypeResult(
        id: json["id"],
        displayName: json["displayName"],
        pictureId: json["pictureId"],
        picture: json["picture"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "displayName": displayName,
        "pictureId": pictureId,
        "picture": picture,
      };
}
