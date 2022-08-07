import 'dart:convert';

// To parse this JSON data, do
//
//     final loginWithSocialRequest = loginWithSocialRequestFromMap(jsonString);

class LoginWithSocialRequest {
  LoginWithSocialRequest({
    required this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.picture,
    required this.provider,
    required this.providerKey,
  });

  String firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? picture;
  String provider;
  String providerKey;

  factory LoginWithSocialRequest.fromJson(String str) =>
      LoginWithSocialRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginWithSocialRequest.fromMap(Map<String, dynamic> json) =>
      LoginWithSocialRequest(
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
