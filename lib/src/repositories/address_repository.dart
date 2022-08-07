import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/requests/create_new_address_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_address_response.dart';
import 'package:chefsandmeals_customer/src/modules/apiEndpoints.dart';

import 'local_user_info_repository.dart';

abstract class IAddressRepository {
  Future<bool> createNewAddress(
      CreateNewAddressRequest createNewAddressRequest);
  Future<GetAllAddressResponse> getAllAdressReponse(int contactId);
  Future<bool> deleteAddress(int conactID);
}

class AddressRepository implements IAddressRepository {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final Dio _dio = Dio(BaseOptions(
    followRedirects: false,
    // will not throw errors
    validateStatus: (status) => true,
  ));

  @override
  Future<bool> createNewAddress(
      CreateNewAddressRequest createNewAddressRequest) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.post(POST_ADD_NEW_ADDRESS,
        data: createNewAddressRequest.toJson());
    print(response.realUri);
    print(createNewAddressRequest.toJson());
    print(response.statusCode);
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<GetAllAddressResponse> getAllAdressReponse(int contactId) async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response =
        await _dio.get("$GET_ALL_ADDRESS" + "?contactId=$contactId");
    GetAllAddressResponse addressResponse =
        GetAllAddressResponse.fromMap(response.data);
    return addressResponse;
  }

  @override
  Future<bool> deleteAddress(int conactID) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.delete("$DELETE_ADDRESS" + "?id=$conactID");
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }
}
