import 'dart:convert';

// To parse this JSON data, do
//
//     final contractRequest = contractRequestFromMap(jsonString);

class ContractRequest {
  ContractRequest({
    required this.syncedByContactId,
    this.contacts,
  });

  int syncedByContactId;
  List<SingleContact>? contacts;

  factory ContractRequest.fromJson(String str) =>
      ContractRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContractRequest.fromMap(Map<String, dynamic> json) => ContractRequest(
        syncedByContactId: json["syncedByContactId"],
        contacts: List<SingleContact>.from(
            json["contacts"].map((x) => SingleContact.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "syncedByContactId": syncedByContactId,
        "contacts": List<dynamic>.from(contacts!.map((x) => x.toMap())),
      };
}

class SingleContact {
  SingleContact({
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
  });

  String? firstName;
  String? lastName;
  String? mobile;
  String? email;

  factory SingleContact.fromJson(String str) =>
      SingleContact.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleContact.fromMap(Map<String, dynamic> json) => SingleContact(
        firstName: json["firstName"] ?? null,
        lastName: json["lastName"] ?? null,
        mobile: json["mobile"] ?? null,
        email: json["email"] ?? null,
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "email": email,
      };
}
