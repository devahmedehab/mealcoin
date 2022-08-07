import 'dart:convert';

// To parse this JSON data, do
//
//     final loginWithFacebookRequest = loginWithFacebookRequestFromMap(jsonString);

class SocialLoginRequest {
  SocialLoginRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    this.picture,
    required this.provider,
    required this.providerKey,
  });

  String firstName;
  String lastName;
  String email;
  String mobile;
  String? picture;
  String provider;
  String providerKey;

  factory SocialLoginRequest.fromJson(String str) =>
      SocialLoginRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialLoginRequest.fromMap(Map<String, dynamic> json) =>
      SocialLoginRequest(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        mobile: json["mobile"],
        picture: json["picture"],
        provider: json["provider"],
        providerKey: json["providerKey"],
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "mobile": mobile,
        "picture": picture,
        "provider": provider,
        "providerKey": providerKey,
      };
}
