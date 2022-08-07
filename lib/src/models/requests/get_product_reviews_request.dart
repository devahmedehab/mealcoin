import 'dart:convert';

// To parse this JSON data, do
//
//     final getProductReviewsRequest = getProductReviewsRequestFromMap(jsonString);

class GetProductReviewsRequest {
  GetProductReviewsRequest({
    required this.productIdFilter,
    required this.isPublish,
    required this.skipCount,
    required this.maxResultCount,
  });

  int productIdFilter;
  int isPublish;
  int skipCount;
  int maxResultCount;

  GetProductReviewsRequest copyWith({
    int? productIdFilter,
    int? isPublish,
    int? skipCount,
    int? maxResultCount,
  }) =>
      GetProductReviewsRequest(
        productIdFilter: productIdFilter ?? this.productIdFilter,
        isPublish: isPublish ?? this.isPublish,
        skipCount: skipCount ?? this.skipCount,
        maxResultCount: maxResultCount ?? this.maxResultCount,
      );

  factory GetProductReviewsRequest.fromJson(String str) =>
      GetProductReviewsRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetProductReviewsRequest.fromMap(Map<String, dynamic> json) =>
      GetProductReviewsRequest(
        productIdFilter:
            json["ProductIdFilter"] == null ? null : json["ProductIdFilter"],
        isPublish: json["IsPublish"] == null ? null : json["IsPublish"],
        skipCount: json["SkipCount"] == null ? null : json["SkipCount"],
        maxResultCount:
            json["MaxResultCount"] == null ? null : json["MaxResultCount"],
      );

  Map<String, dynamic> toMap() => {
        "ProductIdFilter": productIdFilter == null ? null : productIdFilter,
        "IsPublish": isPublish == null ? null : isPublish,
        "SkipCount": skipCount == null ? null : skipCount,
        "MaxResultCount": maxResultCount == null ? null : maxResultCount,
      };
}
