import 'package:dio/dio.dart';

import 'package:chefsandmeals_customer/src/models/responses/product_response.dart';
import 'package:chefsandmeals_customer/src/modules/apiEndpoints.dart';

abstract class IProductRepository {
  Future<ProductResponse> getTrendingProduct(int hubId);
  Future<ProductResponse> getProductByCategoryAndHub(
      {required int hubId, required int cat, required int skip});
}

class ProductRepository implements IProductRepository {
  final Dio _dio = Dio(BaseOptions(
    followRedirects: false,
    // will not throw errors
    validateStatus: (status) => true,
  ));

  @override
  Future<ProductResponse> getTrendingProduct(int hubId) async {
    Map<String, String> qParams = {
      "hubId": hubId.toString(),
    };
    final response =
        await _dio.get(GET_TRENDING_PRODUCT, queryParameters: qParams);
    ProductResponse productResponse = ProductResponse.fromMap(response.data);
    return productResponse;
  }

  @override
  Future<ProductResponse> getProductByCategoryAndHub(
      {required int hubId, required int cat, required int skip}) async {
    Map<String, String> qParams = {
      "hubId": hubId.toString(),
      "productCategoryId": cat.toString(),
      "skipCountCount": skip.toString(),
      "maxCount": "20"
    };
    final response = await _dio.get(GET_PRODUCT_BY_CATEGORY_AND_HUB,
        queryParameters: qParams);
    ProductResponse productResponse = ProductResponse.fromMap(response.data);
    return productResponse;
  }
}
