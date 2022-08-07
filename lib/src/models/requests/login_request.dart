import 'dart:convert';

// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromMap(jsonString);

class LoginRequest {
  LoginRequest({
    required this.userNameOrEmailAddress,
    required this.password,
  });

  String userNameOrEmailAddress;
  String password;

  factory LoginRequest.fromJson(String str) =>
      LoginRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromMap(Map<String, dynamic> json) => LoginRequest(
        userNameOrEmailAddress: json["userNameOrEmailAddress"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "userNameOrEmailAddress": userNameOrEmailAddress,
        "password": password,
      };
}
