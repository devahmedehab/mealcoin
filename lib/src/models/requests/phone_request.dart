import 'dart:convert';

// To parse this JSON data, do
//
//     final phoneRequest = phoneRequestFromMap(jsonString);

class PhoneRequest {
  PhoneRequest({
    required this.phone,
  });

  String phone;

  factory PhoneRequest.fromJson(String str) =>
      PhoneRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PhoneRequest.fromMap(Map<String, dynamic> json) => PhoneRequest(
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "phone": phone,
      };
}
