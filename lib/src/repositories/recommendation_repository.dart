import 'package:dio/dio.dart';

import 'package:chefsandmeals_customer/src/models/requests/update_hub_recommendation_score_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/update_product_recommendation_score_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/update_store_recommendation_score_request.dart';

import '../modules/apiEndpoints.dart';

abstract class IRecommendationRepository {
  Future<void> updateProductRecommendationScore(
      UpdateProductRecommendationScoreRequest request);

  Future<void> updateStoreRecommendationScore(
      UpdateStoreRecommendationScoreRequest request);

  Future<void> updateHubRecommendationScore(
      UpdateHubRecommendationScoreRequest request);
}

class RecommendationRepository implements IRecommendationRepository {
  final Dio _dio = Dio(BaseOptions(
    followRedirects: false,
    // will not throw errors
    validateStatus: (status) => true,
  ));

  @override
  Future<void> updateHubRecommendationScore(
      UpdateHubRecommendationScoreRequest request) async {
    await _dio.get(ApiEndPoints.customerRecommendations,
        queryParameters: request.toMap());
  }

  @override
  Future<void> updateProductRecommendationScore(
      UpdateProductRecommendationScoreRequest request) async {
    await _dio.post(ApiEndPoints.customerRecommendations,
        data: request.toMap());
  }

  @override
  Future<void> updateStoreRecommendationScore(
      UpdateStoreRecommendationScoreRequest request) async {
    await _dio.post(ApiEndPoints.customerRecommendations,
        data: request.toMap());
  }
}
