import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/requests/add_single_contrct_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/all_contract_store_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/add_contact_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_sync_contact_response.dart';
import 'package:chefsandmeals_customer/src/modules/apiEndpoints.dart';

import 'local_user_info_repository.dart';

abstract class IContactRepository {
  Future<GetAllSyncContactResponse> getAllSyncContact(int contactId);
  Future<bool> refferalAllContract(int contactId);
  Future<bool> sendContractList(ContractRequest contractRequest);
  Future<bool> referSingleContract(int id, int referredByContactId);
  Future<AddContactResponse> addNewContract(
      SingleContractRequest singleContractRequest);
  Future<bool> deleteContract(int id);
}

class ContactRepository implements IContactRepository {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final Dio _dio = Dio(BaseOptions(
    followRedirects: false,
    // will not throw errors
    validateStatus: (status) => true,
  ));

  @override
  Future<GetAllSyncContactResponse> getAllSyncContact(int contactId) async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response =
        await _dio.get("$GET_ALL_SYNC_CONTACT" + "?contactId=$contactId");
    GetAllSyncContactResponse getAllSyncContactResponse =
        GetAllSyncContactResponse.fromMap(response.data);
    return getAllSyncContactResponse;
  }

  @override
  Future<bool> sendContractList(ContractRequest contractRequest) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response =
        await _dio.post(POST_ALL_CONTACT, data: contractRequest.toJson());
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<bool> refferalAllContract(int contactId) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response =
        await _dio.post("$POST_REFFERAL_ALL_CONTACT" + "?contactId=$contactId");
    print("STC : ${response.statusCode}");
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<bool> referSingleContract(int id, int referredByContactId) async {
    print("id ${id} reffid ${referredByContactId}");
    var result = false;
    final token = await _userInfoRepository.getToken();
    print(token);
    _dio.options.headers["Authorization"] = "Bearer ${token}";

    final response = await _dio.post("$POST_SINGLE_REFER" +
        "?id=$id" +
        "&referredByContactId=$referredByContactId");
    print("STC : ${response.statusCode}");
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<AddContactResponse> addNewContract(
      SingleContractRequest singleContractRequest) async {
    print(singleContractRequest.toJson());
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.post(POST_ADD_NEW_CONTACT,
        data: singleContractRequest.toJson());
    AddContactResponse addContactResponse =
        AddContactResponse.fromMap(response.data);
    return addContactResponse;
  }

  @override
  Future<bool> deleteContract(int id) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.delete("$DELETE__CONTACT" + "?id=$id");
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }
}
