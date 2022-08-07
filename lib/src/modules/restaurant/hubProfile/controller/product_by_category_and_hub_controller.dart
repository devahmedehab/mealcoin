import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/sharedPreference.dart';
import 'package:chefsandmeals_customer/src/common/strings.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_category_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_response.dart';
import 'package:chefsandmeals_customer/src/repositories/product_repository.dart';

import '../../../../models/requests/update_product_recommendation_score_request.dart';
import '../../../../repositories/local_user_info_repository.dart';
import '../../../../repositories/recommendation_repository.dart';

class ProductByCategoryAndHub extends GetxController {
  final _storeRepository = Get.put(ProductRepository());

  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final IRecommendationRepository _recommendationRepository =
      Get.put(RecommendationRepository());

  SharedPref pref = SharedPref();
  final productList = <ProductResult>[].obs;
  final category = ProductCategoryResult().obs;
  final hubid = 0.obs;
  final skip = 0.obs;
  final isLoading = true.obs;

  getAllProductByCatAndHub() async {
    pref.getUserAppData(SharedPrefStrings.hubId).then((value) async {
      hubid.value = int.parse(value!);
      ProductResponse result =
          await _storeRepository.getProductByCategoryAndHub(
              hubId: hubid.value, cat: category.value.id!, skip: skip.value);
      productList.assignAll(result.result!);
      Future.delayed(Duration(seconds: 1), () {
        isLoading.value = false;
      });
    });
  }

  @override
  void onInit() async {
    getArgument();
    await getAllProductByCatAndHub();
    super.onInit();
  }

  getArgument() {
    category.value = Get.arguments["cat"];
  }

  Future<void> updateProductRecommendationScore(int productId) async {
    final token = await _userInfoRepository.getToken();

    if (token == null) {
      return;
    }

    final contactId = await _userInfoRepository.getContactId();
    return await _recommendationRepository.updateProductRecommendationScore(
        UpdateProductRecommendationScoreRequest(
            productId: productId, contactId: contactId));
  }
}
