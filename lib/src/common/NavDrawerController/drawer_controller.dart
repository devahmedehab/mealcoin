import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/user_management_repository.dart';

class CustomDrawerController extends GetxController {
  final UserManagementRepository _userManagementRepository =
      Get.put(UserManagementRepository());

  final LocalUserInfoRepository _localUserInfoRepository =
      Get.put(LocalUserInfoRepository());

  Future<void> logout() async {
    await _userManagementRepository.logOut().then((value) {
      _localUserInfoRepository.clearUserInfo();
    });
  }
}
