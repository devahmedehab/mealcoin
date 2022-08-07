import 'dart:convert';

// To parse this JSON data, do
//
//     final singleContractRequest = singleContractRequestFromMap(jsonString);

class SingleContractRequest {
  SingleContractRequest({
    required this.contactId,
    required this.firstName,
    this.lastName,
    required this.mobile,
    required this.email,
  });

  int contactId;
  String firstName;
  String? lastName;
  String mobile;
  String email;

  factory SingleContractRequest.fromJson(String str) =>
      SingleContractRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleContractRequest.fromMap(Map<String, dynamic> json) =>
      SingleContractRequest(
        contactId: json["contactId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobile: json["mobile"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "contactId": contactId,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "email": email,
      };
}
