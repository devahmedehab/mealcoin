import 'dart:convert';

// To parse this JSON data, do
//
//     final verifyOtpRequest = verifyOtpRequestFromMap(jsonString);

class VerifyEmailOtpRequest {
  VerifyEmailOtpRequest({
    required this.email,
    required this.confirmationCode,
  });

  String email;
  String confirmationCode;

  factory VerifyEmailOtpRequest.fromJson(String str) =>
      VerifyEmailOtpRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifyEmailOtpRequest.fromMap(Map<String, dynamic> json) =>
      VerifyEmailOtpRequest(
        email: json["email"],
        confirmationCode: json["confirmationCode"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "confirmationCode": confirmationCode,
      };
}
