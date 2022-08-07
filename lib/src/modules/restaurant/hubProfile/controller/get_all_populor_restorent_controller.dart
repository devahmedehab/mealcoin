import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/sharedPreference.dart';
import 'package:chefsandmeals_customer/src/common/strings.dart';
import 'package:chefsandmeals_customer/src/models/requests/populor_store_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/update_store_recommendation_score_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/populor_store_response.dart';
import 'package:chefsandmeals_customer/src/repositories/store_repository.dart';

import '../../../../repositories/local_user_info_repository.dart';
import '../../../../repositories/recommendation_repository.dart';

class GetAllRestorentController extends GetxController {
  final _storeRepository = Get.put(StoreRepository());
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final IRecommendationRepository _recommendationRepository =
      Get.put(RecommendationRepository());

  final store = Rxn<PopularStoreResponse>().obs;
  final populorStore = <StoreResult>[].obs;
  SharedPref pref = SharedPref();
  final hubid = 0.obs;
  final skip = 0.obs;
  final isLoading = true.obs;

  getAllPopulorRestorent() async {
    pref.getUserAppData(SharedPrefStrings.hubId).then((value) async {
      hubid.value = int.parse(value!);
      PopularStoreResponse result =
          await _storeRepository.getAllPopularStore(hubid.value, skip.value);
      populorStore.addAll(result.result!);
      Future.delayed(Duration(seconds: 2), () {
        isLoading.value = false;
      });
    });
  }

  @override
  void onInit() async {
    await getAllPopulorRestorent();
    super.onInit();
  }

  Future<void> updateStoreRecommendationScore(int storeId) async {
    final contactId = await _userInfoRepository.getContactId();
    if (contactId > 0) {
      return await _recommendationRepository.updateStoreRecommendationScore(
          UpdateStoreRecommendationScoreRequest(
              storeId: storeId, contactId: contactId, isClicked: true));
    }
  }
}
