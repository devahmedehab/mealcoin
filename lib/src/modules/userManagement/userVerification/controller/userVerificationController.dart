import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/requests/index.dart';
import 'package:chefsandmeals_customer/src/models/responses/index.dart';
import 'package:chefsandmeals_customer/src/models/responses/verify_signup_otp_response.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/user_management_repository.dart';

class VerificationController extends GetxController {
  final UserManagementRepository _userManagementRepository =
      Get.put(UserManagementRepository());
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());
  final code = "".obs;

  Future<VerifySignUpOtpResponse> verifyOtp(String phone) async {
    return await _userManagementRepository.verifySignUpOTP(
        VerifyPhoneOtpRequest(phone: phone, confirmationCode: code.value));
  }

  Future<ResendSignUpOtpResponse> resendOtp(String phone) async {
    return await _userManagementRepository
        .resendVerifyOTP(PhoneRequest(phone: phone));
  }

  Future<LoginResponse> signInWithEmail(LoginRequest request) async {
    final response = await _userManagementRepository.loginWithEmail(
        LoginRequest(
            userNameOrEmailAddress: request.userNameOrEmailAddress,
            password: request.password));
    if (response.success) {
      if (response.result!.accessToken != null) {
        setToken(response.result!.accessToken!);
        setId(response.result!.userId!);
      }
    }
    return response;
  }

  Future<bool> setToken(String token) async {
    final result = await _userInfoRepository.setToken(token);
    return result;
  }

  Future<bool> setId(int id) async {
    final result = await _userInfoRepository.setId(id);
    return result;
  }

  Future<bool> VerifyPhone(String Phone) async {
    final result = await _userManagementRepository.verifyOTPToPhone(
        phone: Phone, code: code.value);
    return result;
  }

  Future<bool> VerifyEmail(String email) async {
    final result = await _userManagementRepository.verifyOTPToEmail(
        email: email, code: code.value);
    return result;
  }
}
