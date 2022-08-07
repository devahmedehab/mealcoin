import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/repositories/hub_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/recommendation_repository.dart';

import '../../../../models/requests/update_hub_recommendation_score_request.dart';
import '../../../../models/responses/index.dart';

class OnBoardingController extends GetxController {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final IRecommendationRepository _recommendationRepository =
      Get.put(RecommendationRepository());

  final IHubRepository _hubRepository = Get.put(HubRepository());

  final nearestHubs = <NearestHubs>[].obs;

  Future<void> updateHubRecommendationScore(int hubId) async {
    final token = await _userInfoRepository.getToken();

    if (token == null) {
      return;
    }

    final contactId = await _userInfoRepository.getContactId();
    return await _recommendationRepository.updateHubRecommendationScore(
        UpdateHubRecommendationScoreRequest(
            hubId: hubId, contactId: contactId));
  }

  setRout(int rout) async {
    await _userInfoRepository.setRout(rout);
  }

  getNearestHubs() async {
    final response = await _hubRepository.getNearestHubList();

    nearestHubs.assignAll(response.result!.nearestHubs!);
  }

  @override
  void onInit() async {
    super.onInit();

    await getNearestHubs();
  }
}
