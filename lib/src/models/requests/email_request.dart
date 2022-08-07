import 'dart:convert';

// To parse this JSON data, do
//
//     final emailRequest = emailRequestFromMap(jsonString);

class EmailRequest {
  EmailRequest({
    required this.email,
  });

  String email;

  factory EmailRequest.fromJson(String str) =>
      EmailRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmailRequest.fromMap(Map<String, dynamic> json) => EmailRequest(
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
      };
}
