import 'dart:convert';

// To parse this JSON data, do
//
//     final signUpRequest = signUpRequestFromMap(jsonString);

class SignUpRequest {
  SignUpRequest({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.password,
  });

  String firstName;
  String lastName;
  String emailAddress;
  String phoneNumber;
  String password;

  factory SignUpRequest.fromJson(String str) =>
      SignUpRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignUpRequest.fromMap(Map<String, dynamic> json) => SignUpRequest(
        firstName: json["firstName"],
        lastName: json["lastName"],
        emailAddress: json["emailAddress"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "emailAddress": emailAddress,
        "phoneNumber": phoneNumber,
        "password": password,
      };
}
