import 'dart:convert';

// To parse this JSON data, do
//
//     final allDeliveryTypeRequest = allDeliveryTypeRequestFromMap(jsonString);

class AllDeliveryTypeRequest {
  AllDeliveryTypeRequest({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  List<Result>? result;
  dynamic? targetUrl;
  bool? success;
  dynamic? error;
  bool? unAuthorizedRequest;
  bool? abp;

  factory AllDeliveryTypeRequest.fromJson(String str) =>
      AllDeliveryTypeRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllDeliveryTypeRequest.fromMap(Map<String, dynamic> json) =>
      AllDeliveryTypeRequest(
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
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

class Result {
  Result({
    this.id,
    this.displayName,
    this.pictureId,
    this.picture,
  });

  int? id;
  String? displayName;
  String? pictureId;
  String? picture;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
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
