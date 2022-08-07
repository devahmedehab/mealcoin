import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/requests/index.dart';
import 'package:chefsandmeals_customer/src/models/responses/index.dart';
import 'package:chefsandmeals_customer/src/repositories/user_management_repository.dart';

class SentResetPasswordCodeController extends GetxController {
  final UserManagementRepository _userManagementRepository =
      Get.put(UserManagementRepository());
  final email = "".obs;
  final phone = "".obs;

  Future<SendPasswordResetCodeByMobileResponse> sendCodeByPhone() async {
    return await _userManagementRepository
        .sendPasswordResetCodeByMobile(PhoneRequest(phone: phone.value));
  }

  Future<SendPasswordResetCodeByEmailResponse> sendCodeByEmail() async {
    return await _userManagementRepository
        .sendPasswordResetCodeByEmail(EmailRequest(email: email.value));
  }
}
