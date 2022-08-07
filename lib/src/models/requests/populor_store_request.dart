import 'dart:convert';

// To parse this JSON data, do
//
//     final populorStoreRequest = populorStoreRequestFromMap(jsonString);

class PopulorStoreRequest {
  PopulorStoreRequest({
    required this.hubid,
  });

  int hubid;

  factory PopulorStoreRequest.fromJson(String str) =>
      PopulorStoreRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PopulorStoreRequest.fromMap(Map<String, dynamic> json) =>
      PopulorStoreRequest(
        hubid: json["hubid"],
      );

  Map<String, dynamic> toMap() => {
        "hubid": hubid,
      };
}
