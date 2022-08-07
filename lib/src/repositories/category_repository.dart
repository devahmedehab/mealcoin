import 'package:dio/dio.dart';

import 'package:chefsandmeals_customer/src/models/responses/product_category_response.dart';
import 'package:chefsandmeals_customer/src/modules/apiEndpoints.dart';

abstract class IProductCategoryRepository {
  Future<ProductCategoryResponse> getTopProductCategory(int hubid);

  Future<ProductCategoryResponse> getAllProductCategory(
      int hubid, int skipCount);
}

class ProductCategoryRepository implements IProductCategoryRepository {
  final Dio _dio = Dio(BaseOptions(
    followRedirects: false,
    // will not throw errors
    validateStatus: (status) => true,
  ));

  @override
  Future<ProductCategoryResponse> getTopProductCategory(int hubid) async {
    final response = await _dio.get(
      "$GET_TOP_PRODUCT_CATEGORY" + "?hubid=$hubid",
    );
    ProductCategoryResponse productCategoryResponse =
        ProductCategoryResponse.fromMap(response.data);
    return productCategoryResponse;
  }

  @override
  Future<ProductCategoryResponse> getAllProductCategory(
      int hubid, int skipCount) async {
    final response = await _dio.get("$GET_ALL_PRODUCT_CATEGORY" +
        "?hubid=$hubid" +
        "&skipCount=$skipCount" +
        "&maxCount=20");
    ProductCategoryResponse productCategoryResponse =
        ProductCategoryResponse.fromMap(response.data);
    return productCategoryResponse;
  }
}
