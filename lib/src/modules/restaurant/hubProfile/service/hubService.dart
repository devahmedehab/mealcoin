import 'dart:core';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import 'package:chefsandmeals_customer/src/models/responses/index.dart';

import '../../../apiEndpoints.dart';

class HubSelectionService {
  static var _dio = new Dio();

  static Future<Position> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true);
      print("lat" + position.latitude.toString());
      print("long" + position.longitude.toString());
      return position;
    } catch (e) {
      print(e);
    }

    throw (e) {};
  }

  Future<NearestHubsList> getNearestHubList() async {
    Position position = await _getCurrentLocation();
    var options = new Options();
    options.headers!['accept'] = 'text/plain';
    options.contentType = 'application/json';
    String url = GET_NEAREST_HUB_LIST;
    Map<String, String> qParams = new Map();
    qParams['Latitude'] = position.latitude.toString();
    qParams['Longitude'] = position.longitude.toString();
    final response =
        await _dio.get(url, options: options, queryParameters: qParams);
    print(response);
    NearestHubsList nearestHubsList = NearestHubsList.fromJson(response.data);
    if (response.statusCode == 200) {
      return nearestHubsList;
    }
    return nearestHubsList;
  }

  Future<FilteredHubList> getFilteredHubList(
      String filterName, String filterType) async {
    var options = new Options();
    options.headers!['accept'] = 'text/plain';
    options.contentType = 'application/json';
    String url = GET_FILTERED_HUB_LIST;
    Map<String, String> qParams = new Map();
    if (filterType == "H") {
      qParams['hubFilter'] = filterName;
    } else if (filterType == "C") {
      qParams['cityFilter'] = filterName;
    } else if (filterType == "Z") {
      qParams['zipCodeFilter'] = filterName;
    } else {
      qParams['hubFilter'] = filterName;
    }

    final response =
        await _dio.get(url, options: options, queryParameters: qParams);
    FilteredHubList filteredHubList = FilteredHubList.fromJson(response.data);
    if (response.statusCode == 200) {
      print(filteredHubList.result!.length);
    }
    return filteredHubList;
  }
}
