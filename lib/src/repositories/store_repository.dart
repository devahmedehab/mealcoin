import 'package:dio/dio.dart';

import 'package:chefsandmeals_customer/src/models/requests/populor_store_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/populor_store_response.dart';
import 'package:chefsandmeals_customer/src/modules/apiEndpoints.dart';

abstract class IStoreRepository {
  Future<PopularStoreResponse> getPopularStore(PopulorStoreRequest request);

  Future<PopularStoreResponse> getAllPopularStore(int hubid, int skipCount);
}

class StoreRepository implements IStoreRepository {
  final Dio _dio = Dio(BaseOptions(
    followRedirects: false,
    // will not throw errors
    validateStatus: (status) => true,
  ));

  @override
  Future<PopularStoreResponse> getPopularStore(
      PopulorStoreRequest request) async {
    Map<String, String> qParams = {
      "hubid": request.hubid.toString(),
    };
    final response =
        await _dio.get(GET_POPULOR_STORE, queryParameters: qParams);
    PopularStoreResponse popularStoreResponse =
        PopularStoreResponse.fromMap(response.data);
    return popularStoreResponse;
  }

  @override
  Future<PopularStoreResponse> getAllPopularStore(
      int hubid, int skipCount) async {
    final response = await _dio.get("$GET_ALL_POPULOR_STORE" +
        "?hubid=$hubid" +
        "&skipCount=$skipCount" +
        "&maxCount=20");
    print(response.data);
    PopularStoreResponse popularStoreResponse =
        PopularStoreResponse.fromMap(response.data);
    return popularStoreResponse;
  }
}
