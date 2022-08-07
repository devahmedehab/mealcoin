import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:chefsandmeals_customer/src/models/responses/user_info_for_edit.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/user_management_repository.dart';

class MyProfileController extends GetxController {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());
  final UserManagementRepository _userManagementRepository =
      Get.put(UserManagementRepository());

  final userToken = ''.obs;
  final userId = 0.obs;
  final user = EditUserInfo().obs;

  getToken() async {
    final token = await _userInfoRepository.getToken();
    if (token != null) {
      userToken.value = token;
    }
  }

  getUserId() async {
    final userid = await _userInfoRepository.getId();
    userId.value = userid;
  }

  getCurrentUserInfo() async {
    final result =
        await _userManagementRepository.getUserInfoForEdit(userId.value);
    if (result.success) {
      user.value = result.result!;
    }
  }

  logOut() async {
    await _userInfoRepository.clearUserInfo();
    GoogleSignIn _googleSignIn = GoogleSignIn();
    var _facebookAuth = await FacebookAuth.instance;
    _googleSignIn.signOut();
    _facebookAuth.logOut();
  }

  @override
  void onInit() async {
    await getToken();
    await getUserId();
    await getCurrentUserInfo();
    super.onInit();
  }
}
