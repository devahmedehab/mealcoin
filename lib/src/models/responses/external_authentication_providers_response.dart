import 'dart:convert';

import 'error.dart';

// To parse this JSON data, do
//
//     final externalAuthenticateProvidersResponse = externalAuthenticateProvidersResponseFromMap(jsonString);

class ExternalAuthenticateProvidersResponse {
  ExternalAuthenticateProvidersResponse({
    required this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  List<ExternalAuthResult> result;
  String? targetUrl;
  bool success;
  ErrorResponse? error;
  bool unAuthorizedRequest;
  bool abp;

  factory ExternalAuthenticateProvidersResponse.fromJson(String str) =>
      ExternalAuthenticateProvidersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExternalAuthenticateProvidersResponse.fromMap(
          Map<String, dynamic> json) =>
      ExternalAuthenticateProvidersResponse(
        result: List<ExternalAuthResult>.from(
            json["result"].map((x) => ExternalAuthResult.fromMap(x))),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
        "targetUrl": targetUrl,
        "success": success,
        "error": error!.toMap(),
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class ExternalAuthResult {
  ExternalAuthResult({
    required this.name,
    required this.clientId,
    this.additionalParams,
  });

  String name;
  String clientId;
  AdditionalParams? additionalParams;

  factory ExternalAuthResult.fromJson(String str) =>
      ExternalAuthResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExternalAuthResult.fromMap(Map<String, dynamic> json) =>
      ExternalAuthResult(
        name: json["name"],
        clientId: json["clientId"],
        additionalParams: AdditionalParams.fromMap(json["additionalParams"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "clientId": clientId,
        "additionalParams": additionalParams!.toMap(),
      };
}

class AdditionalParams {
  AdditionalParams({
    this.userInfoEndpoint,
  });

  String? userInfoEndpoint;

  factory AdditionalParams.fromJson(String str) =>
      AdditionalParams.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdditionalParams.fromMap(Map<String, dynamic> json) =>
      AdditionalParams(
        userInfoEndpoint:
            json["UserInfoEndpoint"] == null ? null : json["UserInfoEndpoint"],
      );

  Map<String, dynamic> toMap() => {
        "UserInfoEndpoint": userInfoEndpoint == null ? null : userInfoEndpoint,
      };
}
