import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';

class ProfileDeciderController extends GetxController {
  final localUserinfoRepository = Get.put(LocalUserInfoRepository());
  final token = 0.obs;
  final isLoading = true.obs;

  getUserCred() async {
    final result = await localUserinfoRepository.getId();
    isLoading.value = false;
    if (result > 0) {
      token.value = result;
    }
  }

  @override
  void onInit() {
    getUserCred();
    super.onInit();
  }
}
