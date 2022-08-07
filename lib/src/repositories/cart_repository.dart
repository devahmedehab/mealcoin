import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/requests/create_order_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/create_order_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/delvery_and_service_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_cart_item_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_delivery_type_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_payment_type_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_tax_rate_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/payment_sdk_details_response.dart';
import 'package:chefsandmeals_customer/src/modules/apiEndpoints.dart';

import 'local_user_info_repository.dart';

abstract class ICartRepository {
  Future<bool> addProductToCart(
      int productId, int storeId, int contactId, int quantity);

  Future<bool> updateCart(int cartId, int quantity);

  Future<bool> deleteCartItem(int cartId);

  Future<bool> clearCart(int contactId);

  Future<GetAllCartItemResponse> getAllItem(int contactId);

  Future<GetPaymentSdkDetailsResponse> getPaymentSdkDetails();

  Future<GetTaxRateResponse> getTaxRate(String zipCode, int stateId);

  Future<GetAllDeliveryTypeResponse> getAllDeliveryType(int storeId);

  Future<GetAllPaymentTypeResponse> getAllPaymentType();

  Future<DeliveryChargeAndServiceResponse> getDeliveryChargeAndServices(
      int storeId);

  Future<CreateOrderResponse> createOrder(CreateOrderRequest request);

  Future<bool> createOrderInSquare(
      String nonce, double totalAmount, int orderID);
}

class CartRepository implements ICartRepository {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final Dio _dio = Dio(BaseOptions(
    followRedirects: false,
    // will not throw errors
    validateStatus: (status) => true,
  ));

  @override
  Future<bool> addProductToCart(
      int productId, int storeId, int contactId, int quantity) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    var data = {
      "productId": productId,
      "storeId": storeId,
      "contactId": contactId,
      "quantity": quantity
    };
    final response = await _dio.post(ADD_PRODUCT_TO_CART, data: data);
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<bool> updateCart(int cartId, int quantity) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.put("$UPDATE_PRODUCT_TO_CART" +
        "?shoppingCartId=$cartId" +
        "&quantity=$quantity");
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<bool> deleteCartItem(int cartId) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response =
        await _dio.delete("$DELETE_CART_ITEM" + "?shoppingCartId=$cartId");
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<GetAllCartItemResponse> getAllItem(int contactId) async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response =
        await _dio.get("$GET_ALL_CART_ITEM" + "?contactId=$contactId");
    GetAllCartItemResponse getAllCartItemResponse =
        GetAllCartItemResponse.fromMap(response.data);
    return getAllCartItemResponse;
  }

  @override
  Future<GetPaymentSdkDetailsResponse> getPaymentSdkDetails() async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.get("$GET_PAYMENT_SDK_DETAILS");
    GetPaymentSdkDetailsResponse getPaymentSdkDetailsResponse =
        GetPaymentSdkDetailsResponse.fromMap(response.data);
    return getPaymentSdkDetailsResponse;
  }

  @override
  Future<GetTaxRateResponse> getTaxRate(String zipCode, int stateId) async {
    final response = await _dio
        .get("$GET_TAX_RATE" + "?zipCode=$zipCode" + "&stateId=$stateId");
    GetTaxRateResponse getTaxRateResponse =
        GetTaxRateResponse.fromMap(response.data);
    return getTaxRateResponse;
  }

  @override
  Future<GetAllDeliveryTypeResponse> getAllDeliveryType(int storeId) async {
    final response =
        await _dio.get("$GET_ALL_DELIVERY_TYPE" + "?storeId=$storeId");
    print("DATA : ${response.data}");
    GetAllDeliveryTypeResponse getAllDeliveryTypeResponse =
        GetAllDeliveryTypeResponse.fromMap(response.data);
    return getAllDeliveryTypeResponse;
  }

  @override
  Future<GetAllPaymentTypeResponse> getAllPaymentType() async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.get("$GET_ALL_PAYMENT_TYPE");
    GetAllPaymentTypeResponse getAllPaymentTypeResponse =
        GetAllPaymentTypeResponse.fromMap(response.data);
    return getAllPaymentTypeResponse;
  }

  @override
  Future<DeliveryChargeAndServiceResponse> getDeliveryChargeAndServices(
      int storeId) async {
    final response = await _dio
        .get("$GET_DELIVERY_CHARGE_AND_SERVICES" + "?storeId=$storeId");
    DeliveryChargeAndServiceResponse getDeliveryChargeAndServices =
        DeliveryChargeAndServiceResponse.fromMap(response.data);
    return getDeliveryChargeAndServices;
  }

  @override
  Future<CreateOrderResponse> createOrder(CreateOrderRequest request) async {
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    print("req : ${request.toMap()}");

    final response = await _dio.post("$CREATE_ORDER", data: request.toMap());
    print("res : ${response.data}");
    CreateOrderResponse createOrderResponse =
        CreateOrderResponse.fromMap(response.data);
    return createOrderResponse;
  }

  @override
  Future<bool> createOrderInSquare(
      String nonce, double totalAmount, int orderID) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";

    var data = {
      "nonceNumber": nonce,
      "totalAmount": totalAmount.abs(),
      "orderId": orderID
    };

    print("DDDD : ${data.toString()}");

    final response = await _dio.post(
      "$CREATE_ORDER_IN_SQUARE" +
          "?nonceNumber=$nonce" +
          "&totalAmount=${totalAmount.ceil()}" +
          "&orderId=$orderID",
    );
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  @override
  Future<bool> clearCart(int contactId) async {
    var result = false;
    final token = await _userInfoRepository.getToken();
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    final response = await _dio.delete("$CLEAR_CART" + "?contactId=$contactId");
    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }
}
