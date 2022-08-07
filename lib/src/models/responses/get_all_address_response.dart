import 'dart:convert';

import 'package:chefsandmeals_customer/src/models/responses/error.dart';

// To parse this JSON data, do
//
//     final getAllAddressResponse = getAllAddressResponseFromMap(jsonString);

class GetAllAddressResponse {
  GetAllAddressResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  Result? result;
  dynamic targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetAllAddressResponse.fromJson(String str) =>
      GetAllAddressResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllAddressResponse.fromMap(Map<String, dynamic> json) =>
      GetAllAddressResponse(
        result: json["result"] == null ? null : Result.fromMap(json["result"]),
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

class Result {
  Result({
    this.totalCount,
    this.items,
  });

  int? totalCount;
  List<AddressList>? items;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        totalCount: json["totalCount"],
        items: List<AddressList>.from(
            json["items"].map((x) => AddressList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount,
        "items": List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class AddressList {
  AddressList({
    this.contactAddress,
    this.stateName,
    this.countryName,
    this.contactName,
  });

  ContactAddress? contactAddress;
  String? stateName;
  String? countryName;
  String? contactName;

  factory AddressList.fromJson(String str) =>
      AddressList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddressList.fromMap(Map<String, dynamic> json) => AddressList(
        contactAddress: ContactAddress.fromMap(json["contactAddress"]),
        stateName: json["stateName"],
        countryName: json["countryName"],
        contactName: json["contactName"],
      );

  Map<String, dynamic> toMap() => {
        "contactAddress": contactAddress!.toMap(),
        "stateName": stateName,
        "countryName": countryName,
        "contactName": contactName,
      };
}

class ContactAddress {
  ContactAddress({
    this.title,
    this.fullAddress,
    this.address,
    this.zipCode,
    this.latitude,
    this.longitude,
    this.isActive,
    this.city,
    this.noteForDelivery,
    this.stateId,
    this.countryId,
    this.contactId,
    this.id,
  });

  String? title;
  String? fullAddress;
  String? address;
  String? zipCode;
  double? latitude;
  double? longitude;
  bool? isActive;
  String? city;
  String? noteForDelivery;
  int? stateId;
  int? countryId;
  int? contactId;
  int? id;

  factory ContactAddress.fromJson(String str) =>
      ContactAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactAddress.fromMap(Map<String, dynamic> json) => ContactAddress(
        title: json["title"],
        fullAddress: json["fullAddress"],
        address: json["address"],
        zipCode: json["zipCode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isActive: json["isActive"],
        city: json["city"],
        noteForDelivery: json["noteForDelivery"],
        stateId: json["stateId"],
        countryId: json["countryId"],
        contactId: json["contactId"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "fullAddress": fullAddress,
        "address": address,
        "zipCode": zipCode,
        "latitude": latitude,
        "longitude": longitude,
        "isActive": isActive,
        "city": city,
        "noteForDelivery": noteForDelivery,
        "stateId": stateId,
        "countryId": countryId,
        "contactId": contactId,
        "id": id,
      };
}
