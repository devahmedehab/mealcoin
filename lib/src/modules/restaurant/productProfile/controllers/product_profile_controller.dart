import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/base_controller.dart';
import 'package:chefsandmeals_customer/src/models/requests/get_product_medias_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/get_product_reviews_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_product_medias_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_product_reviews_response.dart';
import 'package:chefsandmeals_customer/src/repositories/single_store_repository.dart';

class ProductProfileController extends BaseController {
  final ISingleStoreRepository _singleStoreRepository =
      Get.put(SingleStoreRepository());

  Future<GetProductMediasResponse> getProductMedias(
      GetProductMediasRequest request) async {
    setLoading(true);
    final result =
        await _singleStoreRepository.getAllProductMediasByProductId(request);
    setLoading(false);
    return result;
  }

  Future<GetProductReviewsResponse> getProductReviews(
      GetProductReviewsRequest request) async {
    setLoading(true);
    print(" request: ${request}");
    final result = await _singleStoreRepository.getProductReviews(request);

    setLoading(false);
    return result;
  }
}
