import 'error.dart';

class PopularRestaurantListModel {
  List<PopularRHubResult>? result;
  String? targetUrl;
  bool? success;
  ErrorResponse? error;
  bool? unAuthorizedRequest;
  bool? bAbp;

  PopularRestaurantListModel(
      {this.result,
      this.targetUrl,
      this.success,
      this.error,
      this.unAuthorizedRequest,
      this.bAbp});

  PopularRestaurantListModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <PopularRHubResult>[];
      json['result'].forEach((v) {
        result!.add(new PopularRHubResult.fromJson(v));
      });
    }
    targetUrl = json['targetUrl'];
    success = json['success'];
    error = json['error'] == null ? null : ErrorResponse.fromMap(json["error"]);
    unAuthorizedRequest = json['unAuthorizedRequest'];
    bAbp = json['__abp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['targetUrl'] = this.targetUrl;
    data['success'] = this.success;
    data['error'] = this.error;
    data['unAuthorizedRequest'] = this.unAuthorizedRequest;
    data['__abp'] = this.bAbp;
    return data;
  }
}

class PopularRHubResult {
  int? id;
  String? name;
  String? logoId;
  String? logoUrl;

  PopularRHubResult({this.id, this.name, this.logoId, this.logoUrl});

  PopularRHubResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logoId = json['logoId'];
    logoUrl = json['logoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logoId'] = this.logoId;
    data['logoUrl'] = this.logoUrl;
    return data;
  }
}
