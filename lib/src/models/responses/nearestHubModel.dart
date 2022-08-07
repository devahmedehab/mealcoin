class NearestHubsList {
  NearestHubsListResult? result;
  var targetUrl;
  bool? success;
  var error;
  bool? unAuthorizedRequest;
  bool? bAbp;

  NearestHubsList(
      {this.result,
      this.targetUrl,
      this.success,
      this.error,
      this.unAuthorizedRequest,
      this.bAbp});

  NearestHubsList.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null
        ? new NearestHubsListResult.fromJson(json['result'])
        : null;
    targetUrl = json['targetUrl'];
    success = json['success'];
    error = json['error'];
    unAuthorizedRequest = json['unAuthorizedRequest'];
    bAbp = json['__abp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result?.toJson();
    }
    data['targetUrl'] = this.targetUrl;
    data['success'] = this.success;
    data['error'] = this.error;
    data['unAuthorizedRequest'] = this.unAuthorizedRequest;
    data['__abp'] = this.bAbp;
    return data;
  }
}

class NearestHubsListResult {
  List<NearestHubs>? nearestHubs;

  NearestHubsListResult({this.nearestHubs});

  NearestHubsListResult.fromJson(Map<String, dynamic> json) {
    if (json['nearestHubs'] != null) {
      nearestHubs = <NearestHubs>[];
      json['nearestHubs'].forEach((v) {
        nearestHubs?.add(new NearestHubs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nearestHubs != null) {
      data['nearestHubs'] = this.nearestHubs?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearestHubs {
  int? id;
  String? name;
  String? url;
  double? latitude;
  double? longitude;
  var distance;
  String? pictureId;
  String? picture;

  NearestHubs(
      {this.id,
      this.name,
      this.url,
      this.latitude,
      this.longitude,
      this.distance,
      this.pictureId,
      this.picture});

  NearestHubs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
    pictureId = json['pictureId'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['distance'] = this.distance;
    data['pictureId'] = this.pictureId;
    data['picture'] = this.picture;
    return data;
  }
}
