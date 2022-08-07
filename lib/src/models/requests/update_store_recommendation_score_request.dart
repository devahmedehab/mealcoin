import 'dart:convert';

class UpdateStoreRecommendationScoreRequest {
  UpdateStoreRecommendationScoreRequest({
    required this.storeId,
    required this.contactId,
    this.isClicked = true,
  });

  int storeId;
  int contactId;
  bool isClicked;

  factory UpdateStoreRecommendationScoreRequest.fromJson(String str) =>
      UpdateStoreRecommendationScoreRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateStoreRecommendationScoreRequest.fromMap(
          Map<String, dynamic> json) =>
      UpdateStoreRecommendationScoreRequest(
        storeId: json["storeId"],
        contactId: json["contactId"],
        isClicked: json["isClicked"],
      );

  Map<String, dynamic> toMap() => {
        "storeId": storeId,
        "contactId": contactId,
        "isClicked": isClicked,
      };
}
