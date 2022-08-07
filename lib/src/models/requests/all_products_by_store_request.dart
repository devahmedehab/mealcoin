import 'dart:convert';

// To parse this JSON data, do
//
//     final topCategoriesByStoreRequest = topCategoriesByStoreRequestFromMap(jsonString);

class AllProductsByStoreRequest {
  AllProductsByStoreRequest({
    required this.storeId,
  });

  int storeId;

  AllProductsByStoreRequest copyWith({
    int? storeId,
  }) =>
      AllProductsByStoreRequest(
        storeId: storeId ?? this.storeId,
      );

  factory AllProductsByStoreRequest.fromJson(String str) =>
      AllProductsByStoreRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllProductsByStoreRequest.fromMap(Map<String, dynamic> json) =>
      AllProductsByStoreRequest(
        storeId: json["storeId"] == null ? null : json["storeId"],
      );

  Map<String, dynamic> toMap() => {
        "storeId": storeId,
      };
}
