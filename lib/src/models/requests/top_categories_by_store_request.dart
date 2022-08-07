import 'dart:convert';

// To parse this JSON data, do
//
//     final topCategoriesByStoreRequest = topCategoriesByStoreRequestFromMap(jsonString);

class TopCategoriesByStoreRequest {
  TopCategoriesByStoreRequest({
    required this.storeId,
  });

  int storeId;

  TopCategoriesByStoreRequest copyWith({
    int? storeId,
  }) =>
      TopCategoriesByStoreRequest(
        storeId: storeId ?? this.storeId,
      );

  factory TopCategoriesByStoreRequest.fromJson(String str) =>
      TopCategoriesByStoreRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TopCategoriesByStoreRequest.fromMap(Map<String, dynamic> json) =>
      TopCategoriesByStoreRequest(
        storeId: json["storeId"] == null ? null : json["storeId"],
      );

  Map<String, dynamic> toMap() => {
        "storeId": storeId,
      };
}
