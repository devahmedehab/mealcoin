import 'dart:convert';

// To parse this JSON data, do
//
//     final topCategoriesByStoreRequest = topCategoriesByStoreRequestFromMap(jsonString);

class TopProductsByStoreRequest {
  TopProductsByStoreRequest({
    required this.storeId,
  });

  int storeId;

  TopProductsByStoreRequest copyWith({
    int? storeId,
  }) =>
      TopProductsByStoreRequest(
        storeId: storeId ?? this.storeId,
      );

  factory TopProductsByStoreRequest.fromJson(String str) =>
      TopProductsByStoreRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TopProductsByStoreRequest.fromMap(Map<String, dynamic> json) =>
      TopProductsByStoreRequest(
        storeId: json["storeId"] == null ? null : json["storeId"],
      );

  Map<String, dynamic> toMap() => {
        "storeId": storeId,
      };
}
