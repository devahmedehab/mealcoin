import 'package:dio/dio.dart';
import 'package:location/location.dart';

import 'package:chefsandmeals_customer/src/models/responses/filteredHubList.dart';
import 'package:chefsandmeals_customer/src/models/responses/nearestHubModel.dart';
import 'package:chefsandmeals_customer/src/modules/apiEndpoints.dart';

abstract class IHubRepository {
  Future<NearestHubsList> getNearestHubList();

  Future<FilteredHubList> getFilteredHubList(
      String filterName, String filterType);
}

class HubRepository implements IHubRepository {
  final Dio _dio = Dio();

  @override
  Future<FilteredHubList> getFilteredHubList(
      String filterName, String filterType) async {
    var options = Options();
    // options.headers!['accept'] = 'text/plain';
    options.contentType = 'application/json';
    String url = GET_FILTERED_HUB_LIST;
    Map<String, String> qParams = Map();
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

    if (response.statusCode == 200) {
      FilteredHubList filteredHubList = FilteredHubList.fromJson(response.data);
      print(filteredHubList.result?.length);
      return filteredHubList;
    }

    throw Exception("Api error");
  }

  @override
  Future<NearestHubsList> getNearestHubList() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    Location location = new Location();
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {}
    }
    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {}
    }

    _locationData = await location.getLocation();

    final options = Options();
    options.contentType = 'application/json';
    String url = GET_NEAREST_HUB_LIST;
    Map<String, String> qParams = {
      "Latitude": _locationData.latitude.toString(),
      "Longitude": _locationData.longitude.toString()
    };
    final response =
        await _dio.get(url, options: options, queryParameters: qParams);

    NearestHubsList nearestHubsList = NearestHubsList.fromJson(response.data);
    return nearestHubsList;
  }
}
