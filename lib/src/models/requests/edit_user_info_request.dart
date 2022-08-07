import 'dart:convert';

// To parse this JSON data, do
//
//     final editUserInfoRequest = editUserInfoRequestFromMap(jsonString);

class EditUserInfoRequest {
  EditUserInfoRequest({
    this.userId,
    this.contactId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.zipCode,
    this.countryId,
    this.stateId,
    this.city,
    this.dateOfBirth,
    this.picture,
  });

  int? userId;
  int? contactId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? address;
  String? zipCode;
  int? countryId;
  int? stateId;
  String? city;
  String? dateOfBirth;
  String? picture;

  factory EditUserInfoRequest.fromJson(String str) =>
      EditUserInfoRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditUserInfoRequest.fromMap(Map<String, dynamic> json) =>
      EditUserInfoRequest(
        userId: json["userId"],
        contactId: json["contactId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        zipCode: json["zipCode"],
        countryId: json["countryId"],
        stateId: json["stateId"],
        city: json["city"],
        dateOfBirth: json["dateOfBirth"],
        picture: json["picture"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "contactId": contactId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "address": address,
        "zipCode": zipCode,
        "countryId": countryId,
        "stateId": stateId,
        "city": city,
        "dateOfBirth": dateOfBirth,
        "picture": picture,
      };
}
