import 'dart:convert';

class ErrorResponse {
  ErrorResponse({
    this.code,
    this.message,
    this.details,
    this.validationErrors,
  });

  int? code;
  String? message;
  String? details;
  List<dynamic>? validationErrors;

  factory ErrorResponse.fromJson(String str) =>
      ErrorResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ErrorResponse.fromMap(Map<String, dynamic> json) => ErrorResponse(
        code: json["code"],
        message: json["message"],
        details: json["details"],
        validationErrors: json["validationErrors"] == null
            ? null
            : List<dynamic>.from(json["validationErrors"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
        "details": details,
        "validationErrors": validationErrors == null
            ? null
            : List<dynamic>.from(validationErrors!.map((x) => x)),
      };
}
