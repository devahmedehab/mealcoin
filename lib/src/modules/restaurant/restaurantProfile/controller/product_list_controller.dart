import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/base_controller.dart';
import 'package:chefsandmeals_customer/src/models/requests/all_products_by_store_and_category.dart';
import 'package:chefsandmeals_customer/src/models/requests/update_product_recommendation_score_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/populor_store_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_category_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_response.dart';
import 'package:chefsandmeals_customer/src/repositories/single_store_repository.dart';

import '../../../../repositories/local_user_info_repository.dart';
import '../../../../repositories/recommendation_repository.dart';

class ProductListController extends BaseController {
  final SingleStoreRepository _singleStoreRepository =
      Get.put(SingleStoreRepository());

  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final IRecommendationRepository _recommendationRepository =
      Get.put(RecommendationRepository());

  final productList = <ProductResult>[].obs;

  final ProductCategoryResult category;
  final StoreResult store;

  ProductListController({required this.store, required this.category});

  final skipCount = 0.obs;
  final maxCount = 20.obs;

  @override
  void onInit() async {
    super.onInit();
    await getCategoryProducts();
  }

  getCategoryProducts() async {
    // try {
    setLoading(true);
    final response = await _singleStoreRepository
        .getAllProductsByStoreAndCategory(AllProductsByStoreAndCategoryRequest(
      storeId: store.id!,
      productCategoryId: category.id!,
      skipCount: skipCount.value,
      maxCount: maxCount.value,
    ));

    print("PL: ${response.length}");
    productList.assignAll(response);
    // } catch (e) {
    //   print(e);
    // } finally {
    setLoading(false);
    // }
  }

  Future<void> updateProductRecommendationScore(int productId) async {
    final contactId = await _userInfoRepository.getContactId();
    if (contactId > 0) {
      return await _recommendationRepository.updateProductRecommendationScore(
          UpdateProductRecommendationScoreRequest(
              productId: productId, contactId: contactId, isClicked: true));
    }
  }
}
