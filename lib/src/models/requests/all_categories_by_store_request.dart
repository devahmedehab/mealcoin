import 'dart:convert';

// To parse this JSON data, do
//
//     final allCategoriesByStoreRequest = allCategoriesByStoreRequestFromMap(jsonString);

class AllCategoriesByStoreRequest {
  AllCategoriesByStoreRequest({
    required this.storeId,
    required this.skipCount,
    required this.maxCount,
  });

  int storeId;
  int skipCount;
  int maxCount;

  AllCategoriesByStoreRequest copyWith({
    int? storeId,
    int? skipCount,
    int? maxCount,
  }) =>
      AllCategoriesByStoreRequest(
        storeId: storeId ?? this.storeId,
        skipCount: skipCount ?? this.skipCount,
        maxCount: maxCount ?? this.maxCount,
      );

  factory AllCategoriesByStoreRequest.fromJson(String str) =>
      AllCategoriesByStoreRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllCategoriesByStoreRequest.fromMap(Map<String, dynamic> json) =>
      AllCategoriesByStoreRequest(
        storeId: json["storeId"] == null ? null : json["storeId"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxCount: json["maxCount"] == null ? null : json["maxCount"],
      );

  Map<String, dynamic> toMap() => {
        "storeId": storeId,
        "skipCount": skipCount,
        "maxCount": maxCount,
      };
}
