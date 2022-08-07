import 'dart:convert';

// To parse this JSON data, do
//
//     final verifyOtpRequest = verifyOtpRequestFromMap(jsonString);

class VerifyPhoneOtpRequest {
  VerifyPhoneOtpRequest({
    required this.phone,
    required this.confirmationCode,
  });

  String phone;
  String confirmationCode;

  factory VerifyPhoneOtpRequest.fromJson(String str) =>
      VerifyPhoneOtpRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifyPhoneOtpRequest.fromMap(Map<String, dynamic> json) =>
      VerifyPhoneOtpRequest(
        phone: json["phone"],
        confirmationCode: json["confirmationCode"],
      );

  Map<String, dynamic> toMap() => {
        "phone": phone,
        "confirmationCode": confirmationCode,
      };
}
