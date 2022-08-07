import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/requests/index.dart';
import 'package:chefsandmeals_customer/src/models/responses/index.dart';
import 'package:chefsandmeals_customer/src/repositories/user_management_repository.dart';

class ResetPasswordController extends GetxController {
  final UserManagementRepository _userManagementRepository =
      Get.put(UserManagementRepository());
  final isRetypePasswordVisible = true.obs;
  final isPasswordVisible = true.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;

  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) {
    return _userManagementRepository.resetPassword(request);
  }

  Future<LoginResponse> signInWithEmail(String email) async {
    final response = await _userManagementRepository.loginWithEmail(
        LoginRequest(userNameOrEmailAddress: email, password: password.value));
    return response;
  }
}
