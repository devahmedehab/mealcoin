import 'package:dio/dio.dart';

import 'package:chefsandmeals_customer/src/common/sharedPreference.dart';
import 'package:chefsandmeals_customer/src/common/strings.dart';
import 'package:chefsandmeals_customer/src/models/responses/popularRestaurantListModel.dart';

import '../../../apiEndpoints.dart';

class PopularRestaurantService {
  static var _dio = new Dio();
  SharedPref sharedPref = SharedPref();

  Future<PopularRestaurantListModel> getPopularRestaurantShortList() async {
    var options = new Options();
    options.headers!['accept'] = 'text/plain';
    options.contentType = 'application/json';
    String url = GET_POPULAR_RESTAURANT_SHORT_LIST_BY_HUB;
    Map<String, String> qParams = new Map();
    qParams['hubId'] =
        (await sharedPref.getUserAppData(SharedPrefStrings.hubId))!;
    final response =
        await _dio.get(url, options: options, queryParameters: qParams);
    print(response);
    PopularRestaurantListModel nearestHubsList =
        PopularRestaurantListModel.fromJson(response.data);
    if (response.statusCode == 200) {
      return nearestHubsList;
    }
    return nearestHubsList;
  }
}
