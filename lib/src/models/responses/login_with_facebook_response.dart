import 'dart:convert';

// To parse this JSON data, do
//
//     final loginWithFacebookResponse = loginWithFacebookResponseFromJson(jsonString);

LoginWithFacebookResponse loginWithFacebookResponseFromJson(String str) =>
    LoginWithFacebookResponse.fromJson(json.decode(str));

String loginWithFacebookResponseToJson(LoginWithFacebookResponse data) =>
    json.encode(data.toJson());

class LoginWithFacebookResponse {
  LoginWithFacebookResponse({
    this.userId,
    this.contactId,
    this.membershipTypeId,
    this.accessToken,
    this.encryptedAccessToken,
    this.expireInSeconds,
    this.waitingForActivation,
    this.returnUrl,
    this.refreshToken,
    this.refreshTokenExpireInSeconds,
  });

  int? userId;
  int? contactId;
  int? membershipTypeId;
  String? accessToken;
  String? encryptedAccessToken;
  int? expireInSeconds;
  bool? waitingForActivation;
  String? returnUrl;
  String? refreshToken;
  int? refreshTokenExpireInSeconds;

  LoginWithFacebookResponse copyWith({
    int? userId,
    int? contactId,
    int? membershipTypeId,
    String? accessToken,
    String? encryptedAccessToken,
    int? expireInSeconds,
    bool? waitingForActivation,
    String? returnUrl,
    String? refreshToken,
    int? refreshTokenExpireInSeconds,
  }) =>
      LoginWithFacebookResponse(
        userId: userId ?? this.userId,
        contactId: contactId ?? this.contactId,
        membershipTypeId: membershipTypeId ?? this.membershipTypeId,
        accessToken: accessToken ?? this.accessToken,
        encryptedAccessToken: encryptedAccessToken ?? this.encryptedAccessToken,
        expireInSeconds: expireInSeconds ?? this.expireInSeconds,
        waitingForActivation: waitingForActivation ?? this.waitingForActivation,
        returnUrl: returnUrl ?? this.returnUrl,
        refreshToken: refreshToken ?? this.refreshToken,
        refreshTokenExpireInSeconds:
            refreshTokenExpireInSeconds ?? this.refreshTokenExpireInSeconds,
      );

  factory LoginWithFacebookResponse.fromJson(Map<String, dynamic> json) =>
      LoginWithFacebookResponse(
        userId: json["userId"] == null ? null : json["userId"],
        contactId: json["contactId"] == null ? null : json["contactId"],
        membershipTypeId:
            json["membershipTypeId"] == null ? null : json["membershipTypeId"],
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
        encryptedAccessToken: json["encryptedAccessToken"] == null
            ? null
            : json["encryptedAccessToken"],
        expireInSeconds:
            json["expireInSeconds"] == null ? null : json["expireInSeconds"],
        waitingForActivation: json["waitingForActivation"] == null
            ? null
            : json["waitingForActivation"],
        returnUrl: json["returnUrl"] == null ? null : json["returnUrl"],
        refreshToken:
            json["refreshToken"] == null ? null : json["refreshToken"],
        refreshTokenExpireInSeconds: json["refreshTokenExpireInSeconds"] == null
            ? null
            : json["refreshTokenExpireInSeconds"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "contactId": contactId == null ? null : contactId,
        "membershipTypeId": membershipTypeId == null ? null : membershipTypeId,
        "accessToken": accessToken == null ? null : accessToken,
        "encryptedAccessToken":
            encryptedAccessToken == null ? null : encryptedAccessToken,
        "expireInSeconds": expireInSeconds == null ? null : expireInSeconds,
        "waitingForActivation":
            waitingForActivation == null ? null : waitingForActivation,
        "returnUrl": returnUrl == null ? null : returnUrl,
        "refreshToken": refreshToken == null ? null : refreshToken,
        "refreshTokenExpireInSeconds": refreshTokenExpireInSeconds == null
            ? null
            : refreshTokenExpireInSeconds,
      };
}
