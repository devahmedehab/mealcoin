import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';

class SplashController extends GetxController {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  Future<int> getRout() async {
    return await _userInfoRepository.getRout();
  }
}
