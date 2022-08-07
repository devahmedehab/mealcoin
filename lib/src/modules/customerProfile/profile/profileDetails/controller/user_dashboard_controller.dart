import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:chefsandmeals_customer/src/models/requests/subscribe_email_and_phone.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_category_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/user_email_and_phone_verification_status.dart';
import 'package:chefsandmeals_customer/src/models/responses/user_info_response.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/snack_pass_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/user_management_repository.dart';

class UserDashBoardController extends GetxController {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());
  final UserManagementRepository _userManagementRepository =
      Get.put(UserManagementRepository());

  final ISnackPassRepository _snackPassRepository =
      Get.put(SnackPassRepository());

  final userToken = ''.obs;
  final userId = 0.obs;
  final user = UserInfoResult().obs;
  final emailAndPhoneStatus = VerificationResult().obs;
  final phoneVerified = false.obs;
  final emailVerified = false.obs;
  final contactId = 0.obs;
  final snackPass = Rxn<ProductCategoryResult>();

  getToken() async {
    final token = await _userInfoRepository.getToken();
    if (token != null) {
      userToken.value = token;
    }
  }

  getUserId() async {
    final userid = await _userInfoRepository.getId();
    userId.value = userid;
    print("UUID : ${userId.value}");
  }

  getCurrentUserInfo() async {
    final result =
        await _userManagementRepository.getCurrentUserInfo(userId.value);
    print("USER: ${result.result!.userId}");
    if (result.success) {
      if (result.result!.userId != null) {
        user.value = result.result!;
      }
    }
  }

  logOut() async {
    await _userManagementRepository.logOut();
    await _userInfoRepository.setContactId(0);
    await _userInfoRepository.setId(0);
    GoogleSignIn _googleSignIn = GoogleSignIn();
    var _facebookAuth = await FacebookAuth.instance;
    _googleSignIn.signOut();
    _facebookAuth.logOut();
  }

  getEmailAndPhoneStatus() async {
    final response = await _userManagementRepository
        .userEmailAndPhoneVerificationStatus(userId.value);
    emailAndPhoneStatus.value = response.result!;
    phoneVerified.value = emailAndPhoneStatus.value.subscribetToSms!;
    emailVerified.value = emailAndPhoneStatus.value.subscribetToEmail!;
  }

  getContactId() async {
    final c_Id = await _userInfoRepository.getContactId();
    contactId.value = c_Id;
  }

  subscribe(SubscribeEmailAndPhone subscribeEmailAndPhone) async {
    final response = await _userManagementRepository
        .subscribeEmailAndPhone(subscribeEmailAndPhone);
    if (response) {
      await getEmailAndPhoneStatus();
    }
  }

  Future<void> getSnackPass() async {
    snackPass.value = await _snackPassRepository.getSnackPass();
  }

  @override
  void onInit() async {
    await getToken();
    await getUserId();
    await getContactId();
    await getCurrentUserInfo();
    await getEmailAndPhoneStatus();
    await getSnackPass();
    super.onInit();
  }
}
