import 'dart:convert';

// To parse this JSON data, do
//
//     final allProductsByStoreAndCategoryRequest = allProductsByStoreAndCategoryRequestFromMap(jsonString);

class AllProductsByStoreAndCategoryRequest {
  AllProductsByStoreAndCategoryRequest({
    required this.storeId,
    required this.productCategoryId,
    required this.skipCount,
    required this.maxCount,
  });

  int storeId;
  int productCategoryId;
  int skipCount;
  int maxCount;

  AllProductsByStoreAndCategoryRequest copyWith({
    int? storeId,
    int? productCategoryId,
    int? skipCount,
    int? maxCount,
  }) =>
      AllProductsByStoreAndCategoryRequest(
        storeId: storeId ?? this.storeId,
        productCategoryId: productCategoryId ?? this.productCategoryId,
        skipCount: skipCount ?? this.skipCount,
        maxCount: maxCount ?? this.maxCount,
      );

  factory AllProductsByStoreAndCategoryRequest.fromJson(String str) =>
      AllProductsByStoreAndCategoryRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllProductsByStoreAndCategoryRequest.fromMap(
          Map<String, dynamic> json) =>
      AllProductsByStoreAndCategoryRequest(
        storeId: json["storeId"] == null ? null : json["storeId"],
        productCategoryId: json["productCategoryId"] == null
            ? null
            : json["productCategoryId"],
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxCount: json["maxCount"] == null ? null : json["maxCount"],
      );

  Map<String, dynamic> toMap() => {
        "storeId": storeId,
        "productCategoryId": productCategoryId,
        "skipCount": skipCount,
        "maxCount": maxCount,
      };
}
