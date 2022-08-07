import 'package:dio/dio.dart';

import 'package:chefsandmeals_customer/src/models/requests/all_categories_by_store_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/all_products_by_store_and_category.dart';
import 'package:chefsandmeals_customer/src/models/requests/get_product_medias_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/get_product_reviews_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/top_categories_by_store_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/top_products_by_store_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_product_medias_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_product_reviews_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_category_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_response.dart';
import 'package:chefsandmeals_customer/src/modules/apiEndpoints.dart';

abstract class ISingleStoreRepository {
  Future<List<ProductCategoryResult>> getTopCategoriesByStore(
      TopCategoriesByStoreRequest request);

  Future<List<ProductCategoryResult>> getAllCategoriesByStore(
      AllCategoriesByStoreRequest request);

  Future<List<ProductResult>> getTopProductsByStore(
      TopProductsByStoreRequest request);

  Future<List<ProductResult>> getAllProductsByStoreAndCategory(
      AllProductsByStoreAndCategoryRequest request);

  Future<GetProductMediasResponse> getAllProductMediasByProductId(
      GetProductMediasRequest request);

  Future<GetProductReviewsResponse> getProductReviews(
      GetProductReviewsRequest request);
}

class SingleStoreRepository implements ISingleStoreRepository {
  final Dio _dio = Dio(BaseOptions(
    followRedirects: false,
    // will not throw errors
    validateStatus: (status) => true,
  ));

  @override
  Future<List<ProductCategoryResult>> getAllCategoriesByStore(
      AllCategoriesByStoreRequest request) async {
    final response = await _dio.get(ApiEndPoints.allCategoriesByStore,
        queryParameters: request.toMap());

    return ProductCategoryResponse.fromMap(response.data).result!;
  }

  @override
  Future<List<ProductResult>> getAllProductsByStoreAndCategory(
      AllProductsByStoreAndCategoryRequest request) async {
    final response = await _dio.get(ApiEndPoints.allProductsByStoreAndCategory,
        queryParameters: request.toMap());

    return ProductResponse.fromMap(response.data).result!;
  }

  @override
  Future<List<ProductCategoryResult>> getTopCategoriesByStore(
      TopCategoriesByStoreRequest request) async {
    final response = await _dio.get(ApiEndPoints.topCategoriesByStore,
        queryParameters: request.toMap());

    return ProductCategoryResponse.fromMap(response.data).result!;
  }

  @override
  Future<List<ProductResult>> getTopProductsByStore(
      TopProductsByStoreRequest request) async {
    final response = await _dio.get(ApiEndPoints.topProductsByStore,
        queryParameters: request.toMap());

    return ProductResponse.fromMap(response.data).result!;
  }

  @override
  Future<GetProductMediasResponse> getAllProductMediasByProductId(
      GetProductMediasRequest request) async {
    final response = await _dio.get(ApiEndPoints.allProductMediasByProductId,
        queryParameters: request.toMap());

    return GetProductMediasResponse.fromMap(response.data);
  }

  @override
  Future<GetProductReviewsResponse> getProductReviews(
      GetProductReviewsRequest request) async {
    final response = await _dio.get(ApiEndPoints.getProductReviews,
        queryParameters: request.toMap());

    return GetProductReviewsResponse.fromMap(response.data);
  }
}
