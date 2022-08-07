import 'dart:convert';

// To parse this JSON data, do
//
//     final getProductMediasRequest = getProductMediasRequestFromMap(jsonString);

class GetProductMediasRequest {
  GetProductMediasRequest({
    required this.productId,
  });

  int productId;

  GetProductMediasRequest copyWith({
    int? productId,
  }) =>
      GetProductMediasRequest(
        productId: productId ?? this.productId,
      );

  factory GetProductMediasRequest.fromJson(String str) =>
      GetProductMediasRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetProductMediasRequest.fromMap(Map<String, dynamic> json) =>
      GetProductMediasRequest(
        productId: json["productId"] == null ? null : json["productId"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId == null ? null : productId,
      };
}
