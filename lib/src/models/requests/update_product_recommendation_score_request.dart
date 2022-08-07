import 'dart:convert';

class UpdateProductRecommendationScoreRequest {
  UpdateProductRecommendationScoreRequest({
    required this.productId,
    required this.contactId,
    this.isClicked = true,
  });

  int productId;
  int contactId;
  bool isClicked;

  factory UpdateProductRecommendationScoreRequest.fromJson(String str) =>
      UpdateProductRecommendationScoreRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateProductRecommendationScoreRequest.fromMap(
          Map<String, dynamic> json) =>
      UpdateProductRecommendationScoreRequest(
        productId: json["productId"],
        contactId: json["contactId"],
        isClicked: json["isClicked"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "contactId": contactId,
        "isClicked": isClicked,
      };
}
