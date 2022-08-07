import 'dart:convert';

// To parse this JSON data, do
//
//     final createNewAddressRequest = createNewAddressRequestFromMap(jsonString);

class CreateNewAddressRequest {
  CreateNewAddressRequest({
    this.title,
    this.fullAddress,
    this.address,
    this.zipCode,
    this.latitude,
    this.longitude,
    this.isActive,
    this.city,
    this.noteForDelivery,
    this.stateId,
    this.countryId,
    this.contactId,
    this.id,
  });

  String? title;
  String? fullAddress;
  String? address;
  String? zipCode;
  int? latitude;
  int? longitude;
  bool? isActive;
  String? city;
  String? noteForDelivery;
  int? stateId;
  int? countryId;
  int? contactId;
  int? id;

  factory CreateNewAddressRequest.fromJson(String str) =>
      CreateNewAddressRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateNewAddressRequest.fromMap(Map<String, dynamic> json) =>
      CreateNewAddressRequest(
        title: json["title"],
        fullAddress: json["fullAddress"],
        address: json["address"],
        zipCode: json["zipCode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isActive: json["isActive"],
        city: json["city"],
        noteForDelivery: json["noteForDelivery"],
        stateId: json["stateId"],
        countryId: json["countryId"],
        contactId: json["contactId"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "fullAddress": fullAddress,
        "address": address,
        "zipCode": zipCode,
        "latitude": latitude,
        "longitude": longitude,
        "isActive": isActive,
        "city": city,
        "noteForDelivery": noteForDelivery,
        "stateId": stateId,
        "countryId": countryId,
        "contactId": contactId,
        "id": id,
      };
}
