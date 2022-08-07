import 'dart:convert';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import 'package:chefsandmeals_customer/src/models/requests/index.dart';
import 'package:chefsandmeals_customer/src/models/requests/login_with_social_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/login_with_social_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/signup_response.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/user_management_repository.dart';

// import 'package:sign_in_apple/apple_id_user.dart';
// import 'package:sign_in_apple/sign_in_apple.dart';

class SignUpController extends GetxController {
  final UserManagementRepository _userManagementRepository =
      Get.put(UserManagementRepository());
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());
  final firstName = "".obs;
  final lastName = "".obs;
  final email = "".obs;
  final phone = "".obs;
  final password = "".obs;
  final confirmPassword = "".obs;

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  final initialDialCode = "+1".obs;

  final initialIsoCode = "US".obs;

  Future<SignUpResponse> signUpWithEmail() async {
    return await _userManagementRepository.signUp(SignUpRequest(
        firstName: firstName.value,
        lastName: lastName.value,
        emailAddress: email.value,
        phoneNumber: phone.value,
        password: password.value));
  }

  Future<bool> setToken(String token) async {
    final result = await _userInfoRepository.setToken(token);
    return result;
  }

  Future<bool> setId(int id) async {
    final result = await _userInfoRepository.setId(id);
    return result;
  }

  Future<bool> setContactId(int id) async {
    final result = await _userInfoRepository.setContactId(id);
    return result;
  }

  Future<LoginWithSocialResponse> signInWithGoogle() async {
    GoogleSignInAccount? _currentUser;
    GoogleSignIn _googleSignIn = GoogleSignIn();
    _currentUser = await _googleSignIn.signIn();
    List<String> name = _currentUser!.displayName!.split(" ");

    final firstName = name.first;
    final lastName = name.last;
    final encoded = base64.encode(utf8.encode(_currentUser.photoUrl!));
    LoginWithSocialRequest loginWithSocialRequest = LoginWithSocialRequest(
        firstName: firstName,
        lastName: lastName.isNotEmpty ? lastName : firstName,
        email: _currentUser.email,
        provider: "Google",
        providerKey: _currentUser.id,
        picture: encoded);
    final loginResponse = await _userManagementRepository.SignInWithSocial(
        loginWithSocialRequest);
    if (loginResponse.success) {
      if (loginResponse.result!.accessToken != null) {
        setToken(loginResponse.result!.accessToken!);
        setId(loginResponse.result!.userId!);
        setContactId(loginResponse.result!.contactId!);
      }
    }
    return loginResponse;
  }

  Future<LoginWithSocialResponse> loginWithFacebook() async {
    var user;
    var _facebookAuth = await FacebookAuth.instance;
    final result = await _facebookAuth.login();
    final token = await _facebookAuth.accessToken;
    if (result.status == LoginStatus.success) {
      user = await _facebookAuth.getUserData(fields: "id,name,email,picture");
    }
    final pic = user['picture']['data']['url'];
    final encoded = base64.encode(utf8.encode(pic));
    List<String> name = user['name'].split(" ");
    final firstName = name.first;
    final lastName = name.last;
    final email = user['email'];
    final id = user['id'];
    LoginWithSocialRequest loginWithSocialRequest = LoginWithSocialRequest(
        firstName: firstName,
        lastName: lastName.isEmpty ? firstName : lastName,
        email: email,
        provider: "Facebook",
        providerKey: id,
        picture: encoded);
    print("${loginWithSocialRequest.toJson()}");
    final loginResponse = await _userManagementRepository.SignInWithSocial(
        loginWithSocialRequest);
    if (loginResponse.success) {
      if (loginResponse.result!.accessToken != null) {
        setToken(loginResponse.result!.accessToken!);
        setId(loginResponse.result!.userId!);
        setContactId(loginResponse.result!.contactId!);
      }
    }
    return loginResponse;
  }

  Future<LoginWithSocialResponse?> signInWithApple() async {
    final AuthorizationResult result = await TheAppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        return await _loginWithSocial(result.credential!);

      case AuthorizationStatus.error:
        break;

      case AuthorizationStatus.cancelled:
        print('User cancelled');
        break;
    }
    return null;
  }

  Future<LoginWithSocialResponse> _loginWithSocial(
      AppleIdCredential user) async {
    LoginWithSocialRequest loginWithSocialRequest = LoginWithSocialRequest(
      firstName: user.fullName!.givenName!,
      lastName: user.fullName!.familyName,
      email: user.email ?? "",
      provider: "Apple",
      providerKey: user.user!,
      // picture: encoded,
    );
    print("${loginWithSocialRequest.toJson()}");
    final loginResponse = await _userManagementRepository.SignInWithSocial(
        loginWithSocialRequest);
    if (loginResponse.success) {
      if (loginResponse.result!.accessToken != null) {
        setToken(loginResponse.result!.accessToken!);
        setId(loginResponse.result!.userId!);
        setContactId(loginResponse.result!.contactId!);
      }
    }
    return loginResponse;
  }
}
