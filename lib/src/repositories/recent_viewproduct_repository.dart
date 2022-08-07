import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/responses/recent_view_product_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/recent_view_store_response.dart';
import 'package:chefsandmeals_customer/src/modules/apiEndpoints.dart';

import 'local_user_info_repository.dart';

abstract class IRecentProductView {
  Future<RecentViewedProductResponse> getRecentViewProduct(int contractID);
  Future<RecentViewedStoreResponse> getRecentViewStore(int contractID);
}

class RecentViewRepository implements IRecentProductView {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final Dio _dio = Dio(BaseOptions(
    followRedirects: false,
    // will not throw errors
    validateStatus: (status) => true,
  ));

  @override
  Future<RecentViewedProductResponse> getRecentViewProduct(
      int contractID) async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response =
        await _dio.post("$GET_RECENT_VIEW_PRODUCT" + "?contactId=$contractID");

    RecentViewedProductResponse recentViewedResponse =
        RecentViewedProductResponse.fromMap(response.data);
    print(recentViewedResponse);

    return recentViewedResponse;
  }

  @override
  Future<RecentViewedStoreResponse> getRecentViewStore(int contractID) async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response =
        await _dio.post("$GET_RECENT_VIEW_STORE" + "?contactId=$contractID");
    print("Store Visit Data:${response.toString()}");
    RecentViewedStoreResponse recentViewedStoreResponse =
        RecentViewedStoreResponse.fromMap(response.data);
    return recentViewedStoreResponse;
  }
}
