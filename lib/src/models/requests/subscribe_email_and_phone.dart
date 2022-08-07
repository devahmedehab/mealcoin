import 'dart:convert';

// To parse this JSON data, do
//
//     final subscribeEmailAndPhone = subscribeEmailAndPhoneFromMap(jsonString);

class SubscribeEmailAndPhone {
  SubscribeEmailAndPhone({
    this.contactId,
    this.email,
    this.isEmailSubscribed,
    this.phoneNumber,
    this.isPhoneNumberSubscribed,
  });

  int? contactId;
  String? email;
  bool? isEmailSubscribed;
  String? phoneNumber;
  bool? isPhoneNumberSubscribed;

  factory SubscribeEmailAndPhone.fromJson(String str) =>
      SubscribeEmailAndPhone.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubscribeEmailAndPhone.fromMap(Map<String, dynamic> json) =>
      SubscribeEmailAndPhone(
        contactId: json["contactId"],
        email: json["email"],
        isEmailSubscribed: json["isEmailSubscribed"],
        phoneNumber: json["phoneNumber"],
        isPhoneNumberSubscribed: json["isPhoneNumberSubscribed"],
      );

  Map<String, dynamic> toMap() => {
        "contactId": contactId,
        "email": email,
        "isEmailSubscribed": isEmailSubscribed,
        "phoneNumber": phoneNumber,
        "isPhoneNumberSubscribed": isPhoneNumberSubscribed,
      };
}
