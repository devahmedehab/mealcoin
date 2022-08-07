import 'dart:convert';

class UpdateHubRecommendationScoreRequest {
  UpdateHubRecommendationScoreRequest({
    required this.hubId,
    required this.contactId,
    this.isClicked = true,
  });

  int hubId;
  int contactId;
  bool isClicked;

  factory UpdateHubRecommendationScoreRequest.fromJson(String str) =>
      UpdateHubRecommendationScoreRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateHubRecommendationScoreRequest.fromMap(
          Map<String, dynamic> json) =>
      UpdateHubRecommendationScoreRequest(
        hubId: json["hubId"],
        contactId: json["contactId"],
        isClicked: json["isClicked"],
      );

  Map<String, dynamic> toMap() => {
        "hubId": hubId,
        "contactId": contactId,
        "isClicked": isClicked,
      };
}
