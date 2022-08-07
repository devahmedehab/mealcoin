import 'dart:convert';

import 'error.dart';

// To parse this JSON data, do
//
//     final getProductMediasResponse = getProductMediasResponseFromMap(jsonString);

class GetProductMediasResponse {
  GetProductMediasResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  List<ProductMediaResult>? result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetProductMediasResponse.fromJson(String str) =>
      GetProductMediasResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetProductMediasResponse.fromMap(Map<String, dynamic> json) =>
      GetProductMediasResponse(
        result: json["result"] == null
            ? null
            : List<ProductMediaResult>.from(
                json["result"].map((x) => ProductMediaResult.fromMap(x))),
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

class ProductMediaResult {
  ProductMediaResult({
    this.productMedia,
    this.productName,
    this.mediaLibraryName,
    this.picture,
    this.videoUrl,
  });

  ProductMedia? productMedia;
  String? productName;
  String? mediaLibraryName;
  String? picture;
  String? videoUrl;

  ProductMediaResult copyWith({
    ProductMedia? productMedia,
    String? productName,
    String? mediaLibraryName,
    String? picture,
    String? videoUrl,
  }) =>
      ProductMediaResult(
        productMedia: productMedia ?? this.productMedia,
        productName: productName ?? this.productName,
        mediaLibraryName: mediaLibraryName ?? this.mediaLibraryName,
        picture: picture ?? this.picture,
        videoUrl: videoUrl ?? this.videoUrl,
      );

  factory ProductMediaResult.fromJson(String str) =>
      ProductMediaResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductMediaResult.fromMap(Map<String, dynamic> json) =>
      ProductMediaResult(
        productMedia: ProductMedia.fromMap(json["productMedia"]),
        productName: json["productName"] == null ? null : json["productName"],
        mediaLibraryName:
            json["mediaLibraryName"] == null ? null : json["mediaLibraryName"],
        picture: json["picture"] == null ? null : json["picture"],
        videoUrl: json["videoUrl"] == null ? null : json["videoUrl"],
      );

  Map<String, dynamic> toMap() => {
        "productMedia": productMedia == null ? null : productMedia?.toMap(),
        "productName": productName == null ? null : productName,
        "mediaLibraryName": mediaLibraryName == null ? null : mediaLibraryName,
        "picture": picture == null ? null : picture,
        "videoUrl": videoUrl == null ? null : videoUrl,
      };
}

class ProductMedia {
  ProductMedia({
    required this.displaySequenceNumber,
    required this.productId,
    required this.mediaLibraryId,
    required this.id,
  });

  int? displaySequenceNumber;
  int productId;
  int mediaLibraryId;
  int id;

  ProductMedia copyWith({
    int? displaySequenceNumber,
    int? productId,
    int? mediaLibraryId,
    int? id,
  }) =>
      ProductMedia(
        displaySequenceNumber:
            displaySequenceNumber ?? this.displaySequenceNumber,
        productId: productId ?? this.productId,
        mediaLibraryId: mediaLibraryId ?? this.mediaLibraryId,
        id: id ?? this.id,
      );

  factory ProductMedia.fromJson(String str) =>
      ProductMedia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductMedia.fromMap(Map<String, dynamic> json) => ProductMedia(
        displaySequenceNumber: json["displaySequenceNumber"] == null
            ? null
            : json["displaySequenceNumber"],
        productId: json["productId"] == null ? null : json["productId"],
        mediaLibraryId:
            json["mediaLibraryId"] == null ? null : json["mediaLibraryId"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "displaySequenceNumber":
            displaySequenceNumber == null ? null : displaySequenceNumber,
        "productId": productId == null ? null : productId,
        "mediaLibraryId": mediaLibraryId == null ? null : mediaLibraryId,
        "id": id == null ? null : id,
      };
}
