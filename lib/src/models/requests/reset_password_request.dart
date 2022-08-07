import 'dart:convert';

// To parse this JSON data, do
//
//     final resetPasswordRequest = resetPasswordRequestFromMap(jsonString);

class ResetPasswordRequest {
  ResetPasswordRequest({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory ResetPasswordRequest.fromJson(String str) =>
      ResetPasswordRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResetPasswordRequest.fromMap(Map<String, dynamic> json) =>
      ResetPasswordRequest(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
      };
}
