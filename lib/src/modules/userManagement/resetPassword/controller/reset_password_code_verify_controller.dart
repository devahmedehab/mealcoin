import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/requests/index.dart';
import 'package:chefsandmeals_customer/src/models/requests/verify_Email_otp_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/index.dart';
import 'package:chefsandmeals_customer/src/repositories/user_management_repository.dart';

class VerifyResetPassCodeController extends GetxController {
  final UserManagementRepository _userManagementRepository =
      Get.put(UserManagementRepository());

  Future<VerifyPasswordResetCodeByMobileResponse> verifyCodeByMobile(
      VerifyPhoneOtpRequest request) async {
    return await _userManagementRepository
        .verifyPasswordResetCodeByMobile(request);
  }

  Future<VerifyPasswordResetCodeByEmailResponse> verifyCodeByEmail(
      VerifyEmailOtpRequest request) async {
    return await _userManagementRepository
        .verifyPasswordResetCodeByEmail(request);
  }

  Future<SendPasswordResetCodeByMobileResponse> reSendCodeByPhone(
      PhoneRequest request) async {
    return await _userManagementRepository
        .sendPasswordResetCodeByMobile(request);
  }

  Future<SendPasswordResetCodeByEmailResponse> reSendCodeByEmail(
      EmailRequest request) async {
    return await _userManagementRepository
        .sendPasswordResetCodeByEmail(request);
  }
}
