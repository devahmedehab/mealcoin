import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/responses/add_wishlist_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_wishlist_item_response.dart';
import 'package:chefsandmeals_customer/src/modules/apiEndpoints.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';

abstract class IWishListRepository {
  Future<GetAllWishListItem> getAllItem(
      int contactIdFilter, int SlipCount, int maxResultCount);

  Future<AddWishListResponse> addProductToWishList(
      int productId, int contactId);
  Future<bool> deleteWishListItem(int Id);
}

class WishListRepository implements IWishListRepository {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final Dio _dio = Dio(BaseOptions(
    followRedirects: false,
    validateStatus: (status) => true,
  ));

  @override
  Future<GetAllWishListItem> getAllItem(
      int contactIdFilter, int slipCount, int maxResultCount) async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    var data = {
      "ContactIdFilter": contactIdFilter,
      "SkipCount": slipCount,
      "MaxResultCount": maxResultCount,
    };
    final response =
        await _dio.get(GET_ALL_WISHLIST_ITEM, queryParameters: data);
    GetAllWishListItem getAllWishListItem =
        GetAllWishListItem.fromMap(response.data);
    return getAllWishListItem;
  }

  @override
  Future<AddWishListResponse> addProductToWishList(
      int productId, int contactId) async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.post("$ADD_PRODUCT_TO_WISHLIST" +
        "?productId=$productId" +
        "&contactId=$contactId");
    AddWishListResponse addWishListResponse =
        AddWishListResponse.fromMap(response.data);
    return addWishListResponse;
  }

  @override
  Future<bool> deleteWishListItem(int id) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.delete("$DELETE_WISHLIST_ITEM" + "?Id=$id");
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }
}
