import 'dart:convert';

// To parse this JSON data, do
//
//     final getProductReviewsResponse = getProductReviewsResponseFromMap(jsonString);

class GetProductReviewsResponse {
  GetProductReviewsResponse({
    required this.totalCount,
    required this.productReviews,
  });

  int? totalCount;
  List<ProductReview>? productReviews;

  GetProductReviewsResponse copyWith({
    int? totalCount,
    List<ProductReview>? productReviews,
  }) =>
      GetProductReviewsResponse(
        totalCount: totalCount ?? this.totalCount,
        productReviews: productReviews ?? this.productReviews,
      );

  factory GetProductReviewsResponse.fromJson(String str) =>
      GetProductReviewsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetProductReviewsResponse.fromMap(Map<String, dynamic> json) =>
      GetProductReviewsResponse(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        productReviews: json["productReviews"] == null
            ? null
            : List<ProductReview>.from(
                json["productReviews"].map((x) => ProductReview.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "productReviews": productReviews == null
            ? null
            : List<dynamic>.from(productReviews!.map((x) => x.toMap())),
      };
}

class ProductReview {
  ProductReview({
    required this.ratingLikeName,
    required this.contactName,
    required this.storeName,
    required this.productName,
    required this.numberOfFeedbacks,
    required this.ratingScore,
    required this.reviewInfo,
    required this.postDate,
    required this.isPublish,
    required this.postTime,
    required this.contactId,
    required this.productId,
    required this.storeId,
    required this.ratingLikeId,
    required this.id,
  });

  String ratingLikeName;
  String contactName;
  String storeName;
  String productName;
  int numberOfFeedbacks;
  double ratingScore;
  String reviewInfo;
  String postDate;
  bool isPublish;
  String postTime;
  int contactId;
  int productId;
  int storeId;
  int ratingLikeId;
  int id;

  ProductReview copyWith({
    String? ratingLikeName,
    String? contactName,
    String? storeName,
    String? productName,
    int? numberOfFeedbacks,
    double? ratingScore,
    String? reviewInfo,
    String? postDate,
    bool? isPublish,
    String? postTime,
    int? contactId,
    int? productId,
    int? storeId,
    int? ratingLikeId,
    int? id,
  }) =>
      ProductReview(
        ratingLikeName: ratingLikeName ?? this.ratingLikeName,
        contactName: contactName ?? this.contactName,
        storeName: storeName ?? this.storeName,
        productName: productName ?? this.productName,
        numberOfFeedbacks: numberOfFeedbacks ?? this.numberOfFeedbacks,
        ratingScore: ratingScore ?? this.ratingScore,
        reviewInfo: reviewInfo ?? this.reviewInfo,
        postDate: postDate ?? this.postDate,
        isPublish: isPublish ?? this.isPublish,
        postTime: postTime ?? this.postTime,
        contactId: contactId ?? this.contactId,
        productId: productId ?? this.productId,
        storeId: storeId ?? this.storeId,
        ratingLikeId: ratingLikeId ?? this.ratingLikeId,
        id: id ?? this.id,
      );

  factory ProductReview.fromJson(String str) =>
      ProductReview.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductReview.fromMap(Map<String, dynamic> json) => ProductReview(
        ratingLikeName:
            json["ratingLikeName"] == null ? null : json["ratingLikeName"],
        contactName: json["contactName"] == null ? null : json["contactName"],
        storeName: json["storeName"] == null ? null : json["storeName"],
        productName: json["productName"] == null ? null : json["productName"],
        numberOfFeedbacks: json["numberOfFeedbacks"] == null
            ? null
            : json["numberOfFeedbacks"],
        ratingScore: json["ratingScore"] == null ? null : json["ratingScore"],
        reviewInfo: json["reviewInfo"] == null ? null : json["reviewInfo"],
        postDate: json["postDate"] == null ? null : json["postDate"],
        isPublish: json["isPublish"] == null ? null : json["isPublish"],
        postTime: json["postTime"] == null ? null : json["postTime"],
        contactId: json["contactId"] == null ? null : json["contactId"],
        productId: json["productId"] == null ? null : json["productId"],
        storeId: json["storeId"] == null ? null : json["storeId"],
        ratingLikeId:
            json["ratingLikeId"] == null ? null : json["ratingLikeId"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "ratingLikeName": ratingLikeName == null ? null : ratingLikeName,
        "contactName": contactName == null ? null : contactName,
        "storeName": storeName == null ? null : storeName,
        "productName": productName == null ? null : productName,
        "numberOfFeedbacks":
            numberOfFeedbacks == null ? null : numberOfFeedbacks,
        "ratingScore": ratingScore == null ? null : ratingScore,
        "reviewInfo": reviewInfo == null ? null : reviewInfo,
        "postDate": postDate == null ? null : postDate,
        "isPublish": isPublish == null ? null : isPublish,
        "postTime": postTime == null ? null : postTime,
        "contactId": contactId == null ? null : contactId,
        "productId": productId == null ? null : productId,
        "storeId": storeId == null ? null : storeId,
        "ratingLikeId": ratingLikeId == null ? null : ratingLikeId,
        "id": id == null ? null : id,
      };
}
