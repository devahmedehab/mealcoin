import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/requests/all_delivery_type_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_order_by_contact_response.dart';
import 'package:chefsandmeals_customer/src/modules/apiEndpoints.dart';

import 'local_user_info_repository.dart';

abstract class IOrder {
  Future<AllDeliveryTypeRequest> getAllDeliveryType(int storeID);
  Future<GetAllOrdersByContactResponse> getAllOrderByContact(
      int contactId, int skipCount, int maxResultCount);
}

class OrderRepository implements IOrder {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final Dio _dio = Dio(BaseOptions(
    followRedirects: false,
    // will not throw errors
    validateStatus: (status) => true,
  ));

  @override
  Future<AllDeliveryTypeRequest> getAllDeliveryType(int storeID) async {
/*
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";*/
    final response =
        await _dio.get("$GET_ALL_DELIVERY_TYPE" + "?storeId=$storeID");
    AllDeliveryTypeRequest allDeliveryTypeRequest =
        AllDeliveryTypeRequest.fromMap(response.data);
    return allDeliveryTypeRequest;
  }

  @override
  Future<GetAllOrdersByContactResponse> getAllOrderByContact(
      int contactId, int skipCount, int maxResultCount) async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.get("$GET_ORDER_BY_CONTACT" +
        "?ContactId=$contactId&SkipCount=$skipCount&MaxResultCount=$maxResultCount");
    GetAllOrdersByContactResponse allOrdersByContactResponse =
        GetAllOrdersByContactResponse.fromMap(response.data);
    print("Data Reson${response.toString()}");

    return allOrdersByContactResponse;
  }
}
