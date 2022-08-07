class FilteredHubList {
  List<FilteredHubListResult>? result;
  var targetUrl;
  bool? success;
  var error;
  bool? unAuthorizedRequest;
  bool? bAbp;

  FilteredHubList(
      {this.result,
      this.targetUrl,
      this.success,
      this.error,
      this.unAuthorizedRequest,
      this.bAbp});

  FilteredHubList.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <FilteredHubListResult>[];
      json['result'].forEach((v) {
        result?.add(new FilteredHubListResult.fromJson(v));
      });
    }
    targetUrl = json['targetUrl'];
    success = json['success'];
    error = json['error'];
    unAuthorizedRequest = json['unAuthorizedRequest'];
    bAbp = json['__abp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result?.map((v) => v.toJson()).toList();
    }
    data['targetUrl'] = this.targetUrl;
    data['success'] = this.success;
    data['error'] = this.error;
    data['unAuthorizedRequest'] = this.unAuthorizedRequest;
    data['__abp'] = this.bAbp;
    return data;
  }
}

class FilteredHubListResult {
  int? id;
  String? displayName;
  String? picture;
  String? pictureId;
  String? url;

  FilteredHubListResult(
      {this.id, this.displayName, this.picture, this.pictureId, this.url});

  FilteredHubListResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    picture = json['picture'];
    pictureId = json['pictureId'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['picture'] = this.picture;
    data['pictureId'] = this.pictureId;
    data['url'] = this.url;
    return data;
  }
}
