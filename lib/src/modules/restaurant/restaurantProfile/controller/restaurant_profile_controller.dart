import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/base_controller.dart';
import 'package:chefsandmeals_customer/src/common/sharedPreference.dart';
import 'package:chefsandmeals_customer/src/models/requests/top_categories_by_store_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/top_products_by_store_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/populor_store_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_response.dart';
import 'package:chefsandmeals_customer/src/repositories/single_store_repository.dart';

import '../../../../common/strings.dart';
import '../../../../models/requests/update_product_recommendation_score_request.dart';
import '../../../../models/responses/product_category_response.dart';
import '../../../../repositories/local_user_info_repository.dart';
import '../../../../repositories/recommendation_repository.dart';

class RestaurantProfileController extends BaseController {
  final SharedPref sharedPref = Get.put(SharedPref());
  final SingleStoreRepository _singleStoreRepository =
      Get.put(SingleStoreRepository());

  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final IRecommendationRepository _recommendationRepository =
      Get.put(RecommendationRepository());

  final hubId = 0.obs;
  final restaurant = Rxn<StoreResult>();

  final topCategories = <ProductCategoryResult>[].obs;
  final topProducts = <ProductResult>[].obs;

  @override
  void onInit() async {
    super.onInit();

    hubId.value = int.parse(
        await sharedPref.getUserAppData(SharedPrefStrings.hubId) ?? "0");
    _getArgs();
    await getTopCategories();
    await getTopProducts();
  }

  void _getArgs() {
    if (Get.arguments != null) {
      restaurant.value = Get.arguments["restaurant"];
    }
  }

  getTopCategories() async {
    // try {
    setLoading(true);
    final response = await _singleStoreRepository.getTopCategoriesByStore(
        TopCategoriesByStoreRequest(storeId: restaurant.value!.id!));
    print("TCL: ${response.length}");
    topCategories.assignAll(response);
    // } catch (e) {
    //   print(e);
    // } finally {
    setLoading(false);
    // }
  }

  getTopProducts() async {
    // try {
    setLoading(true);
    final response = await _singleStoreRepository.getTopProductsByStore(
        TopProductsByStoreRequest(storeId: restaurant.value!.id!));
    print("TPL: ${response.length}");
    topProducts.assignAll(response);
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
